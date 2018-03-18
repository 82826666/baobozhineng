//
//  CustomButtonView.h
//  testButton
//
//  Created by wjy on 2018/3/17.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomButtonViewDelegate<NSObject>

- (void)didClickBtn:(UIButton*)button;

@end

@interface CustomButtonView : UIView

-(instancetype)initWithFrame:(CGRect)frame image:(UIImage*)image sup:(NSString*)sup name:(NSString*)name;
/** 按钮 */
@property(nonatomic, strong) UIButton *btn;
/** 图片 */
@property(nonatomic, strong) UIImageView *imageView;
/** 角标 */
@property(nonatomic, strong) UILabel *supLabel;
/** 名称 */
@property(nonatomic, strong) UILabel *nameLabel;
/** 代理 */
@property (nonatomic, weak) id <CustomButtonViewDelegate>delegate;
@end

