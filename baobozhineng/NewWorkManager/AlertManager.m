//
//  AlertManager.m
//  baobozhineng
//
//  Created by 吴建阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager
+ (AlertManager *)alertManager
{
    static AlertManager *_alertManager = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _alertManager = [[self alloc] init];
    });
    
    return _alertManager;
}
//成功提示
- (void)showSuccess:(NSTimeInterval)time string:(NSString*)str{
    [SVProgressHUD mydefineSuccessShowDismissTime:time SuccessTitle:str];
}
//错误提示
- (void)showError:(NSTimeInterval)time string:(NSString*)str{
    [SVProgressHUD mydefineErrorShowDismissTime:time ErrorTitle:str];
}
@end
