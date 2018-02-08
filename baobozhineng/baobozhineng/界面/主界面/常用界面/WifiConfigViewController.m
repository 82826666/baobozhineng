//
//  WifiConfigViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/28.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "WifiConfigViewController.h"
#import "SelectHomeWIFIViewController.h"
@interface WifiConfigViewController ()
@property (weak, nonatomic) IBOutlet AutoKeyboardField *WifiNameField;

@property (weak, nonatomic) IBOutlet AutoKeyboardField *WIFIpasswordField;

@end

@implementation WifiConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_WifiNameField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
    [_WIFIpasswordField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
}

//开始配置wifi
- (IBAction)beginConfig:(id)sender {
    
}

+(instancetype)shareInstance
{
    return VIEW_SHAREINSRANCE(MAINSTORYBOARD, WIFICONFIGCONTROLLER);
}

@end
