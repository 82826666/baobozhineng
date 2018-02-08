//
//  HomeCellView.h
//  baobozhineng
//
//  Created by 吴建阳 on 2018/1/4.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeCellSubviewsDelegate <NSObject>

- (void)subviewsClickWith:(NSInteger)index Image:(UIImage *)image Title:(NSString *)title SuperView:(UIView *)superView;

@end

@interface HomeCellView : UIView

@property (nonatomic,weak) id<HomeCellSubviewsDelegate> delegate;

- (instancetype)initWithTitleArray:(NSArray*)titleArray ImgArray:(NSArray *)imgArray;

+ (double)cellHeight:(int)count;

@end
