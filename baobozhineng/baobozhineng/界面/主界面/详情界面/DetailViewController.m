//
//  DetailViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/26.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initDataSouce];
    [self initTable];
    // Do any additional setup after loading the view.
}

- (void)initDataSouce{
    NSDictionary *one = @{@"img":@"in_scene_default.png",@"title":@"定时开",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *two = @{@"img":@"in_scene_default.png",@"title":@"商家模式",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *three = @{@"img":@"in_scene_default.png",@"title":@"起床设置",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    if(_dataSouce == nil){
        _dataSouce = [[NSMutableArray alloc]initWithObjects:one,two,three,nil];
    }
}
- (void) initNav{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleDone target: self action:nil];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.title = @"情景";
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void) initTable{
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height - 60;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, width, height) style:UITableViewStylePlain];
    _tableView.delegate = self;;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}
#pragma tableview datasouce
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSouce.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SceneTableViewCell *cell  = [SceneTableViewCell cellWithTableView:tableView];
    NSLog(@"section:%ld",indexPath.section);
    NSLog(@"row:%ld",indexPath.row);
    [cell setData:_dataSouce[indexPath.row]];
    return cell;
}



@end
