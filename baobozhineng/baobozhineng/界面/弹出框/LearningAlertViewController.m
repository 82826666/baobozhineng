//
//  LearningAlertViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/1/29.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "LearningAlertViewController.h"

@interface LearningAlertViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *learningLabel;
@property (weak, nonatomic) IBOutlet RadioView *learningPopview;
@property (nonatomic, copy) NSString* titleLab;
@property (nonatomic, copy) NSString* learningLab;
@end

@implementation LearningAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popupView = self.learningPopview;
    _titleLabel.text = self.titleLab;
    _learningLabel.text = self.learningLab;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setTitle:(NSString *)title learning:(NSString*)learning Cancle:(LearningAlertCancleBlock)cancleBlock
{
    if(title){
        self.titleLab = title;
    }
    if(learning){
        self.learningLab = learning;
    }
    self.cancelBlock = cancleBlock;
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self hiddenPopupView];
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
