//
//  AddSceneViewController.h
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "ParentViewController.h"
#import "RecodeViewController.h"
#import <Masonry.h>
@interface AddSceneViewController : ParentViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, strong) NSMutableArray* dataSouce;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UILabel *buttonLable;
@end
