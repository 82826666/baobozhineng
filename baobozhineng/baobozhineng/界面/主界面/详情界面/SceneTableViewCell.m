//
//  SceneTableViewCell.m
//  baobozhineng
//
//  Created by wjy on 2018/2/3.
//  Copyright © 2018年 魏俊阳. All rights reserved.
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
    NSLog(@"image:%@",[data objectForKey:@"img"]);
//    for (int i = 0; i < dataArray.count; i++) {
//    [_imageVi setImage:[UIImage imageNamed:@"in_scene_default"]];
//        _imageVi.image = [UIImage imageNamed:@"in_scene_default"];
        _titleLabel.text = [data objectForKey:@"title"];
        _conditonLabel.text = [data objectForKey:@"condition"];
        _execute.text = [data objectForKey:@"execute"];
//    }
}
@end
