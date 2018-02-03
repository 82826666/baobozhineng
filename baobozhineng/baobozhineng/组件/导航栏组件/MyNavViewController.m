//
//  MyNavViewController.m
//  TestNavTransition
//
//  Created by 魏俊阳 on 2017/12/22.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "MyNavViewController.h"
#import "PopAnimation.h"
@interface MyNavViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition *interactiveTransition;
}

@property (nonatomic,strong) UIPanGestureRecognizer *pan;
//@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *pan;
@end

@implementation MyNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate =self;
    UIGestureRecognizer *navgesture = self.interactivePopGestureRecognizer;
    navgesture.enabled = false;
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panToViewtransform:)];
   // _pan.edges = UIRectEdgeLeft;
    _pan.maximumNumberOfTouches=1;
    _pan.delegate = self;
    [navgesture.view  addGestureRecognizer:_pan];
}
- (void)panToViewtransform:(UIPanGestureRecognizer*)panGes
{
    double process = [panGes translationInView:panGes.view].x /[UIScreen mainScreen].bounds.size.width;
    
    process = MIN(1.0, MAX(0, process));
    
    if (panGes.state == UIGestureRecognizerStateBegan) {
        
        interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    }
    else if(panGes.state == UIGestureRecognizerStateChanged){
        
        [interactiveTransition updateInteractiveTransition:process];
    }
    else if(panGes.state == UIGestureRecognizerStateEnded ||panGes.state == UIGestureRecognizerStateCancelled){
        
        if (process > 0.3) {
            [interactiveTransition finishInteractiveTransition];
        }
        else {
            [interactiveTransition cancelInteractiveTransition];
        }
        
        interactiveTransition = nil;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count>1?true:false;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    
    if(operation==UINavigationControllerOperationPop){
        return [[PopAnimation alloc] init];
    }
    
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
{
    
    if ([animationController isKindOfClass:[PopAnimation class]]){
     
        return interactiveTransition;
    }
    return  nil;
}
@end
