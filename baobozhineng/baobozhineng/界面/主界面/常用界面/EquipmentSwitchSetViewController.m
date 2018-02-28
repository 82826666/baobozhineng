//
//  EquipmentSwitchSetViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/29.
//  Copyright © 2017年 吴建阳. All rights reserved.
// 设备开关配置界面

#import "EquipmentSwitchSetViewController.h"
#import "TextFieldAlertViewController.h"
#import "SwitchIconSelectViewController.h"
#import "TablePopViewController.h"
@interface EquipmentSwitchSetViewController ()
{
    //点击的按钮tag
    NSInteger clickViewTag;
    //点击的按钮
    UIView *selectSwitchView;
}
//导航头部标题
@property (weak, nonatomic) IBOutlet UILabel *switchConfigTitleLab;
//滚动内容视图
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollerView;
//一键开发界面
@property (weak, nonatomic) IBOutlet UIView *switchOne;
//二键开发界面
@property (weak, nonatomic) IBOutlet UIView *switchTwo;
//三键开发界面
@property (weak, nonatomic) IBOutlet UIView *switchthree;
//四键开发界面
@property (weak, nonatomic) IBOutlet UIView *switchFour;
//开关名称
@property (weak, nonatomic) IBOutlet UILabel *switchNameLabel;
//按键名称
@property (weak, nonatomic) IBOutlet UILabel *switchBtnLabel;
//按键区域
@property (weak, nonatomic) IBOutlet UILabel *switchAreaLabel;

@property (nonatomic) int tag_1;

@property (nonatomic) int tag_2;

@property (nonatomic) int parent;
@end

@implementation EquipmentSwitchSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏开关名称
    if (self.switchtitle) {
      self.switchNameLabel.text =  self.switchConfigTitleLab.text = self.switchtitle;
    }
    //设置界面开关为空
    _switchBtnLabel.text = @"";
    _switchAreaLabel.text = @"";
    [self showSwitchView];
}
+(instancetype)shareInstance
{
    return  VIEW_SHAREINSRANCE(MAINSTORYBOARD, EQUIPMENTSWITCHSETVIEWCONTROLLER);
}
//当点击按键的时候我们需要将点击的界面的图标增加边框，而没有点击的按键取消边框
- (IBAction)selectSwitchAction:(id)sender {
    UIButton *clickBbtn = sender;
    UIView *clickView = clickBbtn.superview;
    UIView *superView = clickView.superview;
    clickViewTag = clickView.tag;
    selectSwitchView = clickView;
    UILabel *clickLab = (UILabel*)[clickView subviewsWithTag:2];
    _switchBtnLabel.text = clickLab.text;
    [self setViewLayerBorderGreen:clickBbtn];
    int kkk=2;
    if (self.switchSetNum ==SwitchSetNumOne) {
        kkk=2;
    }
    else if(self.switchSetNum ==SwitchSetNumTwo) {
          kkk=4;
    }
    else if(self.switchSetNum ==SwitchSetNumThree) {
          kkk=6;
    }
    else if(self.switchSetNum ==SwitchSetNumFour) {
         kkk=8;
    }
    for (int i=1; i<kkk+1; i++) {
        if (i!=clickViewTag) {
            
            UIView *btnView = [superView subviewsWithTag:i];
            NSArray *subviews = btnView.subviews;
            for (id view in subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *btn = view;
                    [self setViewLayerBorderClear:btn];
                    break;
                }
            }
        }
    }
    
}
//按键区域改变
- (IBAction)switchAreaAction:(id)sender {
    if (!selectSwitchView) {
        [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        return;
    }
    TablePopViewController *switchIcon = [TablePopViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:TABLEPOPVIEWCONTROLLER];
    [ switchIcon setTitleLabel:@"选择区域" CellTitleArray:@[@"客厅",@"餐厅",@"主卧",@"次卧",@"书房",@"走廊",@"厨房",@"浴室"] Block:^(id dataArray) {
        if(dataArray != nil){
        NSDictionary* data = dataArray[0];
        _switchAreaLabel.text = [data objectForKey:@"selectTitle"];
        }else{
            
        }
    }];
    [switchIcon showWithParentViewController:nil];
    [switchIcon showPopupview];
}
//按键名称改变
- (IBAction)switchBtnNameAction:(id)sender {
    if (!selectSwitchView) {
        [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        return;
    }
    TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
    int tag  = (int)selectSwitchView.tag;
    [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
        if(text.length!=0){
            
            _switchBtnLabel.text = text;
            if((tag % 2) == 0){
                _tag_1 = tag - 1;
                _tag_2 = tag;
            }else{
                _tag_1 = tag;
                _tag_2 = tag + 1;
            }
            UILabel *lable1 = (UILabel*)[[[selectSwitchView superview] subviewsWithTag:_tag_1]subviewsWithTag:2];
            UILabel *lable2 = (UILabel*)[[[selectSwitchView superview] subviewsWithTag:_tag_2]subviewsWithTag:2];
            lable1.text = [NSString stringWithFormat:@"%@-开",text];
            lable2.text = [NSString stringWithFormat:@"%@-关",text];
//            UILabel *label = [selectSwitchView viewWithTag:2];
//            label.text = text;
        }
    } Cancle:^(NSString *text) {
        
    }];
    [textfieldAlert showWithParentViewController:nil];
    [textfieldAlert showPopupview];
}
//按键图标改变
- (IBAction)switchIconAction:(id)sender {
    if (!selectSwitchView) {
        [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        return;
    }
            SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
            int tag  = (int)selectSwitchView.tag;
            [switchIcon setImgArray:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight",@"in_equipment_lamp_mirrorlamp",@"in_equipment_lamp_downlight",@"in_equipment_lamp_chandelier",@"in_equipment_aiming_default"] titleArray:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯",@"壁灯",@"浴灯",@"吊灯",@"白织灯"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
                //按钮的返回事件

                if((tag % 2) == 0){
                    _tag_1 = tag - 1;
                    _tag_2 = tag;
                }else{
                    _tag_1 = tag;
                    _tag_2 = tag + 1;
                }
//                UIImageView  *imgView = (UIImageView*)[selectSwitchView subviewsWithTag:1];
//                imgView.image = [UIImage imageNamed:imagestr];
                
                UIImageView *imgView1 = (UIImageView*)[[[selectSwitchView superview] subviewsWithTag:_tag_1]subviewsWithTag:1];
                UIImageView *imgView2 = (UIImageView*)[[[selectSwitchView superview] subviewsWithTag:_tag_2]subviewsWithTag:1];
                imgView1.image = [UIImage imageNamed:imagestr];
                [imgView1.image setAccessibilityIdentifier:imagestr];
                imgView2.image = [UIImage imageNamed:imagestr];
                [imgView2.image setAccessibilityIdentifier:imagestr];
            }] ;
            [switchIcon showWithParentViewController:nil];
            [switchIcon showPopupview];
}
//按键标题改变
- (IBAction)switchViewTitleName:(id)sender {
    TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
    [textfieldAlert setTitle:@"开关名称" EnterBlock:^(NSString *text) {
        if (text.length!=0) {
            
            self.switchtitle = text;
            _switchNameLabel.text = text;
            _switchConfigTitleLab.text = text;
            
        }
    } Cancle:^(NSString *text) {
        
    }];
    [textfieldAlert showWithParentViewController:nil];
    [textfieldAlert showPopupview];
}

//这个的接口我来做，你把接口参数给我就可以了，callme
- (IBAction)saveAction:(id)sender {
    if (!selectSwitchView) {
        [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:GET_USERDEFAULT(MASTER_ID) forKey:@"master_id"];
    [params setObject:_switchNameLabel.text forKey:@"name"];
    int type = 0;
    if (_switchSetNum == 1) {
        type = 10111;
    }else if (_switchSetNum == 2){
        type = 10121;
    }else if (_switchSetNum == 3){
        type = 10131;
    }else if (_switchSetNum == 4){
        type = 10141;
    }
    [params setObject:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    [params setObject:@"1" forKey:@"room_id"];
    [params setObject:@"1" forKey:@"icon"];
    [params setObject:@"23434" forKey:@"code"];
    [params setObject:@"1" forKey:@"status"];
    NSString *defaultImageName = @"in_equipment_lamp_default";
    NSMutableArray *setting = [NSMutableArray new];
    for (int i = 1; i <= (self.switchSetNum * 2); i = i + 2) {
        UIImageView *imgView = (UIImageView*)[[[selectSwitchView superview] subviewsWithTag:i]subviewsWithTag:1];
            UILabel *lable = (UILabel*)[[[selectSwitchView superview] subviewsWithTag:i]subviewsWithTag:2];
        
        NSMutableDictionary *set = [NSMutableDictionary new];
        if([imgView.image accessibilityIdentifier]){
            [set setObject:[imgView.image accessibilityIdentifier] forKey:@"button-icon"];
        }else{
            [set setObject:defaultImageName forKey:@"button-icon"];
        }
        [set setObject:[CommonCode subStr:lable.text str:@"-"] forKey:@"button-name"];
        
        NSMutableDictionary *open = [NSMutableDictionary new];
        NSString *devid = [NSString stringWithFormat:@"%@-%@",GET_USERDEFAULT(MASTER_ID),[CommonCode getCurrentTimeRubbing]];
        [open setObject:[NSString stringWithFormat:@"%@-1",devid] forKey:@"devid"];
        [open setObject:@"1" forKey:@"flag"];
        
        NSMutableDictionary *close = [NSMutableDictionary new];
        [close setObject:[NSString stringWithFormat:@"%@-2",devid] forKey:@"devid"];
        [close setObject:@"2" forKey:@"flag"];
        [set setObject:open forKey:@"open"];
        [set setObject:close forKey:@"close"];
        [setting addObject:set];
    }
    if(setting == nil){
        [[AlertManager alertManager] showError:3.0 string:@"数据加载失败"];
        return;
    }
    [params setObject:[CommonCode formatToJson:setting] forKey:@"setting"];
    [[APIManager sharedManager] deviceAddOnewayDeviceWithParameters:params success:^(id data) {
//        NSLog(@"%@",params);
        //请求数据成功
        NSDictionary *datadic = data;
        if ([[datadic objectForKey:@"code"] intValue] != 200) {
            //请求失败
            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
        }
        else{
            //请求成功
            [[AlertManager alertManager] showSuccess:3.0 string:[datadic objectForKey:@"msg"]];
            //返回到主界面
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        [[AlertManager alertManager] showError:3.0 string:@"请求失败"];
        return;
    }];
}

//设置点击的按钮界面的边框和背景颜色
-(void)setViewLayerBorderGreen:(UIButton *)btn
{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderWidth:2];
    [btn.layer setBorderColor:RGBA(120, 195, 3, 1.0).CGColor];
    [btn setBackgroundColor:RGBA(88, 155, 3, 0.2)];
}
//设置未点击的按钮界面的边框和背景颜色
-(void)setViewLayerBorderClear:(UIButton *)btn
{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderWidth:CGFLOAT_MIN];
    [btn.layer setBorderColor:CLEAR_COLOR.CGColor];
    [btn setBackgroundColor:CLEAR_COLOR];
}
//判断需要显示的是一键开关还是二建开关。。。
- (void)showSwitchView
{
    if (self.switchSetNum ==SwitchSetNumOne) {
        _parent = 1000;
        _switchOne.alpha =1;
        _switchTwo.alpha = 0;
        _switchthree.alpha = 0;
        _switchFour.alpha = 0;
    }
    else if(self.switchSetNum ==SwitchSetNumTwo) {
        _parent = 2000;
        _switchOne.alpha =0;
        _switchTwo.alpha = 1;
        _switchthree.alpha = 0;
        _switchFour.alpha = 0;
    }
    else if(self.switchSetNum ==SwitchSetNumThree) {
        _parent = 3000;
        _switchOne.alpha =0;
        _switchTwo.alpha = 0;
        _switchthree.alpha = 1;
        _switchFour.alpha = 0;
    }
    else if(self.switchSetNum ==SwitchSetNumFour) {
        _parent = 4000;
        _switchOne.alpha =0;
        _switchTwo.alpha = 0;
        _switchthree.alpha = 0;
        _switchFour.alpha = 1;
    }
}



@end
