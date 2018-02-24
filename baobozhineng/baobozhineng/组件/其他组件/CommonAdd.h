//
//  CommonAdd.h
//  测试delete
//
//  Created by wjy on 2018/2/9.
//  Copyright © 2018年 baobo1. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CommonAddDelegate<NSObject>

- (void)didClickBtn:(UIButton*)button currentView:(UIView *)currentView titleLabel:(UILabel *)titleLabel;

@end

@interface CommonAdd : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title addBtn:(UIButton*)addBtn reduceBtn:(UIButton*)reduceBtn image:(UIImage*)image;
/** 文字颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** 线条颜色 */
@property (nonatomic, strong) UIColor *lineColor;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *backColor;

/** 左边偏移值 */
@property (nonatomic, assign) CGFloat leftOffset;

/** 右边边偏移值 */
@property (nonatomic, assign) CGFloat rightOffset;

/** 图片宽 */
@property (nonatomic, assign) CGFloat width;

/** 图片高 */
@property (nonatomic, assign) CGFloat heigth;

/** 代理 */
@property (nonatomic, weak) id <CommonAddDelegate>delegate;
@end

