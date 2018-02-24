//
//  HouseTableViewCell.m
//  baobozhineng
//
//  Created by wjy on 2018/2/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "HouseTableViewCell.h"
static NSString* cellIndent = @"HouseTableViewCell";
@implementation HouseTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (HouseTableViewCell *)cellWithTableView:(UITableView *)tableView {
    HouseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
#pragma mark - 设置轮播数据
- (void)setDataArray:(NSMutableArray *)dataArray {
    if(dataArray != nil && ![dataArray isKindOfClass:[NSNull class]] && dataArray.count != 0){
//        _btn2Image.hidden = YES;
//        _btn2Label.hidden = YES;
        _btn1Image.image = [UIImage imageNamed:@"ico_list"];
        //button长按事件
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        
         longPress.minimumPressDuration = 0.8; //定义按的时间
        
          [_btn1 addGestureRecognizer:longPress];
        NSLog(@"slhajf");
    }
}
-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
        if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        
//               NSLog(@"长按事件");
            TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
            [textfieldAlert setTitle:@"提示" textField:@"你确定要删除吸顶灯吗？" EnterBlock:^(NSString *text) {
                
            } Cancle:^(NSString *text) {
                
            }];
            [textfieldAlert showWithParentViewController:nil];
            [textfieldAlert showPopupview];
            }
    
    }
- (IBAction)clickBtn:(UIButton *)sender {
    NSLog(@"234");
}
@end
