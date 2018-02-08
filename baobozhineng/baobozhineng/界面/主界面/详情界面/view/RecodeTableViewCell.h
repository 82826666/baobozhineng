//
//  RecodeTableViewCell.h
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecodeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;
+ (RecodeTableViewCell *)cellWithTableView:(UITableView *)tableView;
- (void) setData:(NSDictionary*)data;
@end
