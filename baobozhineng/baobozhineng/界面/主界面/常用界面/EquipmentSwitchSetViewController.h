//
//  EquipmentSwitchSetViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/29.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//开关设置界面

typedef NS_ENUM(NSUInteger, EquipmentSwitchSetNum) {
    SwitchSetNumOne=1,
    SwitchSetNumTwo,
    SwitchSetNumThree,
    SwitchSetNumFour
};

#import "ParentViewController.h"

@interface EquipmentSwitchSetViewController : ParentViewController

@property (nonatomic) EquipmentSwitchSetNum switchSetNum;
@property (nonatomic,copy) NSString *switchtitle;
@end
