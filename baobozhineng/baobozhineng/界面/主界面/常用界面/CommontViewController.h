//
//  CommontViewController.h
//  baobozhineng
//
//  Created by wjy on 2018/3/7.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, setNum) {
    setNumOne=1,
    setNumTwo = 2,
    setNumThree = 3,
    setNumFour = 4
};
@interface CommontViewController : MainParentViewController

@property (nonatomic) setNum setNum;

@end
