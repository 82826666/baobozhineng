//
//  HostComputerObject.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "HostComputerObject.h"

@implementation HostComputerObject

-(instancetype)initWithHostname:(NSString *)hostName CurrentHost:(BOOL )currentHost UserPower:(NSString *)userPower HostId:(NSString *)hostId HostStatute:(NSString *)hostStatute
{
    if (self = [super init]) {
        
        self.hostName = hostName;
        self.currentHost = currentHost;
        self.userPower = userPower;
        self.hostId = hostId;
        self.hostStatute = hostStatute;
    }
    return  self;
}
@end
