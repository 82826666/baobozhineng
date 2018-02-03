//
//  AutoKeyboardField.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/25.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "AutoKeyboardField.h"
@interface AutoKeyboardField()
{
    UIView *maskView;
    UIView *superView;
}
@end

@implementation AutoKeyboardField

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
}

-(void)setFieldDismissActionBymaskInView:(UIView*)view KeyBoardType:(UIKeyboardType)keyboardType fieldBlock:(FieldEndBlock)block
{
    self.keyboardType = keyboardType;
    self.fieldBlock = block;
    self.delegate = self;
    superView = view;
}
//设置点击屏幕隐藏键盘
-(void)setFieldDismissActionBymaskInView:(UIView*)view fieldBlock:(FieldEndBlock)block
{
 
    self.fieldBlock = block;
    self.delegate = self;
    superView = view;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    maskView = [[UIView alloc] initWithFrame:superView.frame];
    maskView.backgroundColor = CLEAR_COLOR;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [maskView addGestureRecognizer:tap];
    [superView addSubview:maskView];
}

- (void)dismissKeyboard
{
    if (maskView) {
        
        [maskView removeFromSuperview];
    }
    [self resignFirstResponder];
    self.fieldBlock();
}

@end
