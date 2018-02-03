//
//  SelectHomeWIFIViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/28.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "SelectHomeWIFIViewController.h"
#define  Jiange_left 15
#define  Cell_Height 60
@interface SelectHomeWIFIViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *WIFIListTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation SelectHomeWIFIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //去除多余的横线
    UIView *view1111 = [[UIView alloc]init];
    view1111.backgroundColor = [UIColor whiteColor];
    [_WIFIListTableView setTableFooterView:view1111];
    
    _WIFIListTableView.delegate = self;
    _WIFIListTableView.dataSource = self;
    
    _dataArray = [NSMutableArray arrayWithArray:@[@"xiaomi_jisa",@"xiaomi_orign",@"xiaomimi"]];
    _WIFIListTableView.backgroundColor = MAIN_COLOR;
    
}
+(instancetype)shareInstance
{
    return VIEW_SHAREINSRANCE(MAINSTORYBOARD, SELECTHOMEWIFIVIEWCONTROLLER);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  Cell_Height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tablecell"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(Jiange_left, 0, SCREEN_WIDTH,Cell_Height )];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = RGBA(121, 121, 121, 1.0);
        label.font = [UIFont systemFontOfSize:16];
        label.tag = 1;
        [cell.contentView addSubview:label];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 15, 20, 20)];
        imgView.tag = 2;
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:imgView];
        cell.backgroundColor = CLEAR_COLOR;
        cell.contentView.backgroundColor = CLEAR_COLOR;
    }
    UILabel *lab = [cell.contentView viewWithTag:1];
    lab.text = _dataArray[indexPath.row];
    
    UIImageView *imgview = [cell.contentView viewWithTag:2];
    imgview.image = [UIImage imageNamed:@"in_arrow_right"];
    
    return cell;
}

@end
