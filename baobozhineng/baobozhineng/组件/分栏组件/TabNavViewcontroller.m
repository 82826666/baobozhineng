//
//  TabNavViewcontroller.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "TabNavViewcontroller.h"

@interface TabNavViewcontroller ()<UINavigationControllerDelegate>
{
       UINavigationControllerOperation myOperationType;
}

@end

@implementation TabNavViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = YES;
    self.delegate =self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count!=0){
        myOperationType = UINavigationControllerOperationPush;
        [[NSNotificationCenter defaultCenter] postNotificationName:HIDEBOTTOMBAR object:nil userInfo:@{@"a":@"1"}];
    }
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(self.viewControllers.count!=0){
        
        myOperationType = UINavigationControllerOperationPop;
    }
    UIViewController *viewcontroller =  [super popViewControllerAnimated:animated];
    return viewcontroller;
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (myOperationType==UINavigationControllerOperationPop&&navigationController.viewControllers.count==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:SHOWBOTTOMBAR object:nil userInfo:@{@"a":@"1"}];
    }
}
@end
