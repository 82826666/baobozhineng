//
//  SVProgressHUD+SomeThingDefine.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/2.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (SomeThingDefine)
+ (void)mydefineShowDismissTime:(NSTimeInterval)dismissTimes;
+ (void)mydefineShowWithStatus:(NSString *)status;
+ (void)mydefineErrorShowDismissTime:(NSTimeInterval)dismissTimes ErrorTitle:(NSString *)errorTitle;
+ (void)mydefineSuccessShowDismissTime:(NSTimeInterval)dismissTimes SuccessTitle:(NSString *)successTitle;
@end
