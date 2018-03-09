//
//  ParentTabbarController.m
//  TestNavgation
//
//  Created by 吴建阳 on 2017/12/25.
//  Copyright © 2017年 吴建阳. All rights reserved.
//

#import "ParentTabbarController.h"
#import "TabbarBottomBtn.h"
#import "TabNavViewcontroller.h"
#import "UsualViewcontroller.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "PersonalViewController.h"
#import "LoginRisterNavgation.h"
#import "LoginViewController.h"
#import "HouseViewController.h"
@interface ParentTabbarController ()
//分栏底部视图
@property(nonatomic,strong)UIView *bottomView;
@end

@implementation ParentTabbarController
static ParentTabbarController* tabbarController;
//分栏用单例
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tabbarController = [[ParentTabbarController alloc] init];
        tabbarController.tabBar.hidden = YES;
        //设置监听隐藏显示bottomView
        [[NSNotificationCenter defaultCenter] addObserver:tabbarController selector:@selector(showBottomBar:) name:SHOWBOTTOMBAR object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:tabbarController selector:@selector(hideBootomBar:) name:HIDEBOTTOMBAR object:nil];
    });
    return tabbarController;
}
//显示底部视图
- (void)showBottomBar:(NSNotification*)notification
{
   
    tabbarController.bottomView.frame = SET_ORIGN_Y(tabbarController.bottomView,SCREEN_HEIGHT-TAB_BOTTOMVIEW_HEIGTH );
}
//隐藏底部视图
- (void)hideBootomBar:(NSNotification*)notification
{
     tabbarController.bottomView.frame = SET_ORIGN_Y(tabbarController.bottomView, SCREEN_HEIGHT);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
  
}
-(void)viewDidAppear:(BOOL)animated
{
    //没有登录则跳出主界面
    if (!GET_USERDEFAULT(LOGIN_USERNAME)) {
    
        [self presentViewController:  [[LoginRisterNavgation alloc] initWithRootViewController:[LoginViewController shareInstance]] animated:YES completion:^{
            
        }];
        return;
    }
    [self setBottomBar];
}
//设置底部视图
- (void)setBottomBar
{
    if (_bottomView) {
        [_bottomView removeFromSuperview];
    }
//    TabNavViewcontroller *usualNav = [[TabNavViewcontroller alloc] initWithRootViewController:[UsualViewcontroller shareInstance]];
    TabNavViewcontroller *usualNav = (TabNavViewcontroller*)[[UINavigationController alloc] initWithRootViewController:[UsualViewcontroller shareInstance]];
//    TabNavViewcontroller *homeNav = [[TabNavViewcontroller alloc] initWithRootViewController:[HomeViewController shareInstance]];
//    TabNavViewcontroller *homeNav = [[TabNavViewcontroller alloc] initWithRootViewController:[[HouseViewController alloc]init]];
    TabNavViewcontroller *homeNav = (TabNavViewcontroller*)[[UINavigationController alloc] initWithRootViewController:[[HouseViewController alloc]init]];
//    TabNavViewcontroller *detailNav = [[TabNavViewcontroller alloc] initWithRootViewController:[DetailViewController shareInstance]];
    TabNavViewcontroller *detailNav = (TabNavViewcontroller*)[[UINavigationController alloc] initWithRootViewController:[[DetailViewController alloc] init]];
    TabNavViewcontroller *personalNav = [[TabNavViewcontroller alloc] initWithRootViewController:[PersonalViewController shareInstance]];

    self.viewControllers = @[usualNav,homeNav,detailNav,personalNav];
    
    self.titleArray = @[@"常用",@"家居",@"情景",@"个人中心"];
    self.imgArray = @[@{
                                  @"one":[UIImage imageNamed:@"in_bottom_menu_star"],
                                  @"two":[UIImage imageNamed:@"in_bottom_menu_staract"]
                                  },
                              @{
                                  @"one":[UIImage imageNamed:@"in_bottom_menu_home"],
                                  @"two":[UIImage imageNamed:@"in_bottom_menu_homeact"]
                                  },
                              @{
                                  @"one":[UIImage imageNamed:@"in_bottom_menu_scene"],
                                  @"two":[UIImage imageNamed:@"in_bottom_menu_sceneact"]
                                  },
                              @{
                                  @"one":[UIImage imageNamed:@"in_bottom_menu_my"],
                                  @"two":[UIImage imageNamed:@"in_bottom_menu_myact"]
                                  }];
    //设置底部视图的位置
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-TAB_BOTTOMVIEW_HEIGTH, SCREEN_WIDTH, TAB_BOTTOMVIEW_HEIGTH)];
    _bottomView.backgroundColor = CLEAR_COLOR;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = RGBA(55, 55, 55, 0.3);
    [_bottomView addSubview:lineView];
    //每个视图按钮的宽度
    double bottomIndexViewWidth = SCREEN_WIDTH/tabbarController.titleArray.count;
    for (int i=0; i<tabbarController.titleArray.count; i++) {
        //设置btnview
        NSString *labText = _titleArray[i];
        UIImage *normal_img = [_imgArray[i] objectForKey:@"one"];
        UIImage *selected_img = [_imgArray[i] objectForKey:@"two"];
        TabbarBottomBtn *buttonIndexView = [[TabbarBottomBtn alloc] initWithFrame:CGRectMake(bottomIndexViewWidth*i, 0, bottomIndexViewWidth, _bottomView.frame.size.height) Title:labText Img:normal_img];
        if(i==0){
            buttonIndexView.imgView.image = selected_img;
        }
        buttonIndexView.tag=i+1;
        //设置每个view的点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [buttonIndexView addGestureRecognizer:tap];
        
        [_bottomView addSubview:buttonIndexView];
    }
    
    [self.view addSubview:_bottomView];
}

//
-(void)tapAction:(UITapGestureRecognizer*)tap
{
    UIView *tapview = tap.view;
    for (int i =0; i<_titleArray.count; i++) {
        //判断点击的是这个按钮
        if (i+1==tapview.tag) {
            tabbarController.selectedIndex = i;
            TabbarBottomBtn *bottomb = [_bottomView viewWithTag:i+1];
            UIImage *img = [_imgArray[i] objectForKey:@"two"];
            bottomb.imgView.image =img;
        }
        //判断点击的不是这个按钮
        else
        {
            TabbarBottomBtn *bottomb = [_bottomView viewWithTag:i+1];
            UIImage *img = [_imgArray[i] objectForKey:@"one"];
            bottomb.imgView.image =img;
        }
    }
}

@end
