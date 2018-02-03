//
//  AutoKeyboardField.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/25.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FieldEndBlock)(void);
@interface AutoKeyboardField : UITextField<UITextFieldDelegate>

@property (nonatomic,copy) FieldEndBlock fieldBlock;

//设置点击屏幕隐藏键盘
-(void)setFieldDismissActionBymaskInView:(UIView*)view fieldBlock:(FieldEndBlock)block;
-(void)setFieldDismissActionBymaskInView:(UIView*)view KeyBoardType:(UIKeyboardType)keyboardType fieldBlock:(FieldEndBlock)block;
@end
