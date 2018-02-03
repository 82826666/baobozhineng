//
//  LearningAlertViewController.h
//  baobozhineng
//
//  Created by wjy on 2018/1/29.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "ParentPopupView.h"
typedef void(^LearningAlertCancleBlock)(NSString *text);
@interface LearningAlertViewController : ParentPopupView
@property (nonatomic,copy) LearningAlertCancleBlock cancelBlock;
-(void)setTitle:(NSString *)title learning:(NSString*)learning Cancle:(LearningAlertCancleBlock)cancleBlock;
@end
