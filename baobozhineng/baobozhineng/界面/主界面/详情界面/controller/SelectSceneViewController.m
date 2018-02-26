//
//  SelectSceneViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/26.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "SelectSceneViewController.h"

@interface SelectSceneViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (nonatomic, strong) UITableView         *tableView;
@end

@implementation SelectSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
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
    [cell setSeparatorInset:UIEdgeInsetsZero];
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:@"in_equipment_switch_three"];
        cell.textLabel.text = @"本情景";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"in_equipment_switch_three"];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(60 + 15, 5, SCREEN_WIDTH - 60 - 15, 11)];
        title.font =  [UIFont systemFontOfSize:11];
        title.text = @"情景名称";
        UILabel *sub = [[UILabel alloc]initWithFrame:CGRectMake(60 + 15, 21, SCREEN_WIDTH - 60 - 15, 8)];
        sub.text = @"条件：温度高于";
        sub.font = [UIFont systemFontOfSize:8];
        UILabel *des = [[UILabel alloc]initWithFrame:CGRectMake(60 + 15, 34, SCREEN_WIDTH - 60 - 15, 8)];
        des.text = @"执行：本情景禁用";
        des.font = [UIFont systemFontOfSize:8];
        [cell.contentView addSubview:title];
        [cell.contentView addSubview:sub];
        [cell.contentView addSubview:des];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectZero];
    return v;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc]initWithFrame:CGRectZero];
    return v;
}
-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
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
