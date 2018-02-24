//
//  SVProgressHUD+SomeThingDefine.m
//  baobozhineng
//
//  Created by 吴建阳 on 2018/1/2.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "SVProgressHUD+SomeThingDefine.h"

@implementation SVProgressHUD (SomeThingDefine)

+ (void)mydefineShowDismissTime:(NSTimeInterval)dismissTimes titile:(NSString *)title
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setMinimumDismissTimeInterval:dismissTimes];
    [SVProgressHUD setBackgroundColor:RGBA(55, 55, 55, 0.4)];
}

+ (void)mydefineShowWithStatus:(NSString *)status
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:RGBA(55, 55, 55, 0.4)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:status];
}

+ (void)mydefineErrorShowDismissTime:(NSTimeInterval)dismissTimes ErrorTitle:(NSString *)errorTitle
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setAnimationDelay:0.1];
    [SVProgressHUD setMinimumDismissTimeInterval:dismissTimes];
    [SVProgressHUD setBackgroundColor:RGBA(55, 55, 55, 0.4)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showErrorWithStatus:errorTitle];
}
+ (void)mydefineSuccessShowDismissTime:(NSTimeInterval)dismissTimes SuccessTitle:(NSString *)successTitle
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setMinimumDismissTimeInterval:dismissTimes];
    [SVProgressHUD setBackgroundColor:RGBA(55, 55, 55, 0.4)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showSuccessWithStatus:successTitle];
}
@end
