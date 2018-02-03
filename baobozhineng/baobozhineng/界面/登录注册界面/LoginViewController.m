//
//  LoginViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ParentTabbarController.h"
#import "AlertManager.h"
@interface LoginViewController ()
//电话输入框
@property (weak, nonatomic) IBOutlet AutoKeyboardField *phoneField;
//密码输入框
@property (weak, nonatomic) IBOutlet AutoKeyboardField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置输入框的键盘隐藏
    [_phoneField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
    
    [_passwordField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
}

+(instancetype)shareInstance
{
    return VIEW_SHAREINSRANCE(LOGINREGISTERSTORYBOARD, LOGINVIEWCONTROLLER);
}

//确定登录
- (IBAction)enterLoginAction:(id)sender {
    if(_phoneField.text!=NULL&&_passwordField.text!=NULL){
        [self login];
    }

}
-(void)login{
//    NSString* url = @"http://47.94.6.236:81/user/index/login";//http://47.94.6.236:81这个放在API_HOST头文件上/user/index/login放在登录姐楼上
//    NSString* phoneStr = _phoneField.text;
//    NSString* password = _passwordField.text;
//    NSString* clientType = @"2";
//
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSDictionary *parameters = @{@"mobile": phoneStr, @"password": password, @"clientType":clientType};
//    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"Success: %@", uploadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"msg=%@",[responseObject objectForKey:@"msg"]);
//        NSLog(@"Success: %@", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Error: %@", error);
//    }];
    NSString* phoneStr = _phoneField.text;
    NSString* password = _passwordField.text;
    NSString* clientType = @"2";
    //等待网络请求
    [SVProgressHUD mydefineShowWithStatus:nil];
    //想服务端发送请求
    [[APIManager sharedManager] loginWithParameters:@{@"mobile": phoneStr, @"password": password, @"clientType":clientType} success:^(id data) {
      //请求数据成功
        NSDictionary *datadic = data;
        if ([[datadic objectForKey:@"code"] intValue] != 200) {
            //请求登录失败
            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
        }
        else{
             //请求登录成功
            [[AlertManager alertManager] showSuccess:3.0 string:[datadic objectForKey:@"msg"]];
            NSDictionary* master = [[datadic objectForKey:@"data"] objectForKey:@"master"][0];
            NSDictionary* user_info = [[datadic objectForKey:@"data"] objectForKey:@"user"];
            //本地存储用户名以及相关数据
            NSString* user_id = [user_info objectForKey:@"userid"];
            NSString* user_token = [user_info objectForKey:@"token"];
            NSString* user_name = [user_info objectForKey:@"username"];
            NSString* master_id = [master objectForKey:@"master_id"];
            SET_USERDEFAULT(USER_ID, user_id);
            SET_USERDEFAULT(USER_TOKEN, user_token);
            SET_USERDEFAULT(LOGIN_USERNAME, user_name);
            SET_USERDEFAULT(LOGIN_PHONE, phoneStr);
            SET_USERDEFAULT(USER_INFO, user_info);
            SET_USERDEFAULT(MASTER_ID, master_id);
            SET_USERDEFAULT(MASTER, master);
            USERDEFAULT_SYN();
            //从哪里到哪里去
            [self.navigationController popViewControllerAnimated:YES];
            //如果第一次登陆，跳转到首页
            [self.navigationController dismissViewControllerAnimated:YES completion:^{

            }];
        }
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [[AlertManager alertManager] showError:3.0 string:@"请求失败"];
    }];
}
//注册
- (IBAction)registerAction:(id)sender {
   
    RegisterViewController *registerView = [RegisterViewController shareInstance];
    registerView.viewstyle = RegisterViewCtr;
    [self.navigationController pushViewController:registerView animated:YES];
}

//忘记密码
- (IBAction)forgetPswAction:(id)sender {
    
    RegisterViewController *registerView = [RegisterViewController shareInstance];
    registerView.viewstyle = ForgetPasswordCtr;
    [self.navigationController pushViewController:registerView animated:YES];
}

@end
