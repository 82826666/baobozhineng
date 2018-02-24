//
//  HouseTableViewCell.h
//  baobozhineng
//
//  Created by wjy on 2018/2/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextfieldAlertViewController.h"
@interface HouseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *btn1Image;
@property (weak, nonatomic) IBOutlet UILabel *btn1Label;

@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *btn2Image;
@property (weak, nonatomic) IBOutlet UILabel *btn2Label;

@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIImageView *btn3Image;
@property (weak, nonatomic) IBOutlet UILabel *btn3Label;

@property (weak, nonatomic) IBOutlet UIButton *bt4;
@property (weak, nonatomic) IBOutlet UIImageView *btn4Image;
@property (weak, nonatomic) IBOutlet UILabel *btn4Label;
+ (HouseTableViewCell *)cellWithTableView:(UITableView *)tableView;
- (void)setDataArray:(NSMutableArray *)dataArray;
- (IBAction)clickBtn:(UIButton *)sender;
@end
