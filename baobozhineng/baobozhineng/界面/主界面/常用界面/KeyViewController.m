//
//  KeyViewController.m
//  baobozhineng
//
//  Created by wjy on 2018/3/24.
//  Copyright © 2018年 吴建阳. All rights reserved.
//

#import "KeyViewController.h"
#import "TextfieldAlertViewController.h"
#import "TablePopViewController.h"
#import "SwitchIconSelectViewController.h"
#import "CommonCode.h"
#import <YYKit.h>
static NSString *identifier = @"cellID";
@interface KeyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    
}
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIView *currentView;
@property(nonatomic, strong) UIButton *currentButton;
@property(nonatomic, strong) UICollectionViewFlowLayout *flow;
@property(nonatomic, strong) NSArray *titleArr;
@property(nonatomic, strong) NSArray *nameArr;
@property(nonatomic, strong) YYLabel *swichNameLabel;
@property(nonatomic, strong) YYLabel *swichZoneLabel;
@property(nonatomic, strong) YYLabel *swichKeyLabel;
@property (nonatomic, strong) NSArray* cacheRoom;
@property (nonatomic, strong) NSMutableDictionary* room;
@end

@implementation KeyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建网格对象
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 55);
    self.collectionView.collectionViewLayout = self.flow;
    //注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
    [self initNav];
    //隐藏导航栏，
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.tabBarController.tabBar setHidden:YES];
//    self.tabBarController.tabBar.hidden = YES;
//    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    // Do any additional setup after loading the view.
}

#pragma mark ————— datasouce代理方法 —————
//有几组（默认是1）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
//一个分区item的数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        self.flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        return _setNum;
    }
    self.flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    return 1;
}
//每个item的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSString *imageName = @"sfad";
        NSString *nameStr = @"按键";
        if (_dataDic != nil) {
            NSArray *arr = [CommonCode stringToJSON:[_dataDic objectForKey:@"setting"]];
            NSDictionary *dic = [arr objectAtIndex:indexPath.row];
            imageName = [CommonCode getImageName: [[dic objectForKey:@"icon"] integerValue]];
            nameStr = [dic objectForKey:@"name"];
        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = 10000;
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.image.accessibilityIdentifier = imageName;
        imageView.frame = CGRectMake(0, 15, 50, 50);
        imageView.centerX = cell.contentView.centerX;
        imageView.tag = 1001;
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, SCREEN_WIDTH/4, 30)];
        name.textAlignment = NSTextAlignmentCenter;
        name.text = nameStr;
        name.tag = 1002;
        
        [cell.contentView addSubview:imageView];
        [cell.contentView addSubview:name];
        // cell点击变色
        UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
        selectedBGView.backgroundColor = [UIColor redColor];
        cell.selectedBackgroundView = selectedBGView;
        
        return cell;
    }
    UIButton *switchNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    switchNameBtn.frame = CGRectMake(0, 0, SCREEN_HEIGHT, 50);
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    
    YYLabel *swichName = [[YYLabel alloc] initWithFrame:CGRectMake(10, switchNameBtn.top + 10, 80, 30)];
    swichName.text = [self.titleArr objectAtIndex:indexPath.section];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 20, switchNameBtn.top + 20, 10, 10);
    [rightBtn setImage:[UIImage imageNamed:@"in_arrow_right"] forState:UIControlStateNormal];
    
    YYLabel *swichNameLabel = [[YYLabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 90, switchNameBtn.top + 10, 80, 30)];
    NSString *text = @"";
    if (indexPath.section == 1) {
        _swichNameLabel = swichNameLabel;
        text = _dataDic != nil ? [_dataDic objectForKey:@"name"] : [self.nameArr objectAtIndex:_setNum];
    }else if (indexPath.section == 3){
        _swichKeyLabel = swichNameLabel;
    }else if (indexPath.section == 4){
        _swichZoneLabel = swichNameLabel;
    }
    swichNameLabel.text = text;
    swichNameLabel.tag = 8000;
    
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    line2.backgroundColor = [UIColor lightGrayColor];
    //    NSLog(@"top:%f",switchNameBtn.top);
    [switchNameBtn addSubview:line1];
    [switchNameBtn addSubview:swichName];
    [switchNameBtn addSubview:rightBtn];
    [switchNameBtn addSubview:swichNameLabel];
    [switchNameBtn addSubview:line2];
    switchNameBtn.tag = [[NSString stringWithFormat:@"%ld000",indexPath.section] integerValue];
    [switchNameBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:switchNameBtn];
    return cell;
}

#pragma mark ————— dalegate代理方法 —————
//代理的优先级比属性高
//点击时间监听
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        _currentView = [collectionView cellForItemAtIndexPath:indexPath].contentView;
    }
}
//设置cell的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section > 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_setNum == 1) {
            return CGSizeMake(SCREEN_WIDTH/2, 100);
        }
        int itemW = (self.view.frame.size.width - (_setNum + 1)*10) / _setNum;
        return CGSizeMake(itemW, 100);
    }
    return CGSizeMake(SCREEN_WIDTH, 50);
}

//设置点击高亮和非高亮效果！
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-  (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor whiteColor]];
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

-(UICollectionViewFlowLayout *)flow{
    if (_flow == nil) {
        _flow = [[UICollectionViewFlowLayout alloc]init];
    }
    return _flow;
}

-(NSArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [[NSArray alloc]initWithObjects:@"",@"开关名称",@"按钮图标",@"按键名称",@"按钮区域", nil];
    }
    return _titleArr;
}

-(NSArray *)nameArr{
    if (_nameArr == nil) {
        _nameArr = [[NSArray alloc]initWithObjects:@"",@"一键名称",@"二键名称",@"三键名称",@"四键名称", nil];
    }
    return _nameArr;
}

-(NSMutableDictionary *)room{
    if (_room == nil) {
        _room = [NSMutableDictionary new];
    }
    return _room;
}

-(NSArray *)cacheRoom{
    if (_cacheRoom == nil) {
        _cacheRoom = [NSArray new];
    }
    return _cacheRoom;
}
#pragma mark ————— 方法 —————
-(void)click:(UIButton*)sender{
    _currentButton = sender;
    NSInteger tag = sender.tag;
    if (tag == 1000) {
        if (_currentButton == nil) {
            [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        }else{
            TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
            [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
                if(text.length!=0){
                    _swichNameLabel.text = text;
                }
            } Cancle:^(NSString *text) {
                
            }];
            [textfieldAlert showWithParentViewController:nil];
            [textfieldAlert showPopupview];
        }
    }else if (tag == 2000){
        if (_currentView == nil) {
            [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择按键"];
        }else{
            SwitchIconSelectViewController *switchIcon = [SwitchIconSelectViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:SWITCHICONSELECTVIEWCONTROLLER];
            [switchIcon setImgArray:@[@"in_equipment_lamp_default",@"in_equipment_lamp_walllamp",@"in_equipment_lamp_ceilinglamp",@"in_equipment_lamp_efficient",@"in_equipment_lamp_spotlight",@"in_equipment_lamp_backlight",@"in_equipment_lamp_mirrorlamp",@"in_equipment_lamp_downlight",@"in_equipment_lamp_chandelier",@"in_equipment_aiming_default"] titleArray:@[@"灯",@"床头灯",@"吸顶灯",@"节能灯",@"射灯",@"LED灯",@"壁灯",@"浴灯",@"吊灯",@"白织灯"] LabelTitle:@"灯具图标设置" ClickBlock:^(int index,NSString *imagestr,NSString *title) {
                //按钮的返回事件
                UIImageView *imageView = (UIImageView*)[_currentView subviewsWithTag:1001];
                [imageView setImage:[UIImage imageNamed:imagestr]];
                imageView.image.accessibilityIdentifier = imagestr;
            }] ;
            [switchIcon showWithParentViewController:nil];
            [switchIcon showPopupview];
        }
    }else if (tag == 3000){
        TextFieldAlertViewController *textfieldAlert = VIEW_SHAREINSRANCE(ALERTVIEWSTORYBOARD, TEXTFIELDALERTVIEWCONTROLLER);
        [textfieldAlert setTitle:@"按键名称" EnterBlock:^(NSString *text) {
            if(text.length!=0){
                UILabel *label = (UILabel*)[_currentView subviewsWithTag:1002];
                label.text = text;
                _swichKeyLabel.text = text;
            }
        } Cancle:^(NSString *text) {
            
        }];
        [textfieldAlert showWithParentViewController:nil];
        [textfieldAlert showPopupview];
    }else if (tag == 4000){
        TablePopViewController *switchIcon = [TablePopViewController sharePopupView:ALERTVIEWSTORYBOARD andPopupViewName:TABLEPOPVIEWCONTROLLER];
        NSMutableArray *cellTitleArray = [NSMutableArray new];
        for (int i = 0; i < self.cacheRoom.count; i++) {
            NSDictionary *dic = [self.cacheRoom objectAtIndex:i];
            [cellTitleArray addObject:[dic objectForKey:@"name"]];
        }
        [ switchIcon setTitleLabel:@"选择区域" CellTitleArray:cellTitleArray Block:^(id dataArray) {
            if(dataArray != nil){
                NSDictionary* data = dataArray[0];
                _swichZoneLabel.text = [data objectForKey:@"selectTitle"];
            }else{
                
            }
        }];
        [switchIcon showWithParentViewController:nil];
        [switchIcon showPopupview];
    }
}
#pragma mark - 导航栏
- (void) initNav{
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"in_arrow_white"] style:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
    self.navigationItem.title = [self.nameArr objectAtIndex:_setNum];
    self.navigationController.navigationBar.barTintColor = BARTINTCOLOR;
    self.navigationController.navigationBar.tintColor = TINTCOLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];//设置标题颜色及字体大小
    self.navigationItem.leftBarButtonItem = leftBtn;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
#pragma mark - 数据保存
-(void)saveData{
    if (_swichZoneLabel.text == nil) {
        [SVProgressHUD mydefineErrorShowDismissTime:2.0 ErrorTitle:@"请选择所属区域"];
        return ;
    }
    NSMutableArray *setting = [NSMutableArray new];
    int i = 0;
    for (UIView *view in self.collectionView.subviews) {
        for (UIView *con in view.subviews) {
            if ([con subviewsWithTag:1001] != nil) {
                i++;
                UIImageView *imageView = (UIImageView *)[con subviewsWithTag:1001];
                UILabel *label = (UILabel *)[con subviewsWithTag:1002];
                NSDictionary *dic = @{
                                      @"icon":[CommonCode getImageType:imageView.image.accessibilityIdentifier],
                                      @"name":label.text,
                                      @"ch":[NSString stringWithFormat:@"%d",i],
                                      @"status":@"0",
                                      @"order":@"0"
                                      };
                [setting addObject:dic];
            }
        }
    }
    NSString *type = @"";
    if (_setNum == 1) {
        type = @"20111";
    }else if (_setNum == 2){
        type = @"20121";
    }else if (_setNum == 3){
        type = @"20131";
    }else if (_setNum == 4){
        type = @"20141";
    }
    [self.room enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isEqualToString: _swichZoneLabel.text]) {
            if (_dataDic != nil) {
                NSDictionary *params = @{
                                         @"device_id":[_dataDic objectForKey:@"id"],
                                         @"name":_swichNameLabel.text,
                                         @"room_id":key,
                                         @"setting":[CommonCode formatToJson:setting],
                                         @"icon":type,//[CommonCode getImageType:@"in_equipment_switch_one"]
                                         };
                NSLog(@"parm:%@",params);
                [[APIManager sharedManager]deviceEditTwowaySwitchWithParameters:params success:^(id data) {
                    NSDictionary *datadic = data;
                    if([[datadic objectForKey:@"code"] intValue] == 200){
                        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
                    }else{
                        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"123");
                }];
            }else{
                NSDictionary *params = @{
                                         @"master_id":GET_USERDEFAULT(MASTER_ID),
                                         @"name":_swichNameLabel.text,
                                         @"type":type,
                                         @"room_id":key,
                                         @"setting":[CommonCode formatToJson:setting],
                                         @"icon":type,//[CommonCode getImageType:@"in_equipment_switch_one"]
                                         @"mac":[CommonCode getMac]
                                         };
                [[APIManager sharedManager]deviceAddTwowaySwitchWithParameters:params success:^(id data) {
                    NSDictionary *datadic = data;
                    if([[datadic objectForKey:@"code"] intValue] == 200){
                        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
//                        [self.navigationController pushViewController:[UsualViewcontroller shareInstance] animated:YES];
                    }else{
                        [[AlertManager alertManager] showError:3.0 string:[datadic objectForKey:@"msg"]];
                    }
                } failure:^(NSError *error) {
                    NSLog(@"123");
                }];
            }
        }
    }];
    
}

#pragma mark - 数据加载
-(void)loadData{
    [[APIManager sharedManager]deviceGetMasterRoomWithParameters:@{@"master_id":GET_USERDEFAULT(MASTER_ID)} success:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"code"]integerValue] == 200) {
            self.cacheRoom = [dic objectForKey:@"data"];
            for (int i = 0; i < self.cacheRoom.count; i ++) {
                NSDictionary *roomOne = [self.cacheRoom objectAtIndex:i];
                [self.room setValue:[roomOne objectForKey:@"name"] forKey:[NSString stringWithFormat:@"%@",[roomOne objectForKey:@"id"]]];
            }
//            NSLog(@"room%@",self.room);
            if (_dataDic != nil) {
                _swichZoneLabel.text = [self.room objectForKey:[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"room_id"]]];
            }
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    // 强制隐藏tabbar
    NSArray *views = self.tabBarController.view.subviews;
    UIView *contentView = [views objectAtIndex:0];
    contentView.height += 49;
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
