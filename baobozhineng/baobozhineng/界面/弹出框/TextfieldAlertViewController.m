//
//  TextFieldAlertViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2018/1/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "TextFieldAlertViewController.h"

@interface TextFieldAlertViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *texField;
@property (weak, nonatomic) IBOutlet RadioView *fieldPopview;
//标题名称
@property (nonatomic,copy) NSString *titleLabText;
@property (nonatomic, copy) NSString *texFieldText;
@end

@implementation TextFieldAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popupView = self.fieldPopview;
   self.titleLabel.text = _titleLabText;
    if(_texFieldText != nil){
        _texField.borderStyle = UITextBorderStyleNone;//设置边框风格
        _texField.userInteractionEnabled = NO;//设置不可编辑
        _texField.clearButtonMode = UITextFieldViewModeNever;
        self.texField.text = _texFieldText;
    }
    
}
//编辑名称
-(void)setTitle:(NSString *)title EnterBlock:(TextFieldAlertEnterBlock)enterBlock Cancle:(TextFieldAlertCancleBlock)cancleBlock
{
    _titleLabText = title;
    self.enterBlock = enterBlock;
    self.cancelBlock = cancleBlock;
}
//提示
-(void)setTitle:(NSString *)title textField:(NSString*)text EnterBlock:(TextFieldAlertEnterBlock)enterBlock Cancle:(TextFieldAlertCancleBlock)cancleBlock
{
    NSLog(@"titel:");
    _titleLabText = title;
    _texFieldText = text;
    self.enterBlock = enterBlock;
    self.cancelBlock = cancleBlock;
}
- (IBAction)cancelAction:(id)sender {
    [self hiddenPopupView];
    self.enterBlock(_texField.text);
}
- (IBAction)enterAction:(id)sender {
     [self hiddenPopupView];
     self.enterBlock(_texField.text);
}
@end
