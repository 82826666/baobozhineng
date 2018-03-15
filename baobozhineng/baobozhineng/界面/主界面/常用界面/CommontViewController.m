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
    //点击的按钮tag
    NSInteger clickViewTag;
}
@property(nonatomic, strong) UIButton *btnOne;
@property(nonatomic, strong) UIButton *btnTwo;
@property(nonatomic, strong) UIButton *btnThree;
@property(nonatomic, strong) UIButton *btnFour;
@property(nonatomic, strong) UIButton *currentBtn;
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
//    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 100)];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.tag = 1000;
//    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    _imageView =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25, 20, 50, 50)];
//    _imageView.image = [UIImage imageNamed:@"in_equipment_lamp_default"];
//    _cacheImageName = @"in_equipment_lamp_default";
//    _label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 20, 70, 100, 30)];
//    _label.text = @"1键";
//    [btn addSubview:_imageView];
//    [btn addSubview:_label];
//    [buttonView addSubview:btn];
    NSInteger one;
    NSInteger two;
    NSInteger three;
    NSInteger four;
    NSInteger width = 150;
    NSInteger height = 150;
    NSInteger y = 120;
    if (_setNum == 1) {
        one = SCREEN_WIDTH/2 - width/2;
    }else if (_setNum == 2){
        width = SCREEN_WIDTH/_setNum;
        one = 0;
        two = SCREEN_WIDTH/2;
    }else if(_setNum == 3){
        width = SCREEN_WIDTH/_setNum;
        one = 0;
        two = width;
        three = width*2;
    }else if (_setNum == 4){
        width = SCREEN_WIDTH/_setNum;
        one = 0;
        two = width;
        two = width * 2;
        four = SCREEN_WIDTH - width;
    }
    for (int i = 0; i < _setNum; i++) {
        if (i == 0) {
            NSString *imagestr = @"in_telecontrol_control_iptv";
            _btnOne = [self getBtnOne:[UIImage imageNamed:imagestr] btnName:@"1键"];
            _btnOne.imageView.image.accessibilityValue = imagestr;
            _btnOne.tag = 30001;
            _btnOne.frame = CGRectMake(one + 10, y, width - 20, height);
            [_btnOne verticalCenterImageAndTitle:20.0f];
            [_btnOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_btnOne];
        }
        if (i == 1){
            NSLog(@"two:%ld",two);
            NSString *imagestr = @"in_telecontrol_control_iptv";
            _btnTwo = [self getBtnOne:[UIImage imageNamed:imagestr] btnName:@"2键"];
            _btnTwo.imageView.image.accessibilityValue = imagestr;
            _btnTwo.tag = 30002;
            _btnTwo.frame = CGRectMake(two + 10, y, width - 20, height);
            [_btnTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_btnTwo verticalCenterImageAndTitle:20.0f];
            [self.view addSubview:_btnTwo];
        }
        if (i == 2){
            NSString *imagestr = @"in_telecontrol_control_tv";
            _btnThree = [self getBtnOne:[UIImage imageNamed:imagestr] btnName:@"3键"];
            _btnThree.imageView.image.accessibilityValue = imagestr;
            _btnThree.tag = 30003;
            _btnThree.frame = CGRectMake(three + 10, y, width - 20, height);
            [_btnThree verticalCenterImageAndTitle:20.0f];
            [_btnThree addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_btnThree];
        }
        if (i == 3){
            NSString *imagestr = @"in_telecontro_list_settopbox";
            _btnFour = [self getBtnOne:[UIImage imageNamed:imagestr] btnName:@"4键"];
            _btnFour.imageView.image.accessibilityValue = imagestr;
            _btnFour.tag = 30004;
            _btnFour.frame = CGRectMake(four + 10, y, width - 20, height);
            [_btnFour verticalCenterImageAndTitle:20.0f];
            [_btnFour addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_btnFour];
        }
    }
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
    
    [self.view addSubview:btn1];
    [self.view addSubview:btn2];
    [self.view addSubview:btn3];
    [self.view addSubview:btn4];
}
-(void)btnClick:(UIButton*)sender{
    _currentBtn = sender;
    clickViewTag = sender.tag;
    for (int i = 0; i < _setNum; i ++) {
        if (i == 0) {
            [self setViewLayerBorderClear:_btnOne];
        }
        if (i == 1){
            [self setViewLayerBorderClear:_btnTwo];
        }
        if (i == 2){
            [self setViewLayerBorderClear:_btnThree];
        }
        if (i == 3){
            [self setViewLayerBorderClear:_btnFour];
        }
    }
    [self setViewLayerBorderGreen:_currentBtn];
}
//设置点击的按钮界面的边框和背景颜色
-(void)setViewLayerBorderGreen:(UIButton *)btn
{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderWidth:2];
    [btn.layer setBorderColor:RGBA(120, 195, 3, 1.0).CGColor];
    [btn setBackgroundColor:RGBA(88, 155, 3, 0.2)];
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
//设置未点击的按钮界面的边框和背景颜色
-(void)setViewLayerBorderClear:(UIButton *)btn
{
    [btn.layer setMasksToBounds:YES];
    [btn.layer setBorderWidth:CGFLOAT_MIN];
    [btn.layer setBorderColor:CLEAR_COLOR.CGColor];
    [btn setBackgroundColor:CLEAR_COLOR];
}
- (void)click:(UIButton*)sender{
    if (sender.tag == 1000) {
        
    }else if (sender.tag == 1001){
        if (_currentBtn == nil) {
            [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        }else{
            TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
            [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
                if(text.length!=0){
                    _currentBtn.titleLabel.text = text;
//                    _label.text = [NSString stringWithFormat:@"%@",text];
                    _nameLable.text = [NSString stringWithFormat:@"%@",text];
                }
            } Cancle:^(NSString *text) {
                
            }];
            [textfieldAlert showWithParentViewController:nil];
            [textfieldAlert showPopupview];
        }
    }else if (sender.tag == 1002){
        if (_currentBtn == nil) {
            [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        }else{
            SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
            [switchIcon setImgArray:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight",@"in_equipment_lamp_mirrorlamp",@"in_equipment_lamp_downlight",@"in_equipment_lamp_chandelier",@"in_equipment_aiming_default"] titleArray:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯",@"壁灯",@"浴灯",@"吊灯",@"白织灯"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
                //按钮的返回事件
                [_currentBtn setImage:[UIImage imageNamed:imagestr] forState:UIControlStateNormal];
                _currentBtn.imageView.image.accessibilityIdentifier = imagestr;
            }] ;
            [switchIcon showWithParentViewController:nil];
            [switchIcon showPopupview];
        }
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
//-(void)viewWillAppear:(BOOL)animated{
//    self.navigationController.toolbarHidden = NO;
//}

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
    NSMutableArray *setting = [NSMutableArray new];
    for (int i = 0; i < _setNum; i ++) {
        if (i == 0) {
            NSDictionary *dic = @{
                                  @"icon":_btnOne.imageView.image.accessibilityIdentifier,
                                  @"name":_btnOne.titleLabel.text,
                                  @"ch":@"1",
                                  @"status":@"0",
                                  @"order":@"0"
                                  };
            [setting addObject:dic];
        }
        if (i == 1){
            NSDictionary *dic = @{
                                  @"icon":_btnTwo.imageView.image.accessibilityIdentifier,
                                  @"name":_btnTwo.titleLabel.text,
                                  @"ch":@"2",
                                  @"status":@"0",
                                  @"order":@"0"
                                  };
            [setting addObject:dic];
        }
        if (i == 2){
            NSDictionary *dic = @{
                                  @"icon":_btnThree.imageView.image.accessibilityIdentifier,
                                  @"name":_btnThree.titleLabel.text,
                                  @"ch":@"3",
                                  @"status":@"0",
                                  @"order":@"0"
                                  };
            [setting addObject:dic];
        }
        if (i == 3){
            NSDictionary *dic = @{
                                  @"icon":_btnFour.imageView.image.accessibilityIdentifier,
                                  @"name":_btnFour.titleLabel.text,
                                  @"ch":@"4",
                                  @"status":@"0",
                                  @"order":@"0"
                                  };
            [setting addObject:dic];
        }
    }
    
    
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
