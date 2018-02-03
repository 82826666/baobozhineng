//
//  CustomErImgView.h
//  InternetTaxiPassenger
//
//  Created by chenying on 16/2/22.
//  Copyright © 2016年 chenying. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface CustomErImgView : UIImageView
///边框颜色
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

///边框宽度
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

///设置圆角
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

@end


IB_DESIGNABLE
@interface customerBtn : UIButton
///边框颜色
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

///边框宽度
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

///设置圆角
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

@end

IB_DESIGNABLE
@interface customerLabel : UILabel
///边框颜色
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

///边框宽度
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

///设置圆角
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

@end

IB_DESIGNABLE
@interface customerView : UIView
///边框颜色
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

///边框宽度
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

///设置圆角
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

@end


IB_DESIGNABLE
@interface UIDashedLine : UIView

///边框颜色
@property (strong, nonatomic) IBInspectable UIColor *lineColor;
///设置厚度
@property (assign, nonatomic) IBInspectable CGFloat thickness;
///是否竖直方向
@property (assign, nonatomic) IBInspectable BOOL isVertical;

@end

IB_DESIGNABLE
@interface customerTextView : UITextView
///边框颜色
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

///边框宽度
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;

///设置圆角
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

@end
