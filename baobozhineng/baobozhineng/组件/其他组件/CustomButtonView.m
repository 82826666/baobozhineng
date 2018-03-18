//
//  CustomButtonView.m
//  testButton
//
//  Created by wjy on 2018/3/17.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "CustomButtonView.h"
#import <YYKit.h>
@interface CustomButtonView(){
    
}
@end

@implementation CustomButtonView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image sup:(NSString*)sup name:(NSString*)name{
    if (self == [super initWithFrame:frame]) {
        self.btn.size = self.frame.size;
        self.imageView.size = CGSizeMake(20, 20);
        self.imageView.frame = CGRectMake((self.frame.size.width - self.imageView.width)/2, 10, 40, 40);
        self.imageView.image = image;
        self.supLabel.frame = CGRectMake(self.imageView.right + 5, self.imageView.top, self.frame.size.width - self.imageView.right - 5, 20);
        self.supLabel.text = sup;
        self.nameLabel.frame = CGRectMake(0, self.imageView.bottom + 10, self.frame.size.width, 20);
        self.nameLabel.text = name;
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.btn addSubview:self.imageView];
        [self.btn addSubview:self.nameLabel];
        [self.btn addSubview:self.supLabel];
        [self.btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
        
    }
    return self;
}

-(void)didClickBtn:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(didClickBtn:)]) {
        [_delegate didClickBtn:sender];
    }
}

-(UIButton*)btn{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btn;
}

-(UIImageView*)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

-(UILabel*)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}

-(UILabel*)supLabel{
    if (_supLabel == nil) {
        _supLabel = [UILabel new];
    }
    return _supLabel;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

