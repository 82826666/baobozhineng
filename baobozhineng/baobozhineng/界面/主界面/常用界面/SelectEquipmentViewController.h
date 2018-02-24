//
//  SelectEquipmentViewController.h
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/28.
//  Copyright © 2017年 吴建阳. All rights reserved.
// 选择设备界面

#import "ParentViewController.h"

@interface EquipObject:NSObject
//cell的标题
@property(nonatomic,copy) NSString *title;
//cell左边的图片
@property(nonatomic,strong) UIImage *image;
+(instancetype)objectWithTitle:(NSString*)title img:(NSString*)img;
@end

@interface SelectEquipmentViewController : ParentViewController

@end
