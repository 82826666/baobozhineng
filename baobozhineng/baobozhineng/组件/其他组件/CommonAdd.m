//
//  CommonAdd.m
//  测试delete
//
//  Created by wjy on 2018/2/9.
//  Copyright © 2018年 baobo1. All rights reserved.
//

#import "CommonAdd.h"
@interface CommonAdd(){
    
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *reduceBtn;
@property (nonatomic, strong) UIView *lineView;
/** 屏幕中心点 */
@property (nonatomic, assign) CGFloat screenCenter;
@end
@implementation CommonAdd
- (instancetype)initWithFrame:(CGRect)frame title:(NSString*)title addBtn:(UIButton*)addBtn reduceBtn:(UIButton*)reduceBtn image:(UIImage*)image{
    if(self = [super initWithFrame:frame]){
        NSLog(@"1");
        self.imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
        if(image){
            self.imageView.image = image;
        }
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [self addSubview:_titleLabel];
        
        self.addBtn = addBtn;
        [self.addBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addBtn];
        
        self.reduceBtn = reduceBtn;
        [self.reduceBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reduceBtn];
        
        self.lineView = [[UIView alloc]init];
        [self addSubview:_lineView];
        
        _lineColor = [UIColor lightGrayColor];
        _titleColor = [UIColor blackColor];
        _backColor = [UIColor whiteColor];
        _leftOffset = 20;
        _rightOffset = 20;
        _width = 25;
        _heigth = 25;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = _backColor;
    self.lineView.backgroundColor = _lineColor;
    self.screenCenter = self.frame.size.height * 0.5;
    self.imageView.frame = CGRectMake(_leftOffset, self.screenCenter - _heigth/2, _width, _heigth);
    self.titleLabel.frame = CGRectMake(_leftOffset + _width + 10, self.screenCenter - 20/2, self.frame.size.width - _leftOffset - _rightOffset - (_width*2) - 20 * 2, 20);
    self.addBtn.frame = CGRectMake(self.frame.size.width - _rightOffset - (_width*2) - 20, self.screenCenter - _heigth/2, _width, _heigth);
    self.reduceBtn.frame = CGRectMake(self.frame.size.width - _rightOffset - _width, self.screenCenter - _heigth/2, _width, _heigth);
    self.lineView.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5);
}

-(void)click:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didClickBtn:currentView:titleLabel:)]) {
        [_delegate didClickBtn:sender currentView:self titleLabel:_titleLabel];
    }
}

- (void)setTitleColor:(UIColor*)titleColor{
    _titleColor = titleColor;
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
}

- (void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
}

-(void)setLeftOffset:(CGFloat)leftOffset{
    _leftOffset = leftOffset;
}

-(void)setRightOffset:(CGFloat)rightOffset{
    _rightOffset = rightOffset;
}

-(void)setWidth:(CGFloat)width{
    _width = width;
}

-(void)setHeigth:(CGFloat)heigth{
    _heigth = heigth;
}
@end
