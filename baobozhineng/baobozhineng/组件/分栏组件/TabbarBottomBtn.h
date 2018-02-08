//
//  TabbarBottomBtn.h
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabbarBottomBtn : UIView
@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIImageView *imgView;
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Img:(UIImage*)img;
@end
