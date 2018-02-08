//
//  AddSceneViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "AddSceneViewController.h"
#import "TextfieldAlertViewController.h"
@interface AddSceneViewController ()

@end

@implementation AddSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initDataSouce];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initNav{
    
    //    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleDone target: self action:@selector(message)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    //    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationItem.title = @"情景触发记录";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    //    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)initDataSouce{
    NSDictionary *one = @{@"img":@"in_scene_default.png",@"title":@"定时开",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *two = @{@"img":@"in_scene_select_leavehome.png",@"title":@"商家模式",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *three = @{@"img":@"in_scene_select_getup.png",@"title":@"起床设置",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    if(_dataSouce == nil){
        _dataSouce = [[NSMutableArray alloc]initWithObjects:one,two,three,nil];
    }
}
//懒加载
- (UITableView*) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate = self;;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}
#pragma tableview datasouce
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSouce.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecodeTableViewCell *cell  = [RecodeTableViewCell cellWithTableView:tableView];
    [cell setData:_dataSouce[indexPath.row]];
    return cell;
}
//每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
//头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 120;
    return UITableViewAutomaticDimension;
}
//头部内容
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIColor *lineColor = RGBA(213, 218, 222, 1.0);
    UIView *supperView = [[UIView alloc] initWithFrame:CGRectZero];
    supperView.backgroundColor = [UIColor whiteColor];//RGBA(235, 240, 244, 1.0);
    
    
    
    UIButton *supperButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [supperButton addTarget:self action:@selector(nameClick:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *leftImageView = [UIImageView new];
    leftImageView.image = [UIImage imageNamed:@"in_scene_default.png"];
    [supperButton addSubview:leftImageView];
    UIView *centerView = [UIView new];
    _buttonLable = [UILabel new];
    _buttonLable.text = @"情景名称";//in_common_menu_add in_common_menu_reduce

    [centerView addSubview:_buttonLable];
    [supperButton addSubview:centerView];
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = [UIImage imageNamed:@"in_arrow_right"];
    [supperButton addSubview:rightImageView];
    [supperView addSubview:supperButton];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = lineColor;
    [supperView addSubview:lineView];
    
    
    UIView* lastView = [UIView new];
    UIView *labelView = [UIView new];
    [lastView addSubview:labelView];
    UILabel *conditionLabel = [UILabel new];
    conditionLabel.text = @"以下所有条件满足时候";
    [labelView addSubview:conditionLabel];
    [lastView addSubview:labelView];
    UIStackView *stackView = [UIStackView new];
    stackView.axis = MASAxisTypeHorizontal;

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImage:[UIImage imageNamed:@"in_common_menu_add"] forState:UIControlStateNormal];
    [stackView addSubview:addBtn];

    UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reduceBtn addTarget:self action:@selector(reduceClick:) forControlEvents:UIControlEventTouchUpInside];
    [reduceBtn setImage:[UIImage imageNamed:@"in_common_menu_reduce"] forState:UIControlStateNormal];
    [stackView addSubview:reduceBtn];
    [lastView addSubview:stackView];
    [supperView addSubview:lastView];

    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = lineColor;
    [supperView addSubview:lineView2];
    
    
    int top = 5;
    [supperButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(supperView.mas_top).offset(top);
        make.left.equalTo(supperView.mas_left).offset(20);
        make.right.equalTo(supperView.mas_right).offset(-20);
    }];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(supperButton.mas_top).offset(top);
        make.left.equalTo(supperButton.mas_left).offset(0);
        make.size.mas_equalTo(CGSizeMake(42, 42));
    }];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftImageView.mas_right).offset(52);
        make.right.equalTo(rightImageView.mas_left).offset(30);
    }];
    [_buttonLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(supperView.mas_left).offset(68);
        make.top.equalTo(supperButton.mas_top).offset(top + 10);
//        make.center.equalTo(centerView);
    }];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(supperButton.mas_top).offset(top + 10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.right.equalTo(supperButton.mas_right).offset(0);
//        make.centerX.equalTo(supperButton.mas_centerX).offset(0);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(supperButton.mas_bottom).offset(20);
    }];
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(15);
        make.left.equalTo(supperView.mas_left).offset(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_bottom).offset(5);
        make.left.equalTo(supperView.mas_left).offset(20);
    }];
    [conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelView.mas_top).offset(0);
        make.left.equalTo(labelView.mas_left).offset(10);
    }];
    [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.mas_top).offset(0);
        make.right.equalTo(supperView.mas_right).offset(-20);
    }];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackView.mas_top).offset(0);
        make.right.equalTo(reduceBtn.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stackView.mas_top).offset(0);
        make.right.equalTo(lastView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(stackView.mas_bottom).offset(45);
    }];
    return supperView;
}
//修改名称
- (void)nameClick:(UIButton*)sender{
    TextFieldAlertViewController *textalert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
    [textalert setTitle:@"添加情景名称" EnterBlock:^(NSString *text) {
        _buttonLable.text = text;
        //返回的主机名称
        NSLog(@"%@",text);
    } Cancle:^(NSString *text) {
        
    }];
    [textalert showWithParentViewController:nil];
    [textalert showPopupview];
}
//添加
- (void)addClick:(UIButton*)sender{
    NSLog(@"addClick");
}
//减少
- (void)reduceClick:(UIButton*)sender{
    NSLog(@"reduceClick");
}
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
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
