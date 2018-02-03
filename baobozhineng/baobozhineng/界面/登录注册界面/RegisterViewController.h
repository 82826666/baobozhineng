//
//  RegisterViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
// 注册界面

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, RegisterViewStyle) {
    RegisterViewCtr,
    ForgetPasswordCtr
};

@interface RegisterViewController : ParentViewController

//由于忘记密码和注册界面是一样，这里就不再重做注册界面，使用viewstyle来判断是哪个界面
@property (nonatomic)RegisterViewStyle viewstyle;
//导航栏标题
@property (weak, nonatomic) IBOutlet UILabel *navbarTitleLab;
//确定按钮
@property (weak, nonatomic) IBOutlet RadioButton *enterButton;

@end
