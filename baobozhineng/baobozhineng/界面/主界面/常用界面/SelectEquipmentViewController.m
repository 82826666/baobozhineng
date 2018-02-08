//
//  SelectEquipmentViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/28.
//  Copyright © 2017年 吴建阳. All rights reserved.
// 设备选择界面

#import "SelectEquipmentViewController.h"
#import "SwitchIconSelectViewController.h"
#import "EquipmentSwitchSetViewController.h"
#import "SensorViewController.h"
//cell的高度
#define CELL_HEIGHT 60
@interface SelectEquipmentViewController ()<UITableViewDelegate,UITableViewDataSource>
//列表
@property (weak, nonatomic) IBOutlet UITableView *equipmentTableview;

//数据源
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation SelectEquipmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //直接设置数据
    _dataArray = [NSMutableArray arrayWithArray:@[
                                                  [EquipObject objectWithTitle:@"一位开关" img:@"in_device_list_switch1"],
                                                  [EquipObject objectWithTitle:@"二位开关" img:@"in_device_list_switch2"],
                                                  [EquipObject objectWithTitle:@"三位开关" img:@"in_device_list_switch3"],
                                                  [EquipObject objectWithTitle:@"四位开关" img:@"in_device_list_switch4"],
                                                  [EquipObject objectWithTitle:@"智能插座" img:@"in_device_list_socket"],
                                                  [EquipObject objectWithTitle:@"调光开关" img:@"in_device_list_aiming.png"],
                                                  [EquipObject objectWithTitle:@"智能窗帘" img:@"in_device_list_curtain"],
                                                  [EquipObject objectWithTitle:@"智能门锁" img:@"in_device_list_lock"],
                                                  [EquipObject objectWithTitle:@"红外转发器" img:@"in_device_list_telecontrol"],
                                                  [EquipObject objectWithTitle:@"触发型传感器" img:@"in_device_list_sensor"],
                                                  [EquipObject objectWithTitle:@"摄像头" img:@"in_device_list_camera"]
                                                  ]];
    //设置代理和对tablview的一些操作
    self.equipmentTableview.delegate = self;
    _equipmentTableview.dataSource  =self;
    
}

-(void)setEquipmentTableview:(UITableView *)equipmentTableview
{
    //去除多余的横线
    UIView *view1111 = [[UIView alloc]init];
    view1111.backgroundColor = [UIColor whiteColor];
    [equipmentTableview setTableFooterView:view1111];
    equipmentTableview.delegate = self;
    equipmentTableview.dataSource  = self;
    equipmentTableview.backgroundColor = MAIN_COLOR;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  CELL_HEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"queipcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"queipcell"];
        
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
        leftImage.tag = 1;
        [cell.contentView addSubview:leftImage];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImage.frame)+15,0 , SCREEN_WIDTH-CGRectGetMaxX(leftImage.frame), CELL_HEIGHT)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = RGBA(121, 121, 121, 1.0);
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.tag = 2;
        [cell.contentView addSubview:titleLabel];
        
        UIImageView *rightimgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 20, 20, 20)];
        rightimgView.tag = 3;
        rightimgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:rightimgView];
        cell.backgroundColor = CLEAR_COLOR;
        cell.contentView.backgroundColor = CLEAR_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    EquipObject *equipObject = [_dataArray  objectAtIndex:indexPath.row];
    //设置cell的左边图片
    UIImageView *leftImage = [cell.contentView viewWithTag:1];
    leftImage.image = equipObject.image;
    //设置cell的标题
    UILabel *titleLabel = [cell.contentView viewWithTag:2];
    titleLabel.text  = equipObject.title;
    //显示右边的>号
    UIImageView *rightView = [cell.contentView viewWithTag:3];
    rightView.image = [UIImage imageNamed:@"in_arrow_right"];

    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //每个cell的点击事件
    if (indexPath.row==0) {
        

        
        EquipmentSwitchSetViewController *equipmentSwitch = [EquipmentSwitchSetViewController shareInstance];
        equipmentSwitch.switchSetNum = 1;
        equipmentSwitch.switchtitle = @"一键开关";
        [self.navigationController pushViewController:equipmentSwitch animated:YES];
    }
    else if(indexPath.row==1){
        EquipmentSwitchSetViewController *equipmentSwitch = [EquipmentSwitchSetViewController shareInstance];
         equipmentSwitch.switchtitle = @"二键开关";
        equipmentSwitch.switchSetNum = 2;
        [self.navigationController pushViewController:equipmentSwitch animated:YES];
    }
    else if(indexPath.row==2){
        EquipmentSwitchSetViewController *equipmentSwitch = [EquipmentSwitchSetViewController shareInstance];
         equipmentSwitch.switchtitle = @"三键开关";
        equipmentSwitch.switchSetNum = 3;
        [self.navigationController pushViewController:equipmentSwitch animated:YES];
    }
    else if(indexPath.row==3){
        EquipmentSwitchSetViewController *equipmentSwitch = [EquipmentSwitchSetViewController shareInstance];
         equipmentSwitch.switchtitle = @"四键开关";
        equipmentSwitch.switchSetNum = 4;
        [self.navigationController pushViewController:equipmentSwitch animated:YES];
    }
    else if(indexPath.row==4){
        
        SensorViewController *sensorView = [SensorViewController shareInstance];
        [self.navigationController pushViewController:sensorView animated:YES];
        
    }
}
+(instancetype)shareInstance
{
    return  VIEW_SHAREINSRANCE(MAINSTORYBOARD, SELECTEQUIPMENTVIEWCONTOLLER);
}
@end

@interface EquipObject()
@end
@implementation  EquipObject

+(instancetype)objectWithTitle:(NSString*)title img:(NSString*)img
{
    EquipObject *equipObject = [[EquipObject alloc] init];
    equipObject.image = [UIImage imageNamed:img];
    equipObject.title = title;
    return equipObject;
}

@end
