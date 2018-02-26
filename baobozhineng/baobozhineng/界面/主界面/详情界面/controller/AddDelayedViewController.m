//
//  AddDelayedViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/26.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "AddDelayedViewController.h"
#import "KMDatePicker.h"
@interface AddDelayedViewController ()<UITextFieldDelegate,KMDatePickerDelegate>{
    
}
@property (nonatomic, strong) UITextField *txtFCurrent;
@property(nonatomic, strong)UITextField *start_Time;
@property(nonatomic, strong)NSMutableDictionary *dic;

@end

@implementation AddDelayedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
    [self layoutUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)layoutSubviews{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = 50;
    UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(30, 60, width - 2*30, height)];
    
    UILabel *v1Label = [[UILabel alloc]initWithFrame:CGRectMake(0, height/2 - 10, 100, 20)];
    v1Label.text = @"开始时间";
    
    _start_Time = [[UITextField alloc]initWithFrame:CGRectMake(width / 2 - 20, height / 2 - 10, width - v1Label.bounds.size.width, 20)];
    _start_Time.placeholder = @"sdfa";
    
    UIView *v1LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50 - 0.5, width - 2*30, 0.5)];
    v1LineView.backgroundColor = [UIColor lightGrayColor];
    [v1 addSubview:v1Label];
    [v1 addSubview:_start_Time];
    [v1 addSubview:v1LineView];
    [self.view addSubview:v1];
}

- (void)layoutUI {
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0.0, 0.0, rect.size.width, 216.0);
    // 时分
    KMDatePicker *datePicker = [[KMDatePicker alloc]
                                initWithFrame:rect
                                delegate:self
                                datePickerStyle:KMDatePickerStyleHourMinute];
    _start_Time.inputView = datePicker;
    _start_Time.delegate = self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"test:");
    _txtFCurrent = textField;
}

#pragma mark - KMDatePickerDelegate
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(KMDatePickerDateModel *)datePickerDate {
    NSString *dateStr = [NSString stringWithFormat:@"%@:%@",
                         datePickerDate.hour,
                         datePickerDate.minute
                         ];
    _txtFCurrent.text = dateStr;
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
