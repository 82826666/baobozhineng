//
//  RadioView.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/29.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "RadioView.h"

@implementation RadioView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:5.0];
}

@end
