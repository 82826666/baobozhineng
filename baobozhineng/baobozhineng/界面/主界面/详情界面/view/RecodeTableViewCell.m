//
//  RecodeTableViewCell.m
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "RecodeTableViewCell.h"

@implementation RecodeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (RecodeTableViewCell *)cellWithTableView:(UITableView *)tableView {
    RecodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void) setData:(NSDictionary*)data{
    if(_dataArray == nil){
        _dataArray = [NSMutableArray new];
    }
    [_dataArray addObject:data];
    _imageVi.image = [UIImage imageNamed:[data objectForKey:@"img"]];
    _titleLabel.text = [data objectForKey:@"title"];
    _timeLabel.text = [data objectForKey:@"condition"];
    _statuLabel.text = [data objectForKey:@"execute"];
    _lineView.backgroundColor = [UIColor lightGrayColor];
}
@end
