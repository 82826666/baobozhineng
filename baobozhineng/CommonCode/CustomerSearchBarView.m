//
//  CustomerSearchBarView.m
//  BishuoParking
//
//  Created by chenying on 16/7/6.
//  Copyright © 2016年 chenying. All rights reserved.
//

#import "CustomerSearchBarView.h"
#import "CommonCode.h"

@implementation CustomerSearchBarView


- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor {
        UIView *searchTextField = nil;
        if (IOS_7_OR_LATER) {
                // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
            self.barTintColor = backgroundColor;
            self.backgroundColor = [UIColor clearColor];
                searchTextField = [[[self.subviews firstObject] subviews] lastObject];
            } else { // iOS6以下版本searchBar内部子视图的结构不一样
                    for (UIView *subView in self.subviews) {
                             if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                                     searchTextField = subView;
                                 }
                         }
                }
    
         searchTextField.backgroundColor = backgroundColor;
     }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
