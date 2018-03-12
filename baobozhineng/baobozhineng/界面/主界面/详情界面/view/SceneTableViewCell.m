//
//  SceneTableViewCell.m
//  baobozhineng
//
//  Created by wjy on 2018/2/3.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "SceneTableViewCell.h"

@implementation SceneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

+ (SceneTableViewCell *)cellWithTableView:(UITableView *)tableView {
    SceneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
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
    _imageVi.image = [UIImage imageNamed:[CommonCode getImageName: [[data objectForKey:@"icon"] integerValue]]];
    _titleLabel.text = [data objectForKey:@"name"];
    _conditonLabel.text = @"条件：温度高于20";
    _execute.text = @"执行：本情景 禁用";
}
@end
