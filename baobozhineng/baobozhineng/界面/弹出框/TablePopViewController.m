//
//  TablePopViewController.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/31.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "TablePopViewController.h"
#define CELL_HRIGHT 50

@interface TablePopViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (strong,nonatomic) NSArray *dataArray;
@property (nonatomic,copy) NSString *labelTitle;

@property (nonatomic,strong) NSMutableArray *selectedDataArray;
@end

@implementation TablePopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_contentView.layer setMasksToBounds:YES];
    [_contentView.layer setCornerRadius:8.0];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _titleLab.text = self.labelTitle;

}
- (void) setTitleLabel:(NSString *)title CellTitleArray:(NSArray *)celltitleArray Block:(selectAreaBlock)block {
    self.labelTitle = title;
    self.Block = block;
    self.dataArray = celltitleArray;
}

- (NSMutableArray *)selectedDataArray{
    
    if (!_selectedDataArray) {
        
        _selectedDataArray = [NSMutableArray array];
    }
    return  _selectedDataArray;
}

- (NSString *)labelTitle
{
    if (!_labelTitle) {
        _labelTitle  = @"选择区域";
    }
    return _labelTitle;
}

//添加按钮点击事件
- (IBAction)addAction:(id)sender {
    //升序
    NSArray *result = [_selectedDataArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2];
    }];
    //先以多选的方案返回数据
    NSMutableArray *dataarray = [NSMutableArray array];
    for (int i=0; i<result.count; i++) {
        [dataarray addObject: @{
                                @"selectIndex":result[i],
                                @"selectTitle":_dataArray[[result[i] intValue]]
                                }];
    }
    self.Block(dataarray);
    [self hiddenPopupView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//看要不要写死，不写死在call我,一般来说是不要写死的
- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray =@[@"客厅",@"餐厅",@"主卧",@"次卧",@"书房",@"走廊",@"厨房",@"浴室"];
    }
    
    return _dataArray;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  CELL_HRIGHT;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"popviewcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"popviewcell"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, cell.frame.size.height)];
        label.tag =1;
        label.textColor = RGBA(88, 88, 88, 1.0);
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
        
        UIImageView *rightimg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.9 - 20, CELL_HRIGHT/2-15, 20, 20)];
        rightimg.image = [UIImage imageNamed:@"in_arrow_right"];
        rightimg.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:rightimg];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UILabel *leftLabel = [cell.contentView viewWithTag:1];
    leftLabel.text = self.dataArray[indexPath.row];
    
    
    return  cell;
}
//不知道是多选还是单选，我先做多选，要做单选call我
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //判断是否点击，如果selectedDataArray里的数据已经有了index.row则移除并且结束方法
    for ( int i=0;i<self.selectedDataArray.count ; i++) {
        NSString *selectIndex = _selectedDataArray[i];
        if (indexPath.row == [selectIndex integerValue]) {
            
            cell.contentView.backgroundColor = [UIColor clearColor];
            [_selectedDataArray removeObjectAtIndex:i];
            return;
        }
    }
    //循环遍历_selectedDataArray没有发现存储点击cell的值则存储和改变背景颜色
    [_selectedDataArray addObject:[NSString stringWithFormat:@"%ld",indexPath.row]];
    cell.contentView.backgroundColor = RGBA(155, 155, 155, 0.8);
}
@end
