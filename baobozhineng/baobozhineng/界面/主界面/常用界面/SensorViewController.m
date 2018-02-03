//
//  SensorViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/4.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//  传感器界面

#import "SensorViewController.h"
#import "TextFieldAlertViewController.h"
#import "LearningAlertViewController.h"
#import "SwitchIconSelectViewController.h"
#import "TablePopViewController.h"
@interface SensorViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sensorAreaLab;
@property (weak, nonatomic) IBOutlet UILabel *sensorNameLab;
@property (weak, nonatomic) IBOutlet UIButton *senseImageBtn;


@end

@implementation SensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)saveAction:(id)sender {
    
}
- (IBAction)beginLearning:(id)sender {
    
    LearningAlertViewController *textAlert = [LearningAlertViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:LEARNINGALERTVIEWCONTROLLER];
    [textAlert setTitle:@"学习中" learning:@"请将传感器进入触发状态" Cancle:^(NSString *text) {
        
    }];
    [textAlert showWithParentViewController:nil];
    [textAlert showPopupview];
    NSLog(@"learning");
}
- (IBAction)sensorIconAction:(id)sender {
    SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
    
    [switchIcon setImgArray:@[@"in_select_sensor_default",@"in_sensor_control_infrared",@"in_select_sensor_induction",@"in_sensor_control_temperature",@"in_sensor_control_humidity",@"in_sensor_control_co",@"in_select_sensor_smoke",@"in_select_sensor_immersion",@"in_sensor_control_gas",@"in_sensor_control_pushwindow"] titleArray:@[@"默认图标",@"红外传感器",@"门磁传感器",@"湿度传感器",@"温度传感器",@"一氧化碳",@"烟雾传感器",@"水浸传感器",@"可燃气传感器",@"推窗传感器"] LabelTitle:@"选择图标" ClickBlock:^(int index, NSString *imagestr, NSString *title) {
        [_senseImageBtn setBackgroundImage:[UIImage imageNamed:imagestr] forState:UIControlStateNormal];
        [_senseImageBtn setAccessibilityIdentifier:imagestr];
    }];
    
    [switchIcon showWithParentViewController:nil];
    [switchIcon showPopupview];
}
- (IBAction)sensorNameAction:(id)sender {
    TextFieldAlertViewController *textAlert = [TextFieldAlertViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:TEXTFIELDALERTVIEWCONTROLLER];
    [textAlert setTitle:@"传感器名称" EnterBlock:^(NSString *text) {
        if(text){
            _sensorNameLab.text = text;
        }
    } Cancle:^(NSString *text) {
        
    }];
    [textAlert showWithParentViewController:nil];
    [textAlert showPopupview];
}
- (IBAction)sensorAreaAction:(id)sender {
    TablePopViewController *switchIcon = [TablePopViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:TABLEPOPVIEWCONTROLLER];
    [ switchIcon setTitleLabel:@"选择区域" CellTitleArray:@[@"客厅",@"餐厅",@"主卧",@"次卧",@"书房",@"走廊",@"厨房",@"浴室"] Block:^(id dataArray) {
        if(dataArray != nil){
            NSDictionary* data = dataArray[0];
            _sensorAreaLab.text = [data objectForKey:@"selectTitle"];
        }else{
            
        }
    }];
    [switchIcon showWithParentViewController:nil];
    [switchIcon showPopupview];
}
+(instancetype)shareInstance{
    
    return  VIEW_SHAREINSRANCE(MAINSTORYBOARD, SENSORVIEWCONTROLLER);
}

@end
