//
//  SelectHomeWIFIViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/28.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectHomeWIFIDelegate<NSObject>
- (void)selectWIFIActionName:(NSString *)WIFIStr;
@end
@interface SelectHomeWIFIViewController : ParentViewController

@property (nonatomic,weak) id<SelectHomeWIFIDelegate> delegate;
@end
