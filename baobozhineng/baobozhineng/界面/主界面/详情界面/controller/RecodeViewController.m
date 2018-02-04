//
//  RecodeViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/4.
//  Copyright © 2018年 魏俊阳. All rights reserved.
//

#import "RecodeViewController.h"

@interface RecodeViewController ()

@end

@implementation RecodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    [self initDataSouce];
    [self initTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initNav{
    
//    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleDone target: self action:@selector(message)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    self.navigationItem.title = @"情景触发记录";
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
//    self.navigationItem.rightBarButtonItem = rightBtn;
}
- (void)initDataSouce{
    NSDictionary *one = @{@"img":@"in_scene_default.png",@"title":@"定时开",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *two = @{@"img":@"in_scene_select_leavehome.png",@"title":@"商家模式",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    NSDictionary *three = @{@"img":@"in_scene_select_getup.png",@"title":@"起床设置",@"condition":@"条件：定时",@"execute":@"执行大雨"};
    if(_dataSouce == nil){
        _dataSouce = [[NSMutableArray alloc]initWithObjects:one,two,three,nil];
    }
}
- (void) initTable{
    int width = SCREEN_WIDTH;
    int height = SCREEN_HEIGHT;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
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
    RecodeTableViewCell *cell  = [RecodeTableViewCell cellWithTableView:tableView];
    [cell setData:_dataSouce[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
