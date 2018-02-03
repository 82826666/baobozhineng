//
//  RadioButton.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/25.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "RadioButton.h"

@implementation RadioButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    //设置按钮圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0f;
    [self setBackgroundColor:RGBA(0, 190, 243, 1.0)];
}

@end
