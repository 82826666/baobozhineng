//
//  AddScene2ViewController.h
//  baobozhineng
//
//  Created by wjy on 2018/4/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "ParentViewController.h"

@interface AddScene2ViewController : UIViewController
@property(nonatomic, strong) NSDictionary *ifDic;
@property(nonatomic, strong) NSDictionary *thenDic;
-(void)setIfDic:(NSDictionary *)ifDic row:(CGFloat)row;
-(void)setThenDic:(NSDictionary *)thenDic row:(CGFloat)row;
@end
