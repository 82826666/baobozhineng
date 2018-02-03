//
//  ParentPopupView.m
//  PopupView
//
//  Created by chenying on 16/5/18.
//  Copyright © 2016年 chenying. All rights reserved.
//

#import "ParentPopupView.h"
#import "CommonCode.h"
#import "AppDelegate.h"


@interface ParentPopupView ()


@end

@implementation ParentPopupView

/**
 *  获取弹窗类
 *
 *  @param storyboarbName 弹窗所属的SB
 *  @param poppupViewName 弹窗类名
 *
 *  @return 弹窗视图控制器
 */

+ (instancetype)sharePopupView:(NSString *)storyboarbName andPopupViewName:(NSString *)poppupViewName{
    
    return [[UIStoryboard storyboardWithName:storyboarbName bundle:nil] instantiateViewControllerWithIdentifier:poppupViewName];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isTouchHidden = YES;
    self.popupView.layer.cornerRadius = 5;
    self.popupView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showPopupview];
}


/**
 *  展示view
 */
- (void)showPopupview {
    
    self.popupView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    // 开始动画
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        // 放大
        self.popupView.transform = ChooseWithCondition(IOS_8_OR_LATER, CGAffineTransformMakeScale(1.05f, 1.05f), CGAffineTransformIdentity);
        if (!self.isClearBack) {
            self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        }
    } completion:^(BOOL finished) {
        
        // 还原大小
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.popupView.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
    
}

/**
 *  隐藏view
 */
- (void)hiddenPopupView{
    self.popupView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
    
    // 开始动画
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        // 放大
        self.popupView.transform = ChooseWithCondition(IOS_8_OR_LATER, CGAffineTransformMakeScale(0.01f, 0.01f), CGAffineTransformIdentity);
        self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        
        Async_Main(
                   [self dismissViewControllerAnimated:NO completion:nil];
                   );
        
    }];
    
}

/**
 *  弹出view
 *
 *  @param parentViewController 父类
 */
- (void)showWithParentViewController:(UIViewController *)parentViewController {
    
    if (!parentViewController) {
        parentViewController = [(AppDelegate *)[UIApplication sharedApplication].delegate window].rootViewController;
    }
    
    // 设置弹出的view的背景色为透明色
    parentViewController.providesPresentationContextTransitionStyle = YES;
    parentViewController.definesPresentationContext = YES;
    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    // 弹出本视图
    [parentViewController presentViewController:self animated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.allObjects.firstObject;
    
    if (touch.view == self.view && self.isTouchHidden) {
        [self hiddenPopupView];
    }
}

@end
