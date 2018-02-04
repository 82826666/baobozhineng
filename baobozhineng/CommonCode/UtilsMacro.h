//
//  UtilsMacro.h
//  AlvinInterNetBar
//
//  Created by qianxx on 16/1/13.
//  Copyright © 2016年 wuzaifeng. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h
#define RGBA(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define CLEAR_COLOR RGBA(0,0,0,0.0)
//用户名
#define LOGIN_USERNAME @"username"
//密码
#define LOGIN_PASSWORD @"password"
//电话号码
#define LOGIN_PHONE @"phoneNum"

//用户编号
#define USER_ID @"user_id"

//用户登录的token
#define USER_TOKEN @"user_token"

//用户信息
#define USER_INFO @"user_info"

//主机信息
#define MASTER @"master"

//主机编号
#define MASTER_ID @"master_id"

//当前屏幕宽高
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//设置试图的坐标x
#define SET_ORIGN_X(view,orignx)  CGRectMake(orignx, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
//设置试图的坐标y
#define SET_ORIGN_Y(view,origny)  CGRectMake(view.frame.origin.x, origny, view.frame.size.width, view.frame.size.height)
//设置试图的宽度
#define SET_VIEW_WIDTH(view,width)  CGRectMake(view.frame.origin.x, view.frame.origin.y, width, view.frame.size.height)
//设置视图的高度
#define SET_VIEW_HEIGHT(view,height)  CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height)

//设置底部bar的视图高度
#define TAB_BOTTOMVIEW_HEIGTH 54

//从本地list获取设置key值
#define SET_USERDEFAULT(KEY,VALUE) [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]
//直接存储
#define USERDEFAULT_SYN() [[NSUserDefaults standardUserDefaults] synchronize]
//从本地list获取设置对象
#define GET_USERDEFAULT(KEY)  [[NSUserDefaults standardUserDefaults] objectForKey:KEY]

//设置主颜色
#define MAIN_COLOR RGBA(231, 241, 246, 1.0)
#define TABLECELL_LINE_COLOR RGBA(235,235,241)
#define BARTINTCOLOR RGBA(9, 141, 190, 1.0)
#define TINTCOLOR RGBA(255, 255, 255, 1.0)
/*
    *NSNotificationCenter广播键值设置
 */
//设置显示底部bottom
#define SHOWBOTTOMBAR @"showbottombar"
//设置隐藏底部bottom
#define HIDEBOTTOMBAR @"hidebottombar"
/*
 视图名称宏定义
 */
#define VIEW_SHAREINSRANCE(storyboard,viewcontroller) [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:viewcontroller]

//登录注册故事面板
#define  LOGINREGISTERSTORYBOARD @"LoginRegisterStoryboard"
//主要界面故事面板
#define  MAINSTORYBOARD @"MainStoryboard"
//弹窗故事面板
#define  ALERTVIEWSTORYBOARD @"AlertViewStoryboard"
//家居故事面板
#define  HOMESTORYBOARD @"HomeStoryboard"

//登录界面
#define LOGINVIEWCONTROLLER @"LoginViewController"
//注册界面
#define REGISITERVIEWCONTROLLER @"RegisterViewController"
//常用界面
#define USUALVIEWCONTROLLER  @"UsualViewcontroller"
//个人界面
#define PERSONALVIEWCONTROLLER  @"PersonalViewController"

//配置wifi界面
#define WIFICONFIGCONTROLLER @"WifiConfigViewController"
//选择wifi界面
#define SELECTHOMEWIFIVIEWCONTROLLER  @"SelectHomeWIFIViewController"
//设备设置界面
#define SELECTEQUIPMENTVIEWCONTOLLER @"SelectEquipmentViewController"
//主机管理界面
#define MAINHOSTSETVIECONTROLLER @"MainHostSetViewController"
//开关管理界面
#define  EQUIPMENTSWITCHSETVIEWCONTROLLER @"EquipmentSwitchSetViewController"

//选择图标界面
#define SWITCHICONSELECTVIEWCONTROLLER @"SwitchIconSelectViewController"
//列表弹出界面
#define TABLEPOPVIEWCONTROLLER @"TablePopViewController"
#define TEXTFIELDALERTVIEWCONTROLLER @"TextFieldAlertViewController"
#define LEARNINGALERTVIEWCONTROLLER @"LearningAlertViewController"
//传感器界面
#define SENSORVIEWCONTROLLER  @"SensorViewController"

//家居管理界面
#define HOMEVIEWCONTROLLER @"HomeViewController"
#endif /* UtilsMacro_h */




