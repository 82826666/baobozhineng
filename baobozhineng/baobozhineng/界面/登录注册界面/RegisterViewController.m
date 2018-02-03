//
//  RegisterViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "AlertManager.h"
#import <AFNetworking.h>

@interface RegisterViewController ()
{
    NSString *verifyTimeStr;
}
@property (weak, nonatomic) IBOutlet AutoKeyboardField *phoneFiled;
@property (weak, nonatomic) IBOutlet AutoKeyboardField *passwordField;
@property (weak, nonatomic) IBOutlet AutoKeyboardField *repasswordField;
@property (weak, nonatomic) IBOutlet AutoKeyboardField *verifyField;
@property (weak, nonatomic) IBOutlet UILabel *getVerifyLabel;
@property (strong,nonatomic) NSTimer *verityTimer;
@end

@implementation RegisterViewController

static int vertifyTime=60;
- (void)viewDidLoad {
    [super viewDidLoad];
    //由于需要显示验证码的获取时常这里使用label
    _getVerifyLabel.layer.masksToBounds = YES;
    _getVerifyLabel.layer.cornerRadius =6;
    
    if(_viewstyle==ForgetPasswordCtr){
        _navbarTitleLab.text = @"忘记密码";
        [_enterButton setTitle:@"重置密码" forState:UIControlStateNormal];
        
    }
    else{
        
        _navbarTitleLab.text = @"手机注册";
        [_enterButton setTitle:@"注   册" forState:UIControlStateNormal];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vertifyTapAction)];
    [_getVerifyLabel addGestureRecognizer:tap];
    
    [_phoneFiled setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
    
    [_passwordField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
    [_repasswordField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
    [_verifyField setFieldDismissActionBymaskInView:self.view fieldBlock:^{
        
    }];
    
}

+(instancetype)shareInstance
{
   // return [[UIStoryboard storyboardWithName:LOGINREGISTERSTORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:REGISITERVIEWCONTROLLER];
    return VIEW_SHAREINSRANCE(LOGINREGISTERSTORYBOARD, REGISITERVIEWCONTROLLER);
}
//获取验证码
- (void)vertifyTapAction
{
//    if ([self canContinueByNeedVertify:false].length!=0) {
//
//        NSLog(@"%@",[self canContinueByNeedVertify:false]);
//
//        return;
//    }
    if (vertifyTime==60) {
            _verityTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(verifyTimeAction) userInfo:nil repeats:YES];
        [self sendCode];
    }
    else{

    }

}

-(BOOL)sendCode{
    NSString* phoneStr = _phoneFiled.text;
    NSString* type = @"1";
    NSDictionary *parameters = @{@"mobile": phoneStr, @"type": type};
    
    //判断注册的手机号是否为正确的手机号
    if (![CommonCode validateMobile:phoneStr]) {
        NSLog(@"请输入正确的手机号码");
        return NO;
    }
    //等待网络请求
    [SVProgressHUD mydefineShowWithStatus:nil];
    [[APIManager sharedManager] sendCodeWithParameters:parameters success:^(id data) {
        //请求数据成功
        NSDictionary *datadic = data;
        if ([[datadic objectForKey:@"code"] intValue] != 200) {
            //请求失败
            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
        }else{
            //请求成功
            [[AlertManager alertManager] showSuccess:3.0 string:[datadic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        //请求数据失败，网络错误
        [[AlertManager alertManager] showError:3.0 string:@"请求失败"];
    }];
    
    return YES;
}

- (void)verifyTimeAction
{
    vertifyTime--;
    if (vertifyTime>0) {
        
        _getVerifyLabel.text = [NSString stringWithFormat:@"重新获取(%d)秒",vertifyTime];
    }
    else{
           _getVerifyLabel.text = [NSString stringWithFormat:@"获取验证码"];
        [_verityTimer invalidate];
        _verityTimer = NULL;
        vertifyTime = 60;
    }
}

- (IBAction)enterRegisterAction:(id)sender {
    
    //判断输入的信息是否有误
    if ([self canContinueByNeedVertify:YES].length!=0) {
        
        NSLog(@"%@",[self canContinueByNeedVertify:YES]);
        return;
    }
    
    if (_viewstyle==ForgetPasswordCtr) {
        //执行注册接口
        [self regAndFog];
    }
    else{
        //执行重新设置密码接口
        [self regAndFog];
    }
}
-(void)regAndFog{
    NSString* phoneStr = _phoneFiled.text;
    NSString* password = _passwordField.text;
    NSString* code = _verifyField.text;
    NSString* repassword = _repasswordField.text;
    NSDictionary *parameters = @{@"mobile": phoneStr, @"password": password, @"code":code, @"repassword":repassword};
    if(_viewstyle==ForgetPasswordCtr){//忘记密码
        //等待网络请求
        [SVProgressHUD mydefineShowWithStatus:nil];
        [[APIManager sharedManager] registerWithParameters:parameters success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
            if ([[datadic objectForKey:@"code"] intValue] != 200) {
                //请求失败
                [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
            }else{
                //请求成功
                [[AlertManager alertManager] showSuccess:3.0 string:[datadic objectForKey:@"msg"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [[AlertManager alertManager] showError:3.0 string:@"请求失败"];
        }];
    }else{
        //等待网络请求
        [SVProgressHUD mydefineShowWithStatus:nil];
        [[APIManager sharedManager] registerWithParameters:parameters success:^(id data) {
            //请求数据成功
            NSDictionary *datadic = data;
            if ([[datadic objectForKey:@"code"] intValue] != 200) {
                //请求失败
                [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
            }else{
                //请求成功
                [[AlertManager alertManager] showSuccess:3.0 string:[datadic objectForKey:@"msg"]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            //请求数据失败，网络错误
            [[AlertManager alertManager] showError:3.0 string:@"请求失败"];
        }];
    }
}

- (NSString *)canContinueByNeedVertify:(BOOL)needVertify
{
    NSString *phoneStr = _phoneFiled.text;
    //判断注册的手机号是否为正确的手机号
    if (![CommonCode validateMobile:phoneStr]) {
        return @"请输入正确的手机号码";
    }
    NSString *passwordStr = _passwordField.text;
    //判断密码是否为空
    if (passwordStr.length==0) {
         return @"请输入密码";
    }
    NSString *repasswordStr = _repasswordField.text;
    //判断重新输入密码是否为空
    if (repasswordStr.length==0) {
       return @"请确认密码";
    }
    //判断验证码是否为空
    NSString *verifyStr = _verifyField.text;
    if (verifyStr.length==0&&needVertify) {
        return @"请输入验证码";
    }
    return  @"";
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
