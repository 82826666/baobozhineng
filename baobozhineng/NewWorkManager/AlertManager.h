//
//  AlertManager.h
//  baobozhineng
//
//  Created by 吴建阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject
///单例对象
+ (AlertManager *)alertManager;
//成功提示
- (void)showSuccess:(NSTimeInterval)time string:(NSString*)str;
//错误提示
- (void)showError:(NSTimeInterval)time string:(NSString*)str;
@end
