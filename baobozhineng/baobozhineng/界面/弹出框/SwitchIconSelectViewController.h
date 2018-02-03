//
//  SwitchIconSelectViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/30.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//  开关图标选择

#import "ParentPopupView.h"
typedef void(^btnClickBlock)(int index,NSString *imagestr,NSString *title);

@interface SwitchIconSelectViewController : ParentPopupView

@property (nonatomic,copy) btnClickBlock clickBlock;
- (void)setImgArray:(NSArray *)imgArray titleArray:(NSArray*)titleArray LabelTitle:(NSString *)labelTitleText ClickBlock:(btnClickBlock)block;

@end
