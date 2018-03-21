//
//  ComontSensorViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/20.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "ComontSensorViewController.h"
#import <YYKit.h>
#import "TextFieldAlertViewController.h"
#import "SwitchIconSelectViewController.h"
#import "TablePopViewController.h"
#import "UIButton+CenterImageAndTitle.h"
#import "UsualViewcontroller.h"

@interface ComontSensorViewController (){
    
}
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UILabel *nameLable;
@property(nonatomic, strong) UILabel *keyLable;
@property(nonatomic, strong) UILabel *zoneLabel;
@end

@implementation ComontSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    [self initNav];
    // Do any additional setup after loading the view.
}

- (void) initNav{
    NSString *name;
    if ([_type integerValue] == 25111) {//门磁
        name = @"门磁传感器";
    }else if ([_type integerValue] == 25211){//红外
        name = @"红外传感器";
    }else if ([_type integerValue] == 25311){//一氧化碳
        name = @"一氧化碳传感器";
    }else if ([_type integerValue] == 25711){//温湿度
        name = @"温湿度传感器状态";
    }
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = name;
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadUI{
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *imagestr;
    NSString *name;
    if ([_type integerValue] == 25111) {//门磁
       imagestr = @"in_sensor_control_induction";
        name = @"传感器状态";
    }else if ([_type integerValue] == 25211){//红外
        imagestr = @"in_equipment_sensor_infrared";
        name = @"传感器状态";
    }else if ([_type integerValue] == 25311){//一氧化碳
        imagestr = @"in_equipment_sensor_co";
        name = @"传感器状态";
    }else if ([_type integerValue] == 25711){//温湿度
        imagestr = @"in_equipment_sensor_temperature";
        name = @"传感器状态";
    }
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setImage:[UIImage imageNamed:imagestr] forState:UIControlStateNormal];
    _btn.imageView.image.accessibilityIdentifier = imagestr;
    _btn.height = 200;
    _btn.width = SCREEN_WIDTH;
    _btn.centerX = self.view.centerX;
    NSLog(@"widht:%f",_btn.bottom);
    
    UILabel *label = [[UILabel alloc]init];
    label.text = name;
    label.frame = CGRectMake(0, _btn.bottom - 50, SCREEN_WIDTH, 30);
    label.width = SCREEN_WIDTH;
    label.textAlignment = NSTextAlignmentCenter;
    [_btn addSubview:label];
    [self.view addSubview:_btn];
    
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
    
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
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

- (void)click:(UIButton*)sender{
    if (sender.tag == 1000) {
        
    }else if (sender.tag == 1001){
            TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
            [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
                if(text.length!=0){
//                    _currentBtn.titleLabel.text = text;
                    //                    _label.text = [NSString stringWithFormat:@"%@",text];
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
                
                [_btn setImage:[UIImage imageNamed:imagestr] forState:UIControlStateNormal];
                _btn.imageView.image.accessibilityIdentifier = imagestr;
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

- (UIView*)getLastLine{
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    return line1;
}

-(UIButton*)getBtnOne:(UIImage*)image btnName:(NSString*)name{
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button1.backgroundColor = [UIColor greenColor];
    button1.titleLabel.font = [UIFont systemFontOfSize:15];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImage:image forState:UIControlStateNormal];
    [button1 setTitle:name forState:UIControlStateNormal];
    button1.layer.cornerRadius = 5;
    //    [button1 addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    return button1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveData{
    NSMutableArray *setting = [NSMutableArray new];
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"name":_nameLable.text == nil ? @"1键开关" : _nameLable.text,
                             @"type":_type,
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
