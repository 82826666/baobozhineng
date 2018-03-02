//
//  AddSceneViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "AddSceneViewController.h"
#import "DetailViewController.h"
#import "TextfieldAlertViewController.h"
#import "CommonAdd.h"
#import "SwitchIconSelectViewController.h"
#import "ConditionViewController.h"
#import "TaskViewController.h"
@interface AddSceneViewController ()<UITableViewDataSource,UITableViewDelegate,CommonAddDelegate>{
    
}
@property(nonatomic, strong) NSMutableArray* ifArr;
@property(nonatomic, strong) NSMutableArray *thenArr;
@property(nonatomic, strong) NSMutableArray* dataSouce;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UILabel *buttonLable;
@property(nonatomic, strong) UIColor *backColor;
@property(nonatomic, strong) RecodeTableViewCell *cell;
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UISwitch *swt;
@end

@implementation AddSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
//    [self initDataSouce];
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
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void) save{
    NSDictionary *params = @{
                             @"master_id":@"6",
                             @"name":@"test",
                             @"icon":@"in_scene_default.png",
                             @"condition":[CommonCode formatToJson:_ifArr],
                             @"action":[CommonCode formatToJson:_thenArr],
                             @"message":@"test",
                             @"is_push":@"1",
                             @"enable":@"1"
                             };
    NSLog(@"params:%@",params);
    [[APIManager sharedManager]deviceAddSceneWithParameters:params success:^(id data) {
        NSLog(@"ns:%@",data);
        NSDictionary *dic = data;
        NSInteger code = [[dic objectForKey:@"code"] integerValue];
        if (code == 0) {
            NSLog(@"msg:%@",[data objectForKey:@"msg"]);
        }else{
            DetailViewController *controller = [[DetailViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    } failure:^(NSError *error) {
        NSLog(@"saf:%@",error);
    }];
}
- (void)initDataSouce{
    NSDictionary *one = @{@"img":@"in_scene_default.png",@"title":@"定时开",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *two = @{@"img":@"in_scene_select_leavehome.png",@"title":@"商家模式",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *three = @{@"img":@"in_scene_select_getup.png",@"title":@"起床设置",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    if(_dataSouce == nil){
        _dataSouce = [[NSMutableArray alloc]initWithObjects:one,two,three,nil];
    }
}

#pragma tableview datasouce
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 1;
    }else if (section == 1){
        return _thenArr.count > 0 ? _thenArr.count : 0;
    }
    return _ifArr.count > 0 ? _ifArr.count : 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    _cell = [RecodeTableViewCell cellWithTableView:tableView];
//    _cell.backgroundColor = self.backColor;
//    [_cell setData:_dataSouce[indexPath.row]];
    //1.根据reuseIdentifier，先到对象池中去找重用的单元格对象
    static NSString *reuseIdentifier = @"contactCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //2.如果没有找到，自己创建单元格对象
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = self.backColor;
    }
    
    
    if (indexPath.section == 2) {
        //3.设置单元格对象的内容
        
        //设置图像
        [cell.imageView setImage:[UIImage imageNamed:@"in_scene_default.png"]];
        
        //设置字体颜色
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.textColor = [UIColor blueColor];
        //设置主标题
        cell.textLabel.text = @"向手机发送通知消息";
        //设置副标题
        cell.detailTextLabel.text = @"消息：情景名称 情景 已自动触发";
        cell.accessoryType = UITableViewCellAccessoryNone;
        _swt = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 71, 10, 51, 31)];
        [cell.contentView addSubview:_swt];
    }else{
        
        
        NSDictionary *dic = [_ifArr objectAtIndex:indexPath.row];
        NSInteger type = [[dic objectForKey:@"type"] integerValue];
        if (type == 33111) {
            //3.设置单元格对象的内容
            //设置图像
            [cell.imageView setImage:[UIImage imageNamed:@"in_scene_default"]];
            NSArray *arr = [dic objectForKey:@"value"];
            NSDictionary *one = [arr objectAtIndex:0];
            NSDictionary *two = [arr objectAtIndex:1];
            //设置主标题
            cell.textLabel.text = [NSString stringWithFormat:@"开始%@:%@ 结束%@:%@",[one objectForKey:@"h"],[one objectForKey:@"mi"],[two objectForKey:@"h"],[two objectForKey:@"mi"]];
            //设置副标题
            cell.detailTextLabel.text = @"星期";
        }
        
        //设置字体颜色
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.detailTextLabel.textColor = [UIColor blueColor];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    [cell setSeparatorInset:UIEdgeInsetsZero];
    return cell;
}
//每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectZero];
    return v;
}
//头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 100;
    }
    return 50;
}
//头部内容
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat height = 50;
    CGFloat centerHeight = height / 2;
    if (section == 0) {
        UIView *supper = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height*2)];
        supper.backgroundColor = self.backColor;
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.frame = CGRectMake(0, 0, 57, height);
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, centerHeight - 18, 37, 37)];
        _leftImageView.image = [UIImage imageNamed:@"in_scene_default.png"];
        [leftBtn addSubview:_leftImageView];
        [supper addSubview:leftBtn];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftBtn.frame.size.width, 0, SCREEN_WIDTH - leftBtn.frame.size.width, height);
        [btn addTarget:self action:@selector(nameClick:) forControlEvents:UIControlEventTouchUpInside];
        _buttonLable = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - leftBtn.frame.size.width)/2 - 20 / 2, centerHeight - 10, SCREEN_WIDTH - 50 - 40, 20)];
        _buttonLable.text = @"test";
        UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 27 - leftBtn.frame.size.width, centerHeight - 8, 9, 17)];
        rightImageView.image = [UIImage imageNamed:@"in_arrow_right"];
        [btn addSubview:_buttonLable];
        [btn addSubview:rightImageView];
        [supper addSubview:btn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 - 0.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [supper addSubview:lineView];
        
        UIButton *addBtn = [UIButton new];
        addBtn.tag = 1000;
        [addBtn setImage:[UIImage imageNamed:@"in_common_menu_add"] forState:UIControlStateNormal];
        UIButton *reduceBtn = [UIButton new];
        reduceBtn.tag = 1001;
        [reduceBtn setImage:[UIImage imageNamed:@"in_common_menu_reduce"] forState:UIControlStateNormal];
        CommonAdd *addView = [[CommonAdd alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, height) title:@"以下所有条件满足时" addBtn:addBtn reduceBtn:reduceBtn image:nil];
        addView.backColor = self.backColor;
        addView.delegate = self;
        [supper addSubview:addView];
        return supper;
    }else if (section == 1){
        UIView *supper = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
        UIButton *addBtn = [UIButton new];
        addBtn.tag = 1002;
        [addBtn setImage:[UIImage imageNamed:@"in_common_menu_add"] forState:UIControlStateNormal];
        UIButton *reduceBtn = [UIButton new];
        reduceBtn.tag = 1003;
        [reduceBtn setImage:[UIImage imageNamed:@"in_common_menu_reduce"] forState:UIControlStateNormal];
        CommonAdd *addView = [[CommonAdd alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) title:@"按步骤执行以下任务" addBtn:addBtn reduceBtn:reduceBtn image:nil];
        addView.backColor = self.backColor;
        addView.delegate = self;
        [supper addSubview:addView];
        return supper;
    }
    UIView *supper = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    UILabel *msg1Label = [[UILabel alloc]initWithFrame:CGRectMake(40, centerHeight - 10, 80, 20)];
    msg1Label.text = @"通知消息";
    UILabel *msg2Label = [[UILabel alloc]initWithFrame:CGRectMake(120, centerHeight - 10, SCREEN_WIDTH -120, 20)];
    msg2Label.text = @"情景自动触发时";
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [supper addSubview:msg1Label];
    [supper addSubview:msg2Label];
    msg2Label.textColor = [UIColor colorWithRed:148/255.0 green:165/255.0 blue:177/255.0 alpha:1];
    [supper addSubview:lineView];
    return supper;
    
}
#pragma mark 添加和减少按钮点击
-(void)didClickBtn:(UIButton *)button currentView:(UIView *)currentView titleLabel:(UILabel *)titleLabel{
    if(button.tag == 1000){
        ConditionViewController *condition = [[ConditionViewController alloc] init];
        [self.navigationController pushViewController:condition animated:YES];
    }else if (button.tag == 1002){
        TaskViewController *condition = [[TaskViewController alloc] init];
        [self.navigationController pushViewController:condition animated:YES];
    }
    NSLog(@"test:%@",titleLabel.text);
}
#pragma mark 返回
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 情景图标修改
-(void)leftBtnClick:(UIButton*)sender{
    SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
    [switchIcon setImgArray:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight",@"in_equipment_lamp_mirrorlamp",@"in_equipment_lamp_downlight",@"in_equipment_lamp_chandelier",@"in_equipment_aiming_default"] titleArray:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯",@"壁灯",@"浴灯",@"吊灯",@"白织灯"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
        //按钮的返回事件
        _leftImageView.image = [UIImage imageNamed:imagestr];
        [_leftImageView.image setAccessibilityIdentifier:imagestr];
    }] ;
    [switchIcon showWithParentViewController:nil];
    [switchIcon showPopupview];
}

#pragma mark 修改名称
- (void)nameClick:(UIButton*)sender{
    TextFieldAlertViewController *textalert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
    [textalert setTitle:@"添加情景名称" EnterBlock:^(NSString *text) {
        if (text) {
            _buttonLable.text = text;
        }
    } Cancle:^(NSString *text) {
        
    }];
    [textalert showWithParentViewController:nil];
    [textalert showPopupview];
}


#pragma mark 懒加载
- (UITableView*) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60) style:UITableViewStyleGrouped];
        _tableView.delegate = self;;
        _tableView.dataSource = self;
        _tableView.backgroundColor = self.backColor;
        //        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}
- (UIColor*)backColor{
    if(!_backColor){
        _backColor = [UIColor colorWithRed:233/255.0 green:241/255.0 blue:245/255.0 alpha:1];
    }
    return _backColor;
}
-(void)setDic:(NSDictionary *)dic{
    if (_ifArr == nil) {
        _ifArr = [[NSMutableArray alloc]init];
    }
    [_ifArr addObject:dic];
    [_tableView reloadData];
}
-(void)setThenDic:(NSDictionary *)thenDic{
    if (_thenArr == nil) {
        _thenArr = [[NSMutableArray alloc]init];
    }
    [_thenArr addObject:thenDic];
    [_tableView reloadData];
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
