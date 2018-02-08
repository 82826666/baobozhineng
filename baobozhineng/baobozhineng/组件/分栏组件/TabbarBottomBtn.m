//
//  TabbarBottomBtn.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "TabbarBottomBtn.h"

@implementation TabbarBottomBtn
//分栏的底部按钮
- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title Img:(UIImage*)img
{
    if (self=[super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height/3*2-5)];
        _imgView.image = img;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imgView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame), frame.size.width, frame.size.height/3)];
        _label.textAlignment =NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:12];
        _label.textColor = RGBA(121, 121, 121, 1.0);
        _label.text = title;
        [self addSubview:_label];
        
    }
    return  self;
}

@end
