//
//  getSensorViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/15.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "getSensorViewController.h"
#import "APIManager.h"
#import "UsualViewcontroller.h"

@interface getSensorViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation getSensorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView*)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"SelectSensorViewController";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //2.如果没有找到，自己创建单元格对象
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row];
    [cell.contentView addSubview:[self getView:[UIImage imageNamed:@"in_telecontro_list_satellitetv"] title:[dic objectForKey:@"name"] condition:@"test" action:@"test"]];
    return cell;
}

-(UIView*)getView:(UIImage*)image title:(NSString*)tit condition:(NSString*)con action:(NSString*)act{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    imageView.image = image;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH - 60, 15)];
    title.text = tit;
    [title setFont:[UIFont systemFontOfSize:14]];
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(60, 19, SCREEN_WIDTH - 60, 10)];
    detail.text = con;
    [detail setFont:[UIFont systemFontOfSize:10]];
    UILabel *detail2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 31, SCREEN_WIDTH - 60, 10)];
    [detail2 setFont:[UIFont systemFontOfSize:10]];
    detail2.text = act;
    [view addSubview:imageView];
    [view addSubview:title];
    [view addSubview:detail];
    [view addSubview:detail2];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.dataArr objectAtIndex:indexPath.row];
    NSDictionary *params = @{@"master_id":GET_USERDEFAULT(MASTER_ID),@"scene_id":[dic objectForKey:@"id"],@"order":@"0"};
    NSLog(@" parms:%@",params);
    [[APIManager sharedManager]deviceAddSceneShortcutWithParameters:params success:^(id data) {
        NSDictionary *datadic = data;
        NSLog(@"data:%@",data);
        if([[datadic objectForKey:@"code"] intValue] == 200){
            [self.navigationController pushViewController:[UsualViewcontroller shareInstance] animated:YES];
        }else{
            [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)loadData{
    [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([dic objectForKey:@"data"] == nil) {
            
        }else{
            self.dataArr = [dic objectForKey:@"data"];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(NSMutableArray*)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
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
