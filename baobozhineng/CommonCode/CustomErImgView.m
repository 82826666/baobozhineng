//
//  CustomErImgView.m
//  InternetTaxiPassenger
//
//  Created by chenying on 16/2/22.
//  Copyright © 2016年 chenying. All rights reserved.
//

#import "CustomErImgView.h"

@implementation CustomErImgView

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    //设置边框颜色
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    //设置边框宽度
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    //设置圆角
    self.layer.cornerRadius = cornerRadius;
}

-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    _cornerRadius = frame.size.width/2;
    //设置圆角
    self.layer.cornerRadius = _cornerRadius;
}

@end

@implementation customerBtn
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    //设置边框颜色
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    //设置边框宽度
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    //设置圆角
    self.layer.cornerRadius = cornerRadius;
}
@end


@implementation customerLabel
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    //设置边框颜色
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    //设置边框宽度
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    //设置圆角
    self.layer.cornerRadius = cornerRadius;
}
@end


@implementation customerView
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    //设置边框颜色
    self.layer.borderColor = borderColor.CGColor;

}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    //设置边框宽度
    self.layer.borderWidth = borderWidth;

}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    //设置圆角
    self.layer.cornerRadius = cornerRadius;
  
}
@end

@implementation UIDashedLine

-(void)setThickness:(CGFloat)thickness{
    _thickness =thickness;
    [self setNeedsDisplay];
}
- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setIsVertical:(BOOL)isVertical{
    _isVertical = isVertical;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect {
    //设置虚线厚度
    CGFloat thickness = self.thickness == 0 ? 1 * 0.8 : self.thickness;
    
    CGContextRef cx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(cx, thickness);
    CGContextSetStrokeColorWithColor(cx, self.lineColor.CGColor);
    
    CGFloat ra[] = {3,0};
    CGContextSetLineDash(cx, 0.0, ra, 3); // nb "2" == ra count
    
    if (self.isVertical) {
        CGContextMoveToPoint(cx,0, thickness*0.5);
        CGContextAddLineToPoint(cx, thickness*0.5, self.bounds.size.height);
    } else {
        CGContextMoveToPoint(cx, 0,thickness*0.5);
        CGContextAddLineToPoint(cx, self.bounds.size.height, thickness*0.5);
    }
    
    CGContextStrokePath(cx);
}


@end

@implementation customerTextView
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    //设置边框颜色
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    //设置边框宽度
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    //设置圆角
    self.layer.cornerRadius = cornerRadius;
}

@end