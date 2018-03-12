//
//  CommontViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/7.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "CommontViewController.h"
#import "UIButton+CenterImageAndTitle.h"
#import "TextFieldAlertViewController.h"
#import "SwitchIconSelectViewController.h"
#import "TablePopViewController.h"
#import "UsualViewcontroller.h"

@interface CommontViewController (){
    NSMutableArray      *dataSource;
}
@property(nonatomic, strong) UIView *content;
@property(nonatomic, copy) UIImageView *imageView;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UILabel *nameLable;
@property(nonatomic, strong) UILabel *keyLable;
@property(nonatomic, strong) UILabel *zoneLabel;
@property(nonatomic, strong) NSMutableArray *deviceArr;
@property(nonatomic, strong) NSString *cacheImageName;
@end

@implementation CommontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self uiSet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initNav{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = @"一键开关";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)uiSet{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 100)];
//    buttonView.backgroundColor = [UIColor redColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 1000;
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25, 20, 50, 50)];
    _imageView.image = [UIImage imageNamed:@"in_equipment_lamp_default"];
    _cacheImageName = @"in_equipment_lamp_default";
    _label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 20, 70, 100, 30)];
    _label.text = @"1键";
    [btn addSubview:_imageView];
    [btn addSubview:_label];
    [buttonView addSubview:btn];
    
    UIButton *btn1 = [self getBtn:@"开关名称" fat:0];
    btn1.tag = 1001;
    [btn1 addSubview:[self getFirstLine]];
    _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 50, 10, 50, 30)];
    _nameLable.text = @"1键";
    [btn1 addSubview:_nameLable];
    [btn1 addSubview:[self getLastLine]];
    
    UIButton *btn2 = [self getBtn:@"按钮图标" fat:50];
    btn2.tag = 1002;
    [btn2 addSubview:[self getLastLine]];
    
    UIButton *btn3 = [self getBtn:@"按键名称" fat:100];
    btn3.tag = 1003;
    _keyLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25 - 50, 10, 50, 30)];
    [btn3 addSubview:_keyLable];
    [btn3 addSubview:[self getLastLine]];
    
    UIButton *btn4 = [self getBtn:@"按键区域" fat:150];
    btn4.tag = 1004;
    _zoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 25 - 50, 10, 50, 30)];
    [btn4 addSubview:_zoneLabel];
    [btn4 addSubview:[self getLastLine]];
    
    [self.view addSubview: buttonView];
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
}

- (void)click:(UIButton*)sender{
    if (sender.tag == 1000) {
        
    }else if (sender.tag == 1001){
        TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
        [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
            if(text.length!=0){
                _label.text = [NSString stringWithFormat:@"%@",text];
                _nameLable.text = [NSString stringWithFormat:@"%@",text];
            }
        } Cancle:^(NSString *text) {
            
        }];
        [textfieldAlert showWithParentViewController:nil];
        [textfieldAlert showPopupview];
    }else if (sender.tag == 1002){
        SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
        [switchIcon setImgArray:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight",@"in_equipment_lamp_mirrorlamp",@"in_equipment_lamp_downlight",@"in_equipment_lamp_chandelier",@"in_equipment_aiming_default"] titleArray:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯",@"壁灯",@"浴灯",@"吊灯",@"白织灯"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
            //按钮的返回事件
            _cacheImageName = imagestr;
            _imageView.image = [UIImage imageNamed:imagestr];
        }] ;
        [switchIcon showWithParentViewController:nil];
        [switchIcon showPopupview];
    }else if (sender.tag == 1003){
        TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
        [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
            if(text.length!=0){
                _keyLable.text = text;
            }
        } Cancle:^(NSString *text) {
            
        }];
        [textfieldAlert showWithParentViewController:nil];
        [textfieldAlert showPopupview];
    }else if (sender.tag == 1004){
        TablePopViewController *switchIcon = [TablePopViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:TABLEPOPVIEWCONTROLLER];
        [ switchIcon setTitleLabel:@"选择区域" CellTitleArray:@[@"客厅",@"餐厅",@"主卧",@"次卧",@"书房",@"走廊",@"厨房",@"浴室"] Block:^(id dataArray) {
            if(dataArray != nil){
                NSDictionary* data = dataArray[0];
                _zoneLabel.text = [data objectForKey:@"selectTitle"];
            }else{
                
            }
        }];
        [switchIcon showWithParentViewController:nil];
        [switchIcon showPopupview];
    }
}

-(UIButton*)getBtn:(NSString*)str fat:(CGFloat)fat{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(0, 330 + fat, SCREEN_WIDTH, 50);
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    label1.text = str;
    [btn1 addSubview:label1];
    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20, 15, 10, 20)];
    rightView.image = [UIImage imageNamed:@"in_arrow_right"];
    [btn1 addSubview:rightView];
    return btn1;
}

- (UIView*)getFirstLine{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    return line1;
}
- (UIView*)getLastLine{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    return line1;
}
- (void)viewWillAppear:(BOOL)animated{
//    [self loadData];
}
-(void)loadData{
    [[APIManager sharedManager]deviceGetDevidWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *res = data;
        NSInteger code = [[res objectForKey:@"code"]integerValue];
        if (code == 200) {
            [self.deviceArr addObject:[res objectForKey:@"data"]];
            NSLog(@"devicearr:%@",self.deviceArr);
        }else{
            NSLog(@"shibai");
        }
    } failure:^(NSError *error) {
        
    }];
}

-(NSMutableArray*)deviceArr{
    if(_deviceArr == nil){
        _deviceArr = [NSMutableArray new];
    }
    return _deviceArr;
}

-(void)saveData{
    NSString *text = _label.text;
    if (text == nil) {
        text = @"1键";
    }
    NSDictionary *dic = @{
                          @"icon":_cacheImageName,
                          @"name":text,
                          @"ch":@"1",
                          @"status":@"0",
                          @"order":@"0"
                          };
    NSMutableArray *setting = [NSMutableArray new];
    [setting addObject:dic];
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"name":_nameLable.text == nil ? @"1键开关" : _nameLable.text,
                             @"type":@"20111",
                             @"room_id":@"1",
                             @"setting":[CommonCode formatToJson:setting],
                             @"icon":[CommonCode getImageType:@"in_equipment_switch_one"],
                             @"mac":@"2343434"
                             };
    [[APIManager sharedManager]deviceAddTwowaySwitchWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        if([[datadic objectForKey:@"code"] intValue] == 200){
            [self.navigationController pushViewController:[UsualViewcontroller shareInstance] animated:YES];
        }else{
            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        NSLog(@"123");
    }];
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSString*)cacheImageName{
    if (_cacheImageName == nil) {
        _cacheImageName = [NSString new];
    }
    return _cacheImageName;
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
