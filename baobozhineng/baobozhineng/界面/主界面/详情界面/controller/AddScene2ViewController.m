//
//  AddScene2ViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/4/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "AddScene2ViewController.h"
#import "ConditionViewController.h"
#import "AddConditionViewController.h"
#import <YYKit.h>
static NSString *identifier = @"cellID";
static NSString *headerReuseIdentifier = @"hearderID";
NS_ENUM(NSInteger,ifState){
    
    //右上角编辑按钮的两种状态；
    //正常的状态，按钮显示“编辑”;
    NormalState,
    //正在删除时候的状态，按钮显示“完成”；
    DeleteState
    
};
@interface AddScene2ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *ifArr;
@property(nonatomic, strong) NSMutableArray *thenArr;
@property(nonatomic, strong) NSMutableDictionary *week;
@property(nonatomic,assign) enum ifState;
@end

@implementation AddScene2ViewController

- (void)viewDidLoad {
    NSLog(@"token:%@",GET_USERDEFAULT(USER_TOKEN));
    [super viewDidLoad];
    ifState = NormalState;
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //最小行间距（默认是10）
    flow.minimumLineSpacing = 0;
    //创建网格对象
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //注册header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];

    [self.view addSubview:self.collectionView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 1) {
        return self.ifArr.count;
    }else if (section == 2){
        return  self.thenArr.count;
    }
    return 0;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.contentView removeAllSubviews];
    NSString *identifier = [NSString stringWithFormat:@"%ld:%ld",(long)indexPath.section,(long)indexPath.row];
    cell.accessibilityIdentifier = identifier;
    NSDictionary *dic = [self.ifArr objectAtIndex:indexPath.row];
//    NSLog(@"dic:%@",dic);
    NSString *titleText = @"";
    NSString *detailText = @"";
    CGFloat type = [[dic objectForKey:@"type"] integerValue];
    NSString *imageStr = @"20111";
    if (type == 33111) {
        NSArray *value = [dic objectForKey:@"value"];
        NSDictionary *startTime = [value objectAtIndex:0];
        NSDictionary *endTime = [value objectAtIndex:1];
        titleText = [NSString stringWithFormat:@"开始:%@:%@ 结束:%@:%@",[startTime objectForKey:@"h"],[startTime objectForKey:@"mi"],[endTime objectForKey:@"h"],[endTime objectForKey:@"mi"]];
        NSString *weekStr = [startTime objectForKey:@"w"];
        for (int i = 0; i < 7; i ++) {
//            if (i == 7) {
//                i = 0;
//            }
            
            NSString *num = [NSString stringWithFormat:@"%d",i];
            if ([weekStr rangeOfString:num].location == NSNotFound) {
//                NSLog(@"string 不存在 %@",num);
            } else {
                detailText = [NSString stringWithFormat:@"%@ %@",detailText,[self.week objectForKey:num]];
            }
        }
        detailText = [NSString stringWithFormat:@"重复星期:%@",detailText];
        imageStr = [dic objectForKey:@"type"];
    }else if (type == 20111 || type == 20121 || type == 20131 || type == 20141){
        imageStr = [dic objectForKey:@"icon1"];
        titleText = [dic objectForKey:@"name1"];
        detailText = [[dic objectForKey:@"status1"] integerValue] == 0 ? @"关" : @"开";
    }
    NSLog(@"log:%@",dic);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    imageView.image = [UIImage imageNamed:imageStr];
    
    YYLabel *title = [[YYLabel alloc]initWithFrame:CGRectMake(imageView.right + 5, 5, SCREEN_WIDTH - imageView.right - 5 - 40, 20)];
    title.font = [UIFont systemFontOfSize:12];
    title.text = titleText;
    
    YYLabel *detail = [[YYLabel alloc]initWithFrame:CGRectMake(imageView.right + 5, title.bottom, SCREEN_WIDTH - imageView.right - 5 - 40, 20)];
    detail.font = [UIFont systemFontOfSize:12];
    detail.text = detailText;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 20, 15, 20, 20)];
    rightBtn.accessibilityIdentifier = identifier;
    if (ifState == NormalState) {
        [rightBtn setImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
    }else{
        [rightBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, cell.contentView.bottom, SCREEN_WIDTH, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:title];
    [cell.contentView addSubview:detail];
    [cell.contentView addSubview:rightBtn];
    [cell.contentView addSubview:line2];
    return cell;
}

//设置collection头部/尾部
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    NSString *text = @"test";
    CGFloat sec = indexPath.section;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        [headerView removeAllSubviews];
        headerView.backgroundColor = [UIColor whiteColor];
        if (sec == 0) {
            text = @"情景名称";
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 50, headerView.height);
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
            imageView.image = [UIImage imageNamed:@"33111"];
            [btn addSubview:imageView];
            [headerView addSubview:btn];
            
            YYLabel *titleBtn = [[YYLabel alloc] initWithFrame:CGRectMake(btn.right, 0, SCREEN_WIDTH - btn.right, headerView.height)];
            titleBtn.textAlignment = NSTextAlignmentCenter;
            titleBtn.text = text;
            titleBtn.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                NSLog(@"test");
            };
            [headerView addSubview:titleBtn];
            
            UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 20, 15, 20, 20)];
            rightView.image = [UIImage imageNamed:@"箭头"];
            [headerView addSubview:rightView];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }else if (sec == 1 || sec == 2){
            CGFloat tag;
            if (sec == 1) {
                tag = 1331;
                text = @"以下所有条件满足时";
            }else if (sec == 2){
                tag = 1333;
                text = @"按步骤执行以下任务";
            }
            UIView *headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            headerLine.backgroundColor = [UIColor lightGrayColor];
            YYLabel *label = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerView.height)];
            label.text = text;
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            
            
            UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [reduceBtn setImage:[UIImage imageNamed:@"in_common_menu_reduce"] forState:UIControlStateNormal];
            reduceBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 10, 30, 30);
            reduceBtn.tag = tag;
            [reduceBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [addBtn setImage:[UIImage imageNamed:@"in_common_menu_add"] forState:UIControlStateNormal];
            addBtn.frame = CGRectMake(reduceBtn.left - 40, 10, 30, 30);
            addBtn.tag = tag + 1;
            [addBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom, SCREEN_WIDTH, 0.5)];
            line2.backgroundColor = [UIColor lightGrayColor];
            [headerView addSubview:headerLine];
            [headerView addSubview:label];
            [headerView addSubview:addBtn];
            [headerView addSubview:reduceBtn];
            [headerView addSubview:line2];
            return headerView;
        }else if (sec == 3){
            UIView *headerLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
            headerLine.backgroundColor = [UIColor lightGrayColor];
            YYLabel *label = [[YYLabel alloc]initWithFrame:CGRectMake(40, 0, 80, 50)];
            label.text = @"通知消息  ";
            YYLabel *label2 = [[YYLabel alloc]initWithFrame:CGRectMake(label.right, 0, 180, 50)];
            label2.text = @"情景自动触发时";
            label2.font = [UIFont systemFontOfSize:14];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom, SCREEN_WIDTH, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [headerView addSubview:headerLine];
            [headerView addSubview:label];
            [headerView addSubview:label2];
            [headerView addSubview:line];
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, line.bottom + 5, 40, 40)];
            imageView.image = [UIImage imageNamed:@"in_scene_message"];
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, line.bottom + 5, 200, 20)];
            title.text = @"向手机发送通知消息";
            title.font = [UIFont systemFontOfSize:14];
            UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 10, title.bottom, 200, 20)];
            detail.text = @"消息:情景名称情景已自动触发";
            detail.font = [UIFont systemFontOfSize:14];
            UISwitch *swt = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 51 - 10, line.bottom + 9.5, 51, 31)];
            UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, detail.bottom + 10, SCREEN_WIDTH, 0.5)];
            line2.backgroundColor = [UIColor lightGrayColor];
            [headerView addSubview:imageView];
            [headerView addSubview:title];
            [headerView addSubview:detail];
            [headerView addSubview:swt];
            [headerView addSubview:line2];
            return headerView;
        }
    }
    return nil;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat sec = indexPath.section;
    CGFloat row = indexPath.row;
    NSDictionary *dic;
    if (sec == 1) {
        dic = [self.ifArr objectAtIndex:row];
        CGFloat type = [[dic objectForKey:@"type"] integerValue];
        if (type == 33111) {
            AddConditionViewController *con = [AddConditionViewController new];
            con.tempDic = dic;
            con.row = row;
            [self.navigationController pushViewController:con animated:YES];
        }
    }else if (sec == 2){
        
    }
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return CGSizeMake(SCREEN_WIDTH, 100);
    }
    return CGSizeMake(SCREEN_WIDTH, 50);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 50);
}
#pragma mark ————— 方法 —————
-(void)setIfDic:(NSDictionary *)ifDic row:(CGFloat)row{
    if (row < 0) {
        [self.ifArr addObject:ifDic];
    }else{
        [self.ifArr replaceObjectAtIndex:row withObject:ifDic];
    }
    
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
}

-(void)setThenDic:(NSDictionary *)thenDic{
    [self.thenArr addObject:thenDic];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
}

-(void)click:(UIButton*)sender{
    CGFloat tag = sender.tag;
    if (tag == 1331) {
        if (ifState == DeleteState) {
            ifState = NormalState;
        }else{
            ifState = DeleteState;
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        return ;
    }else if (tag == 1332){
        ConditionViewController *con = [ConditionViewController new];
        [self.navigationController pushViewController:con animated:YES];
        return ;
    }else if (tag == 1333){
        return ;
    }else if (tag == 1334){
        return ;
    }else{
        NSArray *secRow = [sender.accessibilityIdentifier componentsSeparatedByString:@":"];
        CGFloat sec = [[secRow objectAtIndex:0] integerValue];
        CGFloat row = [[secRow objectAtIndex:1] integerValue];
        if (sec == 1) {
            [self.ifArr removeObjectAtIndex:row];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
        }else if (sec == 2){
            [self.thenArr removeObjectAtIndex:row];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:2]];
        }
    }
}

#pragma mark ————— 懒加载 —————
-(UICollectionView*)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
        
        _collectionView.dataSource = self;
        
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

-(NSMutableArray*)ifArr{
    if (_ifArr == nil) {
        _ifArr = [NSMutableArray new];
    }
    return _ifArr;
}

-(NSMutableArray*)thenArr{
    if (_thenArr == nil) {
        _thenArr = [NSMutableArray new];
    }
    return _thenArr;
}

-(NSMutableDictionary*)week{
    if (!_week) {
        _week = [[NSMutableDictionary alloc]init];
        [_week setObject:@"日" forKey:@"0"];
        [_week setObject:@"一" forKey:@"1"];
        [_week setObject:@"二" forKey:@"2"];
        [_week setObject:@"三" forKey:@"3"];
        [_week setObject:@"四" forKey:@"4"];
        [_week setObject:@"五" forKey:@"5"];
        [_week setObject:@"六" forKey:@"6"];
    }
    return _week;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
