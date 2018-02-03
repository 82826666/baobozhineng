//
//  APIManager.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNHttpTool.h"

#define  API_HOST  @"http://47.94.6.236:81" //正式环境
//#define  API_HOST  @"" //测试环境

@interface APIManager : NSObject
///单例对象
+ (APIManager *)sharedManager;
//发送验证码
- (void)sendCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//注册用户
- (void)registerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//用户登录
- (void)loginWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//忘记密码
- (void)forgetpwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//添加RF主机接口
- (void)deviceRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//修改主机名称
- (void)deviceEditMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//获取主机IP
- (void)deviceGetIpWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//获取服务器时间
- (void)deviceTimeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//获取天气
- (void)deviceWeatherWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//获取房间
- (void)deviceGetMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//查询主机是否在线
- (void)deviceGetMasterStatusWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//onenet发送命令接口
- (void)deviceCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//单项设备添加
- (void)deviceAddOnewayDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//获取设备列表
- (void)deviceGetDeviceInfoWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//切换主机
- (void)deviceSwapMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//注册zigbee主机
- (void)deviceZigbeeRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//绑定zigbee主机用户
- (void)deviceBindZigbeeUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//添加zigbee设备
- (void)deviceAddZigbeeDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//发送zigbee命令
- (void)deviceZigbeeCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//获取分享主机二维码
- (void)deviceGetShareCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//分享主机
- (void)deviceShareMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//添加传感器接口
- (void)deviceAddSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//添加情景接口
- (void)deviceAddSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
@end
