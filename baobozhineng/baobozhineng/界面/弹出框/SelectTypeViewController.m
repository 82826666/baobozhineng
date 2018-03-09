//
//  SelectTypeViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/7.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "SelectTypeViewController.h"

@interface SelectTypeViewController ()

@end

@implementation SelectTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(30, 30, SCREEN_WIDTH - 60, 80)];
    view.backgroundColor = [UIColor redColor];
    self.popupView = view;
    [self.popupView.layer setCornerRadius:8];
    [self.popupView.layer setMasksToBounds:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
