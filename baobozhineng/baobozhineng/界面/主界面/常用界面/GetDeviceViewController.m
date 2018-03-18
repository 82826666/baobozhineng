//
//  GetDeviceViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/17.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "GetDeviceViewController.h"
#import "UsualViewcontroller.h"
#import "CustomButtonView.h"
#define kCell_Height 44
#define BTN_WIDTH 50
@interface GetDeviceViewController ()<UITableViewDelegate,UITableViewDataSource,CustomButtonViewDelegate>{
    NSMutableArray      *dataSource;
    NSMutableArray      *sectionArray;
    NSMutableArray      *stateArray;
}
@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) NSMutableArray *cacheArr;

@end

@implementation GetDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}


-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource UITableViewDelegate
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}
//个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        return 1;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"SelectSensorViewController";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //2.如果没有找到，自己创建单元格对象
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    //设置按钮下方标题的高度
    double labelHeight = 15;
    //设置每行多少按钮
    int cellcount = 4;
    //设置每个按钮的行间距
    double left_jiange = (self.view.frame.size.width-BTN_WIDTH*cellcount)/5;
    //设置每个按钮的列艰巨
    double top_jiange =labelHeight;
    NSArray *imgArray = [dataSource objectAtIndex:indexPath.section];
    for ( int i = 0; i<imgArray.count; i++) {
        NSDictionary *dic = [imgArray objectAtIndex:i];
        NSString *imageName = [CommonCode getImageName:[[dic objectForKey:@"icon"] integerValue]];
        CustomButtonView *buttonView = [[CustomButtonView alloc]initWithFrame:CGRectMake((left_jiange+BTN_WIDTH)*(i%cellcount)+left_jiange, i/cellcount*(top_jiange+BTN_WIDTH+4)+top_jiange/2, BTN_WIDTH, BTN_WIDTH) image:[UIImage imageNamed:imageName] sup:@"开" name:@"苏打粉"];
        buttonView.delegate = self;
        buttonView.btn.tag = [[dic objectForKey:@"id"] integerValue] + 2000;
        [cell.contentView addSubview:buttonView];
//        NSDictionary *dic = [imgArray objectAtIndex:i];
//
//        UIButton *btn ;
//        NSString *imageName = [CommonCode getImageName:[[dic objectForKey:@"icon"] integerValue]];
//        //创建按钮
//        btn = [self createButton:CGRectMake((left_jiange+BTN_WIDTH)*(i%cellcount)+left_jiange, i/cellcount*(top_jiange+BTN_WIDTH+4)+top_jiange/2, BTN_WIDTH, BTN_WIDTH) Img:[UIImage imageNamed:imageName]];
//        btn.tag = [[dic objectForKey:@"id"] integerValue];
//        //按钮的响应事件，通过tag来判断是那个按钮
//        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//
//
//        UILabel *label = [self createLabel:CGRectMake(btn.frame.origin.x, CGRectGetMaxY(btn.frame), btn.frame.size.width, labelHeight) title:[dic objectForKey:@"name"]];
//        label.textColor = RGBA(88, 88, 88, 1.0);
//        label.textAlignment = NSTextAlignmentCenter;
//        label.font = [UIFont systemFontOfSize:10];
//        [cell.contentView addSubview:btn];
//        [cell.contentView addSubview:label];
    }
    return cell;
}
//头部
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return sectionArray[section];
}
//头部内容
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *headerLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, button.frame.size.width, 1)];
    [headerLine setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:headerLine];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:line];
    
    //    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (kCell_Height-22)/2, 22, 22)];
    //    [imgView setImage:[UIImage imageNamed:@"ico_faq_d"]];
    //    [button addSubview:imgView];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (kCell_Height-6)/2, 10, 6)];
    if ([stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (kCell_Height-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:14]];
    [tlabel setText:sectionArray[section]];
    [button addSubview:tlabel];
    return button;
}

#pragma mark headButton点击
- (void)buttonPress:(UIButton *)sender{
    //判断状态值
    if ([stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 1] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = [dataSource objectAtIndex:indexPath.section];
    NSInteger row = ceil(array.count / 4);
    if((array.count % 4) > 0){
        row = row + 1;
    }
    return row * (BTN_WIDTH + 30) + 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}
//创建按钮
- (UIButton *)createButton:(CGRect)frame Img:(UIImage *)img
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    return  btn;
}
//创建label
- (UILabel*)createLabel:(CGRect)frame title:(NSString*)title
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = title;
    lab.adjustsFontSizeToFitWidth= YES;
    return  lab;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
-(void)loadData{
    if (_cacheArr == nil) {
        _cacheArr = [NSMutableArray new];
    }
    NSLog(@"master_id%@",GET_USERDEFAULT(MASTER_ID));
    [[APIManager sharedManager]deviceGetDeviceInfoWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if (!sectionArray) {
            sectionArray  = [NSMutableArray arrayWithObjects:@"客厅",
                             @"餐厅",
                             @"主卧",
                             @"次卧",nil];
        }
        _cacheArr = [dic objectForKey:@"data"];
        NSArray *one = [dic objectForKey:@"data"];
        if (!dataSource && one.count > 0) {
            dataSource = [NSMutableArray arrayWithObjects:one, nil];
        }
        if (!stateArray) {
            stateArray = [NSMutableArray array];
            for (int i = 0; i < dataSource.count; i++)
            {
                //所有的分区都是闭合
                [stateArray addObject:@"0"];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}
-(void)sendNSNotificationCenter:(NSDictionary*)dic{
    //创建通知
    NSNotification *notification = [NSNotification notificationWithName:@"setThenDic" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
-(void)didClickBtn:(UIButton *)button{
    NSLog(@"tag:%@",_cacheArr);
    for (int i = 0; i < _cacheArr.count; i++) {
        NSDictionary *dic = [_cacheArr objectAtIndex:i];
        
        NSInteger ids = [[dic objectForKey:@"id"] integerValue];
        if (ids == (button.tag - 2000)) {
            NSDictionary *device = @{
                                     @"master_id":GET_USERDEFAULT(MASTER_ID),
                                     @"device_id":[dic objectForKey:@"id"],
                                     @"ch":@"1",
                                     @"type":[dic objectForKey:@"type"],
                                     @"devid":[dic objectForKey:@"devid"]
                                     };
            [[APIManager sharedManager]deviceAddDeviceShortcutWithParameters:device success:^(id data) {
                NSDictionary *datadic = data;
                NSLog(@"data:%@",data);
                if([[datadic objectForKey:@"code"] intValue] == 200){
                    [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
                    [self.navigationController pushViewController:[UsualViewcontroller shareInstance] animated:YES];
                }else{
                    [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
                }
            } failure:^(NSError *error) {
                
            }];
            break;
        }
    }
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
