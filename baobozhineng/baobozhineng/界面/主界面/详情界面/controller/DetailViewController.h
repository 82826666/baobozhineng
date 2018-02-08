//
//  DetailViewController.h
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "ParentViewController.h"
#import "SceneTableViewCell.h"
#import "RecodeViewController.h"
#import "AddSceneViewController.h"
@interface DetailViewController : MainParentViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSouce;
@end
