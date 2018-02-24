//
//  RecodeViewController.h
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "ParentViewController.h"
#import "RecodeTableViewCell.h"
@interface RecodeViewController : ParentViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSouce;
@end
