//
//  APIManager.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/24.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager
+ (APIManager *)sharedManager
{
    static APIManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (NSString*)getPathWithInterface:(NSString*)str
{
    NSString *path = [NSString stringWithFormat:@"%@%@",API_HOST,str];
    return path;
}
#pragma mark 短信获取
- (void)sendCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/sendCode"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
    //    [AFNHttpTool getRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 用户注册
- (void)registerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/register"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 用户登录
- (void)loginWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/login"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 忘记密码
- (void)forgetpwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/forgetpwd"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加RF主机接口
- (void)deviceRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/register"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改主机名称
- (void)deviceEditMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/edit_master"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取主机IP
- (void)deviceGetIpWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_ip"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取服务器时间
- (void)deviceTimeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/time"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取天气
- (void)deviceWeatherWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/weather"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取房间
- (void)deviceGetMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_master_room"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 查询主机是否在线
- (void)deviceGetMasterStatusWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_master_status"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark onenet发送命令接口
- (void)deviceCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/cmds"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 单项设备添加
- (void)deviceAddOnewayDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/add_oneway_device"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取设备列表
- (void)deviceGetDeviceInfoWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_device_info"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 切换主机
- (void)deviceSwapMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/swap_master"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 注册zigbee主机
- (void)deviceZigbeeRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/zigbee_register"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 绑定zigbee主机用户
- (void)deviceBindZigbeeUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/bind_zigbee_user"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加双向开关设备
- (void)deviceAddTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSLog(@"params:%@",dic);
    NSString *path = [self getPathWithInterface:@"/device/device/add_twoway_switch"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加zigbee设备
//- (void)deviceAddZigbeeDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
//    NSString *path = [self getPathWithInterface:@"/device/device/add_zigbee_device"];
//    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
//}
#pragma mark 发送zigbee命令
- (void)deviceZigbeeCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/zigbee_cmds"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取分享主机二维码
- (void)deviceGetShareCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_share_code"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 分享主机
- (void)deviceShareMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/share_master"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加传感器接口
- (void)deviceAddSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/add_sensor"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 情景列表接口
- (void)deviceGetSceneListsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/get_scene_lists"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加情景接口
- (void)deviceAddSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/add_scene"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改情景
- (void)deviceEditSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/edit_scene"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除情景
- (void)deviceDeleteSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/delete_scene"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取设备的唯一devid
- (void)deviceGetDevidWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/get_devid"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取主机的设备列表
- (void)deviceGetMasterDevicesWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/get_master_devices"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 数值类设备数据上报
- (void)deviceReportNumEquipmentWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/report_num_equipment"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 触发器（情景）信息上报
- (void)deviceReportTriggerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/report_trigger"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 手动执行触发器（情景）接口
- (void)deviceTriggerSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/trigger_scene"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取主机设备快捷键列表
- (void)deviceGetDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/get_device_shortcut"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加设备快捷键
- (void)deviceAddDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/add_device_shortcut"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加设备快捷键
- (void)deviceDeleteDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/delete_device_shortcut"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取情景快捷键
- (void)deviceGetSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/get_scene_shortcut"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 添加情景快捷键
- (void)deviceAddSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/add_scene_shortcut"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除情景快捷键
- (void)deviceDeleteSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/shortcut/delete_scene_shortcut"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取情景触发列表
- (void)deviceGetTriggerListWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/get_trigger_list"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 获取数值类上报的记录（传感器上报记录）
- (void)deviceEquipmentReportLogWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/equipment_report_log"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改双向开关
- (void)deviceEditTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/edit_twoway_switch"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除双向开关
- (void)deviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/delete_twoway_switch"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 修改传感器
- (void)deviceEditSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/edit_sensor"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
#pragma mark 删除传感器
- (void)deviceDeleteSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/delete_sensor"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
@end

