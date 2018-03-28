//
//  TwoWayViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/7.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "TwoWayViewController.h"
#import "KeyViewController.h"
#import <YYKit.h>
static NSString *identifier = @"cellID";
@interface TwoWayViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
}
@property(nonatomic, strong) NSMutableArray      *dataSource;
@property (nonatomic, strong) UICollectionView* collectionView;
@end

@implementation TwoWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:self.collectionView];
}
#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataSource objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell.contentView removeAllSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:[dic objectForKey:@"img"]]];
    imageView.frame = CGRectMake(0, 15, 50, 50);
    imageView.centerX = cell.contentView.centerX;
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, SCREEN_WIDTH/4, 30)];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = [dic objectForKey:@"title"];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:name];
    
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat row = indexPath.row + 1 ;
    if ( row > 0 && row <= 4) {
        KeyViewController *controller = [[KeyViewController alloc]init];
        controller.setNum = row;
        [self.navigationController pushViewController:controller animated:YES];
    }
    //    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int itemW = (self.view.frame.size.width - 5*10) / 4;
    return CGSizeMake(itemW, itemW / 0.68);
}
#pragma mark - 导航栏
- (void) initNav{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    self.navigationItem.leftBarButtonItem = leftBtn;
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

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithObjects:@{
                                                         @"img":@"20111",
                                                         @"title":@"一键开关"
                                                         },
                       @{
                         @"img":@"20121",
                         @"title":@"二键开关"
                         },
                       @{
                         @"img":@"20131",
                         @"title":@"三键开关"
                         },
                       @{
                         @"img":@"20141",
                         @"title":@"四键开关"
                         },
                       @{
                         @"img":@"25111",
                         @"title":@"门磁"
                         },
                       @{
                         @"img":@"25211",
                         @"title":@"红外感应"
                         },
                       @{
                         @"img":@"25311",
                         @"title":@"一氧化碳"
                         },
                       @{
                         @"img":@"25711",
                         @"title":@"温湿度"
                         },nil];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - 返回
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.toolbarHidden = NO;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
