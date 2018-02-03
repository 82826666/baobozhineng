//
//  TextFieldAlertViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "ParentPopupView.h"
typedef void(^TextFieldAlertEnterBlock)(NSString *text);
typedef void(^TextFieldAlertCancleBlock)(NSString *text);
@interface TextFieldAlertViewController : ParentPopupView

@property (nonatomic,copy) TextFieldAlertEnterBlock enterBlock;
@property (nonatomic,copy) TextFieldAlertCancleBlock cancelBlock;
//编辑名称
- (void)setTitle:(NSString *)title EnterBlock:(TextFieldAlertEnterBlock)enterBlock Cancle:(TextFieldAlertCancleBlock)cancleBlock;
//提示
-(void)setTitle:(NSString *)title textField:(NSString*)text EnterBlock:(TextFieldAlertEnterBlock)enterBlock Cancle:(TextFieldAlertCancleBlock)cancleBlock;
@end
