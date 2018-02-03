//
//  MainHostSetViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "MainHostSetViewController.h"
#import "HostComputerObject.h"
#import "TextFieldAlertViewController.h"

#define CELL_HEIGHT 50
#define CELL_HEAD_HEIGHT 40
@interface MainHostSetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *hostKey;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//主机列表数据
@property (nonatomic,strong) NSArray *hostListDataArray;

@property (nonatomic,strong) HostComputerObject *currentHost;

@end

@implementation MainHostSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    hostKey = @[@"当前主机",@"用户权限",@"主机编号",@"主机状态"];
    UIView *view1111 = [[UIView alloc]init];
    view1111.backgroundColor = [UIColor whiteColor];
    [_tableView setTableFooterView:view1111];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.backgroundColor =MAIN_COLOR;
}
-(NSArray *)hostListDataArray
{
    if (!_hostListDataArray) {

        HostComputerObject *obj1 = [[HostComputerObject alloc] initWithHostname:@"主机1" CurrentHost:YES UserPower:@"管理员" HostId:@"123212" HostStatute:@"开机"];
        self.currentHost = obj1;
        HostComputerObject *obj2 = [[HostComputerObject alloc] initWithHostname:@"主机2" CurrentHost:false UserPower:@"管理员" HostId:@"123212" HostStatute:@"关机"];
        HostComputerObject *obj3 = [[HostComputerObject alloc] initWithHostname:@"主机3" CurrentHost:false UserPower:@"管理员" HostId:@"123212" HostStatute:@"关机"];
        
        _hostListDataArray = @[obj1,obj2,obj3];
    }
    return _hostListDataArray;
}

+(instancetype)shareInstance
{
    return VIEW_SHAREINSRANCE(MAINSTORYBOARD, MAINHOSTSETVIECONTROLLER);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return  4;
    }
    else{
        return self.hostListDataArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return CGFLOAT_MIN;
    }
    else{
        return  CELL_HEAD_HEIGHT;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headView = [[UIView alloc] init];
    
    if (section==0) {
        headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN);
    }
    else{
        
        headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEAD_HEIGHT);
    }
    return headView;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalcell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalcell"];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, CELL_HEIGHT)];
        leftLabel.font = [UIFont systemFontOfSize:15];
        leftLabel.textColor = RGBA(88, 88, 88, 1.0);
        leftLabel.tag = 1;
        [cell.contentView addSubview:leftLabel];
        
        UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CELL_HEIGHT)];
        middleLabel.font = [UIFont systemFontOfSize:12];
        middleLabel.textColor = RGBA(188, 188, 188, 1.0);
        middleLabel.tag = 2;
        middleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:middleLabel];
        
        UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, CELL_HEIGHT/2-10, 20, 20)];
        rightImg.image = [UIImage imageNamed:@"in_arrow_right"];
        rightImg.contentMode = UIViewContentModeScaleAspectFit;
        rightImg.tag =3;
        [cell.contentView addSubview:rightImg];
        cell.backgroundColor = MAIN_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
   
    UILabel *leftlabel = [cell.contentView viewWithTag:1];
    UIImageView *rightImg = [cell.contentView viewWithTag:3];
    if (indexPath.section==0) {
        leftlabel.text  = hostKey[indexPath.row];
    }
    else if(indexPath.section==1){
        
         HostComputerObject *hostComputer = _hostListDataArray[indexPath.row];
        leftlabel .text = hostComputer.hostName;
    }
    
    UILabel *middleLab = [cell.contentView viewWithTag:2];
    if (indexPath.section == 0) {
        if (indexPath.row==0) {
            middleLab.text = _currentHost.hostName;
        }
        else  if (indexPath.row==1) {
                middleLab.text = _currentHost.userPower;
            rightImg.alpha = 0;
        }
        else if (indexPath.row==2) {
            
            middleLab.text = _currentHost.hostId;
             rightImg.alpha = 0;
        }
        else if (indexPath.row==3) {
            
            middleLab.text = _currentHost.hostStatute;
             rightImg.alpha = 0;
        }
    }
    else if(indexPath.section==1)
    {
         HostComputerObject *hostComputer = _hostListDataArray[indexPath.row];
        if(hostComputer.currentHost){
            middleLab.text=@"";
           
        }
        else
        {
            middleLab.text =@"切换主机";        }
    }
    
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0 &&indexPath.row==0){
        
        TextFieldAlertViewController *textalert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
        [textalert setTitle:@"修改主机名称" EnterBlock:^(NSString *text) {
            //返回的主机名称
            NSLog(@"%@",text);
        } Cancle:^(NSString *text) {
            
        }];
        [textalert showWithParentViewController:nil];
        [textalert showPopupview];
    }
}
@end
