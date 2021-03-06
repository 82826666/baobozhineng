//
//  APIManager.h
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/24.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNHttpTool.h"

#define  API_HOST  @"http://47.94.6.236:81" //正式环境
//#define  API_HOST  @"" //测试环境

@interface APIManager : NSObject
///单例对象
+ (APIManager *)sharedManager;
#pragma mark 短信获取
- (void)sendCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 用户注册
- (void)registerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 用户登录
- (void)loginWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 忘记密码
- (void)forgetpwdWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加RF主机接口
- (void)deviceRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改主机名称
- (void)deviceEditMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取主机IP
- (void)deviceGetIpWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取服务器时间
- (void)deviceTimeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取天气
- (void)deviceWeatherWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取房间
- (void)deviceGetMasterRoomWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 查询主机是否在线
- (void)deviceGetMasterStatusWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark onenet发送命令接口
- (void)deviceCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 单项设备添加
- (void)deviceAddOnewayDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取设备列表
- (void)deviceGetDeviceInfoWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 切换主机
- (void)deviceSwapMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 注册zigbee主机
- (void)deviceZigbeeRegisterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 绑定zigbee主机用户
- (void)deviceBindZigbeeUserWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加双向开关设备
- (void)deviceAddTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 设备添加接口
- (void)deviceDeviceAddWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
//添加zigbee设备
//- (void)deviceAddZigbeeDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 发送zigbee命令
- (void)deviceZigbeeCmdsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取分享主机二维码
- (void)deviceGetShareCodeWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 分享主机
- (void)deviceShareMasterWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加传感器接口
- (void)deviceAddSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 情景列表接口
- (void)deviceGetSceneListsWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加情景接口
- (void)deviceAddSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改情景
- (void)deviceEditSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除情景
- (void)deviceDeleteSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取设备的唯一devid
- (void)deviceGetDevidWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取主机的设备列表
- (void)deviceGetMasterDevicesWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 数值类设备数据上报
- (void)deviceReportNumEquipmentWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 触发器（情景）信息上报
- (void)deviceReportTriggerWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 手动执行触发器（情景）接口
- (void)deviceTriggerSceneWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取主机设备快捷键列表
- (void)deviceGetDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加设备快捷键
- (void)deviceAddDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加设备快捷键
- (void)deviceDeleteDeviceShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取情景快捷键
- (void)deviceGetSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加情景快捷键
- (void)deviceAddSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除情景快捷键
- (void)deviceDeleteSceneShortcutWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取情景触发列表
- (void)deviceGetTriggerListWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取数值类上报的记录（传感器上报记录）
- (void)deviceEquipmentReportLogWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改双向开关
- (void)deviceEditTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 设备修改
- (void)deviceDeviceEditWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除双向开关
- (void)deviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 设备的删除
- (void)deviceDeviceDeleteTwowaySwitchWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 修改传感器
- (void)deviceEditSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 删除传感器
- (void)deviceDeleteSensorWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 添加/修改红外转发器的设备
- (void)deviceDeviceEditRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取红外转发器的设备列表
- (void)deviceDeviceGetRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
#pragma mark 获取红外转发器的设备列表
- (void)deviceDeviceDeleteRfDeviceWithParameters:(NSDictionary *)dic success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;
@end

