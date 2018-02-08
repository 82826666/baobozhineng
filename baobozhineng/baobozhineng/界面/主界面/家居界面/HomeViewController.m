//
//  HomeViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "HomeViewController.h"
#import "NavBarView.h"
#import "HomeCellView.h"
#import "VerticalCenterTextLabel.h"
#define  HOMECELL_HEAD_HEIGHT  50
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,HomeCellSubviewsDelegate>
{
    double cell_height;
}
@property (weak, nonatomic) IBOutlet NavBarView *navBarView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray<NSArray*> *dataImgArray;
@property (strong, nonatomic) NSMutableArray<NSArray*> *dataTitleArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    cell_height= CGFLOAT_MIN;

    
    _dataImgArray = [NSMutableArray array];
    _dataTitleArray = [NSMutableArray array];
//    for ( int i =0; i<2; i++) {
//        
//        [_dataImgArray addObject:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight"]];
//        [_dataTitleArray addObject:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯"]];
//        
//    }
    [_dataImgArray addObject:@[]];
    [_dataTitleArray addObject:@[]];
    [_dataImgArray addObject:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight"]];
    [_dataTitleArray addObject:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯"]];
   
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navBarView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BOTTOMVIEW_HEIGTH- CGRectGetMaxY(_navBarView.frame)) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MAIN_COLOR;
//        UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
//        footview.backgroundColor =CLEAR_COLOR;
//        _tableView.tableFooterView = footview;
    }
    return  _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataImgArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  HOMECELL_HEAD_HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array =_dataTitleArray[indexPath.section];
    return  [HomeCellView cellHeight:(int)array.count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HOMECELL_HEAD_HEIGHT)];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, SCREEN_HEIGHT-15, HOMECELL_HEAD_HEIGHT)];
    headLabel.text = @"测试";
    headLabel.textAlignment = NSTextAlignmentLeft;
    headLabel.font = [UIFont systemFontOfSize:16];
    headLabel.textColor = RGBA(88, 88, 88, 1.0);
    [headView addSubview:headLabel];
    return  headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN)];
}
//setImgArray:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight",@"in_equipment_lamp_mirrorlamp",@"in_equipment_lamp_downlight",@"in_equipment_lamp_chandelier",@"in_equipment_aiming_default"] titleArray:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯",@"壁灯",@"浴灯",@"吊灯",@"白织灯"]
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTableCell"];
    
    if (!cell) {
        
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homeTableCell"];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    HomeCellView *homeCell = [[HomeCellView alloc] initWithTitleArray:_dataTitleArray[indexPath.section] ImgArray:_dataImgArray[indexPath.section]];
    homeCell.delegate =self;
    cell.backgroundColor = CLEAR_COLOR;
    [cell.contentView addSubview:homeCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
- (void)subviewsClickWith:(NSInteger)index Image:(UIImage *)image Title:(NSString *)title SuperView:(UIView *)superView
{
    NSIndexPath *indexpath =  [_tableView indexPathForCell:superView.superview.superview];
    NSLog(@"%ld",indexpath.section
          );
}

+(instancetype)shareInstance
{
    return  VIEW_SHAREINSRANCE(HOMESTORYBOARD, HOMEVIEWCONTROLLER);
}



@end
