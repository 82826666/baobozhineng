//
//  DetailViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSouce;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initTable];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void) initNav{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleDone target: self action:@selector(message)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationItem.title = @"情景";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void) initTable{
    int width = SCREEN_WIDTH;
    int height = SCREEN_HEIGHT - 60;
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
    [cell setData:_dataSouce[indexPath.row]];
    return cell;
}

- (void)message{
    [self.navigationController pushViewController:[[RecodeViewController alloc]init] animated:YES];
}

- (void)add{
//    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:];
    [self.navigationController pushViewController:[[AddSceneViewController alloc]init] animated:YES];
}

-(void)loadData{
    [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([dic objectForKey:@"data"] != nil) {
            NSArray *arr = [dic objectForKey:@"data"];
            for (int i = 0; i < arr.count; i++) {
                [self.dataSouce addObject:[arr objectAtIndex:i]];
            }
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSMutableArray*)dataSouce{
    if (_dataSouce == nil) {
        _dataSouce = [NSMutableArray new];
    }
    return _dataSouce;
}

@end
