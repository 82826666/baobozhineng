//
//  getSensorViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/15.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "getSensorViewController.h"
#import "APIManager.h"

@interface getSensorViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property(nonatomic, strong) UITableView *tableView;
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
    return 1;
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
    [cell.contentView addSubview:[self getView]];
    return cell;
}

-(UIView*)getView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 40, 40)];
    imageView.image = [UIImage imageNamed:@"in_telecontro_list_satellitetv"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60, 2, SCREEN_WIDTH - 60, 15)];
    title.text = @"text";
    [title setFont:[UIFont systemFontOfSize:14]];
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(60, 19, SCREEN_WIDTH - 60, 10)];
    detail.text = @"detail";
    [detail setFont:[UIFont systemFontOfSize:10]];
    UILabel *detail2 = [[UILabel alloc]initWithFrame:CGRectMake(60, 31, SCREEN_WIDTH - 60, 10)];
    [detail2 setFont:[UIFont systemFontOfSize:10]];
    detail2.text = @"detail2";
    [view addSubview:imageView];
    [view addSubview:title];
    [view addSubview:detail];
    [view addSubview:detail2];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)loadData{
    [[APIManager sharedManager]deviceGetSceneListsWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([dic objectForKey:@"data"] == nil) {
            
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
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
