//
//  HostComputerObject.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostComputerObject : NSObject
//当前主机名称
@property (nonatomic,copy) NSString *hostName;
//当前主机
@property (nonatomic,assign) bool currentHost;
//用户权限
@property (nonatomic,copy) NSString *userPower;
//主机编号
@property (nonatomic,copy) NSString *hostId;
//主机状态
@property (nonatomic,copy) NSString *hostStatute;

-(instancetype)initWithHostname:(NSString *)hostName CurrentHost:(BOOL)currentHost UserPower:(NSString *)userPower HostId:(NSString *)hostId HostStatute:(NSString *)hostStatute;
@end
