//
//  PersonalViewController.m
//  baobozhineng
//
//  Created by 吴建阳 on 2017/12/26.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "PersonalViewController.h"
#import "LoginViewController.h"
#define CELL_HEADER_HEIGHT 20
#define CELL_HEIGHT 50

@interface PersonalTablecellObject :NSObject
@property(nonatomic,copy) NSString *leftImgStr;
@property(nonatomic,copy) NSString *titleStr;
+(instancetype)initWithLeftImgStr:(NSString*)leftimgStr TitleLabStr:(NSString *)titleStr;
@end

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;

@end


@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MAIN_COLOR;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)alertMsg:(NSString*)msg cancelAction:(void (^)(UIAlertAction * _Nonnull action))cancel successAction:(void (^)(UIAlertAction * _Nonnull action))success{
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert ];

    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:cancel];
    [alertController addAction:cancelAction];

    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:success];
    [alertController addAction:OKAction];

    [self presentViewController:alertController animated:YES completion:nil];
}
- (NSArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = @[@[
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_personal" TitleLabStr:@"个人中心"],
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_member" TitleLabStr:@"成员管理  "],
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_host" TitleLabStr:@"主机管理"],
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_region" TitleLabStr:@"区域管理"]
                           ],
                       @[
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_help" TitleLabStr:@"使用帮助"],
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_more" TitleLabStr:@"更多设备"]
                           ],
                       @[
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_message" TitleLabStr:@"消息通知"],
                           [PersonalTablecellObject initWithLeftImgStr:@"in_setup_about" TitleLabStr:@"关于我们"]
                           ],
                       @[[PersonalTablecellObject initWithLeftImgStr:@"" TitleLabStr:@"退出登录"]]];
    }
    return  _dataArray;
}

+(instancetype)shareInstance
{
    return VIEW_SHAREINSRANCE(MAINSTORYBOARD, PERSONALVIEWCONTROLLER);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return 4;
    }
    else if(section==1){
        
        return 2;
    }
    else  if(section ==2){
        
        return  2;
    }
    else if(section==3 ){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return CGFLOAT_MIN;
    }
    else if(section==1||section==2||section==3){
        
        return CELL_HEADER_HEIGHT;
    }
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    if (section==0) {
        
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MIN);
        return view;
    }
    else if(section==1||section==2||section==3){
        view.frame = CGRectMake(-10, 0, SCREEN_WIDTH+20, CELL_HEADER_HEIGHT);
        return view;
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalcell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalcell"];
        UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        leftImgView.tag =1;
        [cell.contentView addSubview:leftImgView];
        
        UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImgView.frame)+10,0 , SCREEN_WIDTH-CGRectGetMaxX(leftImgView.frame)*2-20, CELL_HEIGHT)];
        leftLab.font = [UIFont systemFontOfSize:15];
        leftLab.textColor = RGBA(88, 88, 88, 1.0);
        leftLab.tag =2;
        [cell.contentView addSubview:leftLab];
        
        UIImageView *rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, CELL_HEIGHT/2-10, 20, 20)];
        rightImg.image = [UIImage imageNamed:@"in_arrow_right"];
        rightImg.contentMode = UIViewContentModeScaleAspectFit;
        rightImg.tag =3;
        [cell.contentView addSubview:rightImg];
        cell.backgroundColor = MAIN_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *sectionArrauy = _dataArray[indexPath.section];
    PersonalTablecellObject *object = sectionArrauy[indexPath.row];
    
    UIImageView *leftImgView = [cell.contentView viewWithTag:1];
    leftImgView.image = [UIImage imageNamed:object.leftImgStr];
    
    UILabel *leftLabel = [cell.contentView viewWithTag:2];
    leftLabel.text = object.titleStr;
    
    UIImageView *rightImgView = [cell.contentView viewWithTag:3];
    if (indexPath.section==_dataArray.count-1) {
        
        rightImgView.alpha = 0;
        leftLabel.textAlignment = NSTextAlignmentCenter;
    }
    else{
        rightImgView.alpha = 1;
        leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return  cell;
}
/*清除所有的存储本地的数据*/
-(void)clearAllUserDefaultsData{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0://第一组
            switch (indexPath.row) {
                case 2://第二行
                    [self.navigationController pushViewController:VIEW_SHAREINSRANCE(MAINSTORYBOARD, MAINHOSTSETVIECONTROLLER) animated:YES];
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 1:
                    
                    break;
                    
                default:
                    break;
            }
            break;
        case 2:
            switch (indexPath.row) {
                case 1:
                    
                    break;
                    
                default:
                    break;
            }
            break;
        default:
            [self alertMsg:@"确定要退出？" cancelAction:^(UIAlertAction * _Nonnull action) {
                
            } successAction:^(UIAlertAction * _Nonnull action) {
                [self clearAllUserDefaultsData];
                [self.navigationController pushViewController:[LoginViewController shareInstance] animated:YES];
            }];
            break;
    }
//    if (indexPath.section==0) {
//        if(indexPath.row==2){
//            //进入主机界面
//            [self.navigationController pushViewController:VIEW_SHAREINSRANCE(MAINSTORYBOARD, MAINHOSTSETVIECONTROLLER) animated:YES];
//        }
//    }else if (indexPath.section == 1){
//        if (indexPath.row == 1) {
//
//        }
//    }
}

@end
@implementation PersonalTablecellObject
+(instancetype)initWithLeftImgStr:(NSString*)leftimgStr TitleLabStr:(NSString *)titleStr
{
    PersonalTablecellObject *obejct = [[PersonalTablecellObject alloc] init];
    obejct.leftImgStr = leftimgStr;
    obejct.titleStr = titleStr;
    return  obejct;
}
@end
