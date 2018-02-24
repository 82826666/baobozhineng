//
//  MainParentViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "MainParentViewController.h"

@interface MainParentViewController ()

//底部高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allViewBottomConstraint;

@end

@implementation MainParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBottomBar:) name:SHOWBOTTOMBAR object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBootomBar:) name:HIDEBOTTOMBAR object:nil];
}

- (void)showBottomBar:(NSNotification *)notification
{
    _allViewBottomConstraint.constant = TAB_BOTTOMVIEW_HEIGTH;
    
}
-(void)hideBootomBar:(NSNotification *)notification
{
    _allViewBottomConstraint.constant = 0;
}
@end
