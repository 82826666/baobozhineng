//
//  DetailViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "getSensorViewController.h"
#import "AddScene2ViewController.h"
#import "SceneTableViewCell.h"
@interface getSensorViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataSouce;

@end

@implementation getSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initTable];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void) initNav{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target: self action:@selector(goBack)];
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationItem.title = @"情景";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
//    self.navigationItem.rightBarButtonItem = rightBtn;
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
#pragma tableview datasouce
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataSouce[indexPath.row];
    NSDictionary *params = @{
                             @"master_id":GET_USERDEFAULT(MASTER_ID),
                             @"scene_id":[dic objectForKey:@"id"],
                             @"order":@"0"
                             };
    [[APIManager sharedManager]deviceAddSceneShortcutWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
        if ([[datadic objectForKey:@"code"] intValue] == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 返回
- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)message{
//    [self.navigationController pushViewController:[[RecodeViewController alloc]init] animated:YES];
//}

- (void)add{
    //    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:];
    [self.navigationController pushViewController:[[AddScene2ViewController alloc]init] animated:YES];
}

-(void)loadData{
    [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"data"] count] > 0) {
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
