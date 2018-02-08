//
//  HomeCellView.m
//  baobozhineng
//
//  Created by 吴建阳 on 2018/1/4.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "HomeCellView.h"
#import "VerticalCenterTextLabel.h"
#define BTNVIEW_HEIGHT 80
@interface HomeCellView()
@property (nonatomic,strong) NSArray* imgArray;
@property (nonatomic,strong) NSArray* titleArray;
@end
@implementation HomeCellView

- (instancetype)initWithTitleArray:(NSArray*)titleArray ImgArray:(NSArray *)imgArray
{
    self =  [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,[HomeCellView cellHeight:(int)titleArray.count])];
    if (titleArray.count==0) {
        return self;
    }
    _imgArray = imgArray;
    _titleArray = titleArray;
    
    for (int i=0; i<titleArray.count; i++) {
        
        UIView *btnview = [self cellSubviewsFrame:CGRectMake((i%4)*SCREEN_WIDTH/4, i/4*BTNVIEW_HEIGHT+5, SCREEN_WIDTH/4, BTNVIEW_HEIGHT) Title:titleArray[i] SubTitle:@"" ImageStr:imgArray[i]];
        btnview.tag = i+1;
        [self addSubview:btnview];
        
    }
    self.backgroundColor = CLEAR_COLOR;
    
    return  self;
}

- (UIView *)cellSubviewsFrame:(CGRect)frame Title:(NSString *)title SubTitle:(NSString *)subtitle ImageStr:(NSString*)imgStr
{
    UIView *viewbtn = [[UIView alloc] initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height-20-10)];
    imageView.image = [UIImage imageNamed:imgStr];
    imageView.tag =1;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [viewbtn addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), viewbtn.frame.size.width,20 )];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor=  RGBA(88, 88, 88, 1.0);
    label.text = title;
    label.tag =2;
    [viewbtn addSubview:label];
    
    VerticalCenterTextLabel *subTextLab = [[VerticalCenterTextLabel alloc] initWithFrame:CGRectMake(viewbtn.frame.size.width/2, 0, viewbtn.frame.size.width/2,viewbtn.frame.size.height)];
    subTextLab.font = [UIFont systemFontOfSize:12];
    subTextLab.text = subtitle;
    subTextLab.textColor =RGBA(121, 121, 121, 1.0);
    subTextLab.lineBreakMode = UILineBreakModeWordWrap;
    subTextLab.numberOfLines = 0;
    subTextLab.textAlignment =NSTextAlignmentCenter;
    subTextLab.verticalAlignment =  myVerticalAlignmentTop;
    subTextLab.tag = 3;
    [viewbtn addSubview:subTextLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, viewbtn.frame.size.width, viewbtn.frame.size.height)];
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [viewbtn addSubview: btn];
    
    return  viewbtn;
}
- (void)clickAction:(UIButton *)sender
{
    UIView *view = sender.superview;
    NSInteger tag = view.tag;
    UIView *superView = view.superview;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(subviewsClickWith:Image:Title:SuperView:)]) {
        [self.delegate subviewsClickWith:tag Image:_imgArray[tag-1] Title:_titleArray[tag-1] SuperView:superView];
    }
}

+ (double)cellHeight:(int)count
{
    if (count==0) {
        return  CGFLOAT_MIN;
    }
    return BTNVIEW_HEIGHT*(count/4+1);
}
@end
