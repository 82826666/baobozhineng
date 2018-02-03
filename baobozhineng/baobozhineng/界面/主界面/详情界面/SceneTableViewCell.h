//
//  SceneTableViewCell.h
//  baobozhineng
//
//  Created by wjy on 2018/2/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneTableViewCell.h"

@interface SceneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditonLabel;
@property (weak, nonatomic) IBOutlet UILabel *execute;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
+ (SceneTableViewCell *)cellWithTableView:(UITableView *)tableView;
- (void) setData:(NSDictionary*)data;
@end
