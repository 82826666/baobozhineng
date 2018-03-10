//
//  UsualViewcontroller.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "UsualViewcontroller.h"
#import "WifiConfigViewController.h"
#import "JMDropMenu.h"
#import "SelectAlert.h"
#import "SelectEquipmentViewController.h"
#import "TablePopViewController.h"
#import "GCDAsyncUdpSocket.h"
#import "MJExtension.h"
#import "CKAlertViewController.h"
#import "TwoWayViewController.h"
// 引入JPush功能所需头文件 start
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
// 引入JPush功能所需头文件 end
@interface UsualViewcontroller ()<JMDropMenuDelegate,GCDAsyncUdpSocketDelegate>
//当前主机别称
@property (weak, nonatomic) IBOutlet UILabel *currentHostLabel;
//当前主机按钮
@property (weak, nonatomic) IBOutlet UIButton *currentHostBtn;
//地址
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
//当前温度
@property (weak, nonatomic) IBOutlet UILabel *currentTemperature;
//当前天气情况
@property (weak, nonatomic) IBOutlet UILabel *currentWeather;
//室内温度
@property (weak, nonatomic) IBOutlet UILabel *indoorTemperature;
//体感温度
@property (weak, nonatomic) IBOutlet UILabel *bodyTemperature;
//当前相对温度
@property (weak, nonatomic) IBOutlet UILabel *relativeHumidity;
//风向
@property (weak, nonatomic) IBOutlet UILabel *windDirection;
//风速
@property (weak, nonatomic) IBOutlet UILabel *windQuantity;
//滚动视图内容高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainScrollerContentHeight;

//添加更多设备标题数组
@property (strong,nonatomic) NSMutableArray *moreEquipmentTitleArray;
//添加更多设备图片数组
@property (strong,nonatomic) NSMutableArray *moreEquipmentImgArray;
//主机名称数据
@property (strong,nonatomic) NSMutableArray *hostsArray;

@property (strong, nonatomic) GCDAsyncUdpSocket *socket;
@property (strong, nonatomic) dispatch_queue_t delegateQueue;

@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *msg;
@property (assign, nonatomic) NSDictionary* result;
@end

@implementation UsualViewcontroller

static NSInteger seq = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"token:%@",GET_USERDEFAULT(USER_TOKEN));
    // Do any additional setup after loading the view.

    _moreEquipmentTitleArray = [NSMutableArray arrayWithArray:@[@"分享",@"添加主机",@"添加设备"]];
    _moreEquipmentImgArray = [NSMutableArray arrayWithArray:@[@"in_common_more_share.png",@"in_common_more_add.png",@"in_common_more_equipment.png"]];
    UITapGestureRecognizer *hostLabGestuer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(currentHostAction:)];
    [_currentHostLabel addGestureRecognizer:hostLabGestuer];
    
//    [self initUdpSocket];
    [self jpushTest];
    [self getWeather];
}

-(void)jpushTest{
    [JPUSHService setAlias:@"wujianyang" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        NSLog(@"code:%ld content:%@ seq:%ld",iResCode,iAlias,seq);
    } seq:[self seq]];
}

- (NSInteger)seq {
    return ++ seq;
}

//获取天气
-(void) getWeather{
    NSString* master_id = GET_USERDEFAULT(MASTER_ID);
    if(master_id != nil){
        [[APIManager sharedManager] deviceWeatherWithParameters:@{@"masterId": master_id} success:^(id data) {
            NSDictionary *datadic = [data objectForKey:@"data"];
//            NSLog(@"%@",datadic);
            UsualViewcontroller *user = [UsualViewcontroller mj_objectWithKeyValues:datadic];
            NSDictionary* result = user.result;
            NSDictionary* api = [result objectForKey:@"aqi"];
            _addressLab.text = [result objectForKey:@"city"];
            _currentTemperature.text = [result objectForKey:@"temp"];
            _currentWeather.text = [[NSString alloc] initWithFormat:@"%@ | 空气%@",[result objectForKey:@"weather"],[api objectForKey:@"quality"]];
            _windDirection.text = [result objectForKey:@"winddirect"];
            _windQuantity.text = [result objectForKey:@"windpower"];
            _relativeHumidity.text = [[NSString alloc] initWithFormat:@"%@%@",[result objectForKey:@"humidity"],@"%"];
            _bodyTemperature.text = [api objectForKey:@"ipm2_5"];
//            NSLog(@"%@",[api objectForKey:@"ipm2_5"]);
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [[AlertManager alertManager] showError:3.0 string:@"请求失败"];
        }];
    }
}


//初始化UdpSocket发送
-(void)initUdpSocket{
     self.delegateQueue = dispatch_queue_create("socket.com", DISPATCH_QUEUE_CONCURRENT);
    self.socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:self.delegateQueue];
    
    NSError *error = nil;
    // 客户端  127.0.0.1  5555
    if (![self.socket bindToPort:5555 error:&error]) {     // 端口绑定
        NSLog(@"bindToPort: %@", error);
        return ;
    }
    if (![self.socket beginReceiving:&error]) {     // 开始监听
        NSLog(@"beginReceiving: %@", error);
        return ;
    }
    
    // 服务器  127.0.0.1  6666
    if (![self.socket connectToHost:@"127.0.0.1" onPort:6666 error:&error]) {   // 连接服务器
        NSLog(@"连接失败：%@", error);
        return ;
    }
}
//发送消息
-(void)sendMsg{
    NSString *str = @"hello world";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.socket sendData:data withTimeout:-1 tag:10];
}
//已经连接成功调用此函数
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
    NSLog(@"连接成功");
    [self sendMsg];
}
//已经发送成功，调用此函数
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"发送成功");
}
//发送失败调用此函数
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"发送失败 %@", error);
}
//收到信息，调用此函数
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    NSString *dat = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到回复：%@", dat);
}

- (IBAction)sendAction:(id)sender {
    NSString *str = @"hello world";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.socket sendData:data withTimeout:-1 tag:10];      // 发送
}

+ (instancetype)shareInstance
{
    return VIEW_SHAREINSRANCE(MAINSTORYBOARD, USUALVIEWCONTROLLER);
}
- (IBAction)currentHostAction:(id)sender {

    [SelectAlert showWithTitle:@"切换当前主机" titles:_hostsArray TitleLabColor:RGBA(0,228,255,1.0) RightImg:[UIImage imageNamed:@"in_arrow_right"] BottomBtnTitle:@"添加新主机" CellHeight:50 selectIndex:^(NSInteger selectIndex) {
        NSDictionary *params = @{@"master_id":GET_USERDEFAULT(MASTER_ID)};
//        [[APIManager sharedManager]deviceSwapMasterWithParameters:params success:^(id data) {
//            NSDictionary *datadic = data;
//            if([[datadic objectForKey:@"code"] intValue] == 200){
//                NSArray *master = GET_USERDEFAULT(MASTER);
//                NSDictionary *dic = [master objectAtIndex:selectIndex];
//                SET_USERDEFAULT(MASTER_ID, [dic objectForKey:@"master_id"]);
//                _currentHostLabel.text = [dic objectForKey:@"master_name"];
//            }else{
//                [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
//            }
//        } failure:^(NSError *error) {
//            [[AlertManager alertManager] showError:3.0 string:@"服务器错误"];
//        }];
        NSArray *master = GET_USERDEFAULT(MASTER);
        NSDictionary *dic = [master objectAtIndex:selectIndex];
        SET_USERDEFAULT(MASTER_ID, [dic objectForKey:@"master_id"]);
        _currentHostLabel.text = [dic objectForKey:@"master_name"];
        //切换主机
    } selectValue:^(NSString *selectValue) {
        //不做操作
    } CloseActionBlock:^{
        //添加主机
        [self.navigationController pushViewController:[WifiConfigViewController shareInstance] animated:YES];
    } showCloseButton:YES];
}
    
//添加设备下拉菜单
- (IBAction)moreSelectAction:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    //获取按钮相对于self.view的相对位置
    CGRect btnRectInwindow = [btn.superview convertRect:btn.frame toView:self.view];
    [JMDropMenu showDropMenuFrame:CGRectMake(self.view.frame.size.width - 128, btnRectInwindow.origin.y+btnRectInwindow.size.height, 120, 128) ArrowOffset:90.f TitleArr:_moreEquipmentTitleArray ImageArr:_moreEquipmentImgArray Type:JMDropMenuTypeQQ LayoutType:JMDropMenuLayoutTypeNormal RowHeight:40.f Delegate:self];
}
//设备下拉菜单选择代理
- (void)didSelectRowAtIndex:(NSInteger)index Title:(NSString *)title Image:(NSString *)image;
{
    if (index==0) {
        //分享功能
       
    }
    else if(index ==1){
        //添加主机
        WifiConfigViewController *wificonfig =[WifiConfigViewController shareInstance];
        [self.navigationController pushViewController:wificonfig animated:YES];
    }
    else if(index ==2){
        CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"系统更新" message:@"" ];
        
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"智能搜索" handler:^(CKAlertAction *action) {
            [self.navigationController pushViewController:[[TwoWayViewController alloc]init] animated:YES];
        }];
        
        CKAlertAction *updateNow = [CKAlertAction actionWithTitle:@"RF添加" handler:^(CKAlertAction *action) {
            //添加设备
            [self.navigationController pushViewController:[SelectEquipmentViewController shareInstance] animated:YES];
//            NSLog(@"点击了 %@ 按钮",action.title);
        }];
        
        CKAlertAction *updateLater = [CKAlertAction actionWithTitle:@"WIFI搜索" handler:^(CKAlertAction *action) {
            [self.navigationController pushViewController:[WifiConfigViewController shareInstance] animated:YES];
//            NSLog(@"点击了 %@ 按钮",action.title);
        }];
        
        [alertVC addAction:cancel];
        [alertVC addAction:updateNow];
        [alertVC addAction:updateLater];
        
        [self presentViewController:alertVC animated:NO completion:nil];
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    NSMutableArray *master = GET_USERDEFAULT(MASTER);
    if (master != nil) {
        for (int i = 0; i < master.count; i++) {
            NSDictionary *dic = master[i];
            if ([[dic objectForKey:@"master_id"] integerValue] == [GET_USERDEFAULT(MASTER_ID) integerValue]) {
                _currentHostLabel.text = [dic objectForKey:@"master_name"];
            }
            [self.hostsArray addObject:[dic objectForKey:@"master_name"]];
//            _hostsArray = [NSMutableArray arrayWithArray:@[[dic objectForKey:@"master_name"]];
        }
    }
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
-(NSMutableArray*)hostsArray{
    if (_hostsArray == nil) {
        _hostsArray = [NSMutableArray new];
    }
    return _hostsArray;
}
@end
