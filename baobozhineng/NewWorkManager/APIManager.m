//
//  APIManager.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
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
//发送验证码
- (void)sendCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/sendCode"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
    //    [AFNHttpTool getRequestWithUrl:path params:dic success:success failure:failure];
}
//注册用户
- (void)registerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/register"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//用户登录
- (void)loginWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/login"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//忘记密码
- (void)forgetpwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    
    NSString *path = [self getPathWithInterface:@"/user/index/forgetpwd"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//添加RF主机接口
- (void)deviceRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/register"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//修改主机名称
- (void)deviceEditMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/edit_master"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//获取主机IP
- (void)deviceGetIpWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_ip"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//获取服务器时间
- (void)deviceTimeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/time"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//获取天气
- (void)deviceWeatherWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/weather"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//获取房间
- (void)deviceGetMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_master_room"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//查询主机是否在线
- (void)deviceGetMasterStatusWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_master_status"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//onenet发送命令接口
- (void)deviceCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/cmds"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//单项设备添加
- (void)deviceAddOnewayDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/add_oneway_device"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//获取设备列表
- (void)deviceGetDeviceInfoWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_device_info"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//切换主机
- (void)deviceSwapMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/swap_master"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//注册zigbee主机
- (void)deviceZigbeeRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/zigbee_register"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//绑定zigbee主机用户
- (void)deviceBindZigbeeUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/bind_zigbee_user"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//添加zigbee设备
- (void)deviceAddZigbeeDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/device/add_zigbee_device"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//发送zigbee命令
- (void)deviceZigbeeCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/zigbee_cmds"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//获取分享主机二维码
- (void)deviceGetShareCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/get_share_code"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//分享主机
- (void)deviceShareMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/share_master"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//添加传感器接口
- (void)deviceAddSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/index/add_sensor"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
//添加情景接口
- (void)deviceAddSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure {
    NSString *path = [self getPathWithInterface:@"/device/scene/add_scene"];
    [AFNHttpTool postRequestWithUrl:path params:dic success:success failure:failure];
}
@end
