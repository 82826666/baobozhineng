//
//  UIView+MydefineView.m
//  baobozhineng
//
//  Created by 吴建阳 on 2018/1/3.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "UIView+MydefineView.h"

@implementation UIView (MydefineView)

- (UIView *)subviewsWithTag:(NSInteger)tag
{
    NSArray *viewsArray = self.subviews;

    for (UIView *view in viewsArray) {
        
        if (view.tag ==tag) {
            return  view;
        }
    }
    return  nil;
}
@end
