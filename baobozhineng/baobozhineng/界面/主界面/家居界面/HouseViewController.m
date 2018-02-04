//
//  HouseViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/1.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "HouseViewController.h"
#define kCell_Height 44
@interface HouseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray      *dataSource;
    NSMutableArray      *sectionArray;
    NSMutableArray      *stateArray;
}
@property (nonatomic, strong) UITableView         *tableView;
@end

@implementation HouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initDataSource];
    [self initTable];
    // Do any additional setup after loading the view.
}
- (void) initNav{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.title = @"家居";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;//设置导航栏目颜色
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDataSource
{
    sectionArray  = [NSMutableArray arrayWithObjects:@"关于直销银行",
                     @"关于理财产品",
                     @"关于我的投资",
                     @"安全中心",nil];
    
    NSArray *one = @[@"关于直销银行1",@"关于直销银行2",@"关于直销银行3"];
    NSArray *two = @[@"如何购买？",@"如何赎回？",@"业务办理时间？"];
    NSArray *three = @[@"关于我的投资1",@"关于我的投资2",@"关于我的投资3"];
    NSArray *four = @[@"安全中心1",@"安全中心2",@"安全中心3",@"安全中心4"];
    
    dataSource = [NSMutableArray arrayWithObjects:one,two,three,four, nil];
    stateArray = [NSMutableArray array];
    
    for (int i = 0; i < dataSource.count; i++)
    {
        //所有的分区都是闭合
        [stateArray addObject:@"0"];
    }
}

-(void)initTable{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
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
        NSArray *array = [dataSource objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseTableViewCell *cell = [HouseTableViewCell cellWithTableView:tableView];
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithObjects:@"1", nil];
    [cell setDataArray:dataArray];
//        static NSString *ID = @"cell";
//    // 根据标识去缓存池找cell
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    // 不写这句直接崩掉，找不到循环引用的cell
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text = dataSource[indexPath.section][indexPath.row];
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
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
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
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kCell_Height;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//    self.tabBarController.tabBar.hidden = NO;
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
