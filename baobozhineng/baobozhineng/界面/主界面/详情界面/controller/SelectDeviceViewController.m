//
//  HouseViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/2/1.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "SelectDeviceViewController.h"
#import "CKAlertViewController.h"
#import "KeyViewController.h"
#import "AddScene2ViewController.h"
#import <YYKit.h>
static NSString *identifier = @"cellID";
static NSString *headerReuseIdentifier = @"hearderID";
@interface SelectDeviceViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    
}
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableDictionary* room;
@property (nonatomic, strong) NSMutableArray* sectionArray;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) NSMutableArray* stateArray;
@end

@implementation SelectDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"家居";
    
    //创建布局，苹果给我们提供的流布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //设置顶部高度
    flow.headerReferenceSize = CGSizeMake(0, 50);
    
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 55);
    self.collectionView.collectionViewLayout = flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    //注册header
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier];
    
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self createLongPressGesture];
    [self loadData];
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataSource.count;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([self.stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSArray *array = [self.dataSource objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [self.dataSource objectAtIndex:indexPath.section];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [cell.contentView removeAllSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:[dic objectForKey:@"icon"]]];
    imageView.frame = CGRectMake(0, 15, 50, 50);
    imageView.centerX = cell.contentView.centerX;
    
    UILabel *sup = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right - 15, -5, 40, 30)];
    sup.text = [dic objectForKey:@"status"] == NULL ? @"关" : @"开";
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, SCREEN_WIDTH/4, 30)];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = [dic objectForKey:@"name"];
    
    [cell.contentView addSubview:imageView];
    [cell.contentView addSubview:sup];
    [cell.contentView addSubview:name];
    
    return cell;
}

//设置collection头部/尾部
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdentifier forIndexPath:indexPath];
        
        [headerView removeAllSubviews];
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 0.5)];
        line1.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, line1.bottom + 10, SCREEN_HEIGHT, 30)];
        label.text = [self.sectionArray objectAtIndex:indexPath.section];
        //        NSLog(@"sec:%ld",indexPath.section);
        //        NSLog(@"text:%@",[self.sectionArray objectAtIndex:indexPath.section]);
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, label.bottom + 10, SCREEN_HEIGHT, 0.5)];
        line2.backgroundColor = [UIColor lightGrayColor];
        
        [headerView addSubview:line1];
        [headerView addSubview:label];
        [headerView addSubview:line2];
        //创建长按手势监听
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(sectionHeaderLongPressed:)];
        longPress.minimumPressDuration = 0.001;
        longPress.accessibilityValue = [NSString stringWithFormat:@"%ld",indexPath.section];
        //将长按手势添加到需要实现长按操作的视图里
        [headerView addGestureRecognizer:longPress];
        return headerView;
    }
    return nil;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr = [self.dataSource objectAtIndex:indexPath.section];
    NSDictionary *dic = [arr objectAtIndex:indexPath.row];
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[AddScene2ViewController class]]) {
            AddScene2ViewController *con = (AddScene2ViewController*)controller;
            if (_tempDic == nil) {
                _row = -1;
            }
            [con setIfDic:dic row:_row];
            [self.navigationController popToViewController:con animated:YES];
        }
    }
    //    NSLog(@"%ld-%ld",indexPath.section,indexPath.row);
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if ([[self.stateArray objectAtIndex:section] integerValue] == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int itemW = (self.view.frame.size.width - 5*10) / 4;
    return CGSizeMake(itemW, itemW / 0.68);
}

#pragma mark ————— 懒加载 —————
-(UICollectionView*)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flow];
        
        _collectionView.dataSource = self;
        
        _collectionView.delegate = self;
        
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

-(NSMutableDictionary *)room{
    if (_room == nil) {
        _room = [NSMutableDictionary new];
    }
    return _room;
}

-(NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray new];
    }
    return _sectionArray;
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableArray *)stateArray{
    if (_stateArray == nil) {
        _stateArray = [NSMutableArray new];
    }
    return _stateArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 创建长按手势
- (void)createLongPressGesture{
    //创建长按手势监听
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(cellLongPressed:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里
    [self.collectionView addGestureRecognizer:longPress];
}
#pragma mark - cell的长按处理事件
- (void) cellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {
    CGPoint pointTouch = [gestureRecognizer locationInView:self.collectionView];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointTouch];
        //        NSLog(@"sec:%ld,row:%ld",indexPath.section,indexPath.row);
        if (indexPath == nil) {
            NSLog(@"空");
        }else{
            NSArray *arr = [self.dataSource objectAtIndex:indexPath.section];
            NSDictionary *rowDic = [arr objectAtIndex:indexPath.row];
            CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"操作" message:@"" ];
            
            CKAlertAction *edit = [CKAlertAction actionWithTitle:@"修改设备" handler:^(CKAlertAction *action) {
                KeyViewController *con = [KeyViewController new];
                if ([[rowDic objectForKey:@"type"] integerValue] == 20111) {
                    con.setNum = setNumOne;
                    con.dataDic = rowDic;
                }else if([[rowDic objectForKey:@"type"] integerValue] == 20121) {
                    con.setNum = setNumTwo;
                    con.dataDic = rowDic;
                }else if([[rowDic objectForKey:@"type"] integerValue] == 20131) {
                    con.setNum = setNumThree;
                    con.dataDic = rowDic;
                }else if([[rowDic objectForKey:@"type"] integerValue] == 20141) {
                    con.setNum = setNumFour;
                    con.dataDic = rowDic;
                }
                [self.navigationController pushViewController:con animated:YES];
            }];
            
            CKAlertAction *delete = [CKAlertAction actionWithTitle:@"删除设备" handler:^(CKAlertAction *action) {
                [[APIManager sharedManager]deviceDeleteTwowaySwitchWithParameters:@{@"device_id":[rowDic objectForKey:@"id"]} success:^(id data) {
                    NSDictionary *dic = data;
                    [[AlertManager alertManager] showError:3.0 string:[dic objectForKey:@"msg"]];
                    if ([[dic objectForKey:@"code"] integerValue] == 200) {
                        [self loadData];
                    }
                } failure:^(NSError *error) {
                    [[AlertManager alertManager] showError:3.0 string:@"服务器异常"];
                }];
            }];
            
            CKAlertAction *updateLater = [CKAlertAction actionWithTitle:@"" handler:^(CKAlertAction *action) {
                
            }];
            
            [alertVC addAction:edit];
            [alertVC addAction:delete];
            [alertVC addAction:updateLater];
            [self presentViewController:alertVC animated:NO completion:nil];
        }
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"长按手势改变，发生长按拖拽动作执行该方法");
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"长按手势结束");
    }
}
#pragma mark - sectionHeader的长按处理事件
- (void) sectionHeaderLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //所有的分区都是闭合
        NSInteger section = [gestureRecognizer.accessibilityValue integerValue];
        if ([[self.stateArray objectAtIndex:section] integerValue] == 1) {
            [self.stateArray replaceObjectAtIndex:section withObject:@"0"];
        }else{
            [self.stateArray replaceObjectAtIndex:section withObject:@"1"];
        }
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
    }
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
    }
}
#pragma mark - 数据加载
-(void)loadData{
    [[APIManager sharedManager]deviceGetMasterRoomWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"]integerValue] == 200) {
            [self.room removeAllObjects];
            NSArray *room = [dic objectForKey:@"data"];
            for (int i = 0; i < room.count; i ++) {
                NSDictionary *roomOne = [room objectAtIndex:i];
                [self.room setValue:[roomOne objectForKey:@"name"] forKey:[NSString stringWithFormat:@"%@",[roomOne objectForKey:@"id"]]];
            }
            [[APIManager sharedManager]deviceGetDeviceInfoWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
                NSDictionary *dic = data;
                if ([[dic objectForKey:@"code"]integerValue] == 200) {
                    NSArray *testArray = [dic objectForKey:@"data"];
                    // 获取array中所有index值
                    NSArray *indexArray = [testArray valueForKey:@"room_id"];
                    // 将array装换成NSSet类型
                    NSSet *indexSet = [NSSet setWithArray:indexArray];
                    // 新建array，用来存放分组后的array
                    NSMutableArray *resultArray = [NSMutableArray array];
                    // NSSet去重并遍历
                    [[indexSet allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        // 根据NSPredicate获取array
                        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room_id == %@",obj];
                        NSArray *indexArray = [testArray filteredArrayUsingPredicate:predicate];
                        
                        // 将查询结果加入到resultArray中
                        [resultArray addObject:indexArray];
                    }];
                    [self.sectionArray removeAllObjects];
                    [self.dataSource removeAllObjects];
                    for (int k=0; k < resultArray.count; k++) {
                        NSArray *deviceOne = [resultArray objectAtIndex:k];
                        NSDictionary *dic = deviceOne[0];
                        [self.sectionArray addObject:[self.room objectForKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"room_id"]]]];
                        [self.dataSource addObject:deviceOne];
                    }
                    for (int i = 0; i < self.dataSource.count; i++)
                    {
                        //所有的分区都是闭合
                        [self.stateArray addObject:@"1"];
                    }
                    [self.collectionView reloadData];
                }else{
                    
                }
            } failure:^(NSError *error) {
                
            }];
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end

