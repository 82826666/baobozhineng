//
//  DetailViewController.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/26.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "ParentViewController.h"
#import "SceneTableViewCell.h"
@interface DetailViewController : MainParentViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSouce;
@end
