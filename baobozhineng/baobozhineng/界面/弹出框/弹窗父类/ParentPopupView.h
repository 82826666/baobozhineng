//
//  ParentPopupView.h
//  PopupView
//
//  Created by chenying on 16/5/18.
//  Copyright © 2016年 chenying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCode.h"

@interface ParentPopupView : UIViewController

/// 需要弹出弹窗的view
@property(strong, nonatomic) UIView *popupView;
/// 是否点击隐藏弹窗 默认YES
@property(assign, nonatomic) BOOL isTouchHidden;

/// 是否背景透明
@property(assign, nonatomic) BOOL isClearBack;

/**
 *  获取弹窗类
 *
 *  @param storyboarbName 弹窗所属的SB
 *  @param poppupViewName 弹窗类名
 *
 *  @return 弹窗视图控制器
 */
+ (instancetype)sharePopupView:(NSString *)storyboarbName andPopupViewName:(NSString *)poppupViewName;

/**
 *  展示view
 */
- (void)showPopupview;

/**
 *  隐藏view
 */
- (void)hiddenPopupView;

/**
 *  弹出view
 *
 *  @param parentViewController 父类
 */
- (void)showWithParentViewController:(UIViewController *)parentViewController;

@end
