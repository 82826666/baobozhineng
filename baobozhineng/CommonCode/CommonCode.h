//
//  CommonCode.h
//  CommonCode
//
//  Created by Pop Web on 15/1/8.
//  Copyright (c) 2015年 黄旺鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UtilsMacro.h"

//------------------------系统版本判断-----------------------------

//判断系统版本是否大于某个版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//判断系统大于ios7
#define IOS_7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")

//判断系统大于ios8
#define IOS_8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")

#define IOS_9_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9")

//判断系统
#define IOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]

//判断是否是IPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//iphone4
#define  Is_IPhone4  ScreenHeight==480
#define  Is_IPhone5  ScreenHeight==568
#define  Is_IPhone6  ScreenWidth==375
#define  Is_IPhone6p  ScreenWidth==414


/// 主颜色
#define MainColor @""

//判断是否是iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 当前系统版本
#define CurrentSystemVersion [CommonCode getCurrentSystemVersion]

/// app版本
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]


//------------------------线程-----------------------------
//定义代码块类型
#define Async(...) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__ })
#define Async_Main(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })

//------------------------获取设备大小-----------------------------
//设备的Bounds
#define DeviceBounds [[UIScreen mainScreen] bounds]

//设备的宽度
#define DeviceScreenWidth CGRectGetWidth(DeviceBounds)

//设备的高度
#define DeviceScreenHeight CGRectGetHeight(DeviceBounds)

//当前屏幕的宽度、
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//当前屏幕的高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//------------------------可变对象初始化-----------------------------

//初始化可变字典
#define Mutable_DictionaryInit [NSMutableDictionary dictionaryWithCapacity:5]

//初始化可变集合
#define Mutable_SetInit [NSMutableSet setWithCapacity:5]
#define ALPHANUM @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//初始化可变数组
#define Mutable_ArrayInit [NSMutableArray arrayWithCapacity:5]

/**
 *  @brief 将NSData转换成字符串
 *
 *  @param data NSData对象
 *
 *  @return 返回字符串
 */
#define NSStringFromData(data) [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]

#define NSStringFromNumber(number) [@(number) description]

//NSUserDefaults实例
#define User_Defaults [NSUserDefaults standardUserDefaults]

//通知中心实例
#define DefaultNotiCenter [NSNotificationCenter defaultCenter]

//NSFileManager实例
#define FileManager [NSFileManager defaultManager]

#define isNSNull(value) [value isKindOfClass:[NSNull class]]

//------------------------打印日志-----------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

#ifdef DEBUG
#   define WXDLog(fmt, ...) NSLog((@"------------------------------------------------------ \n %s [Line %d] \n------------------------------------------------------" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#   define WXDAFNErrorLog(error) NSLog((@"------------------------------------------------------ \n %s [Line %d] \n \n %@------------------------------------------------------"), __PRETTY_FUNCTION__, __LINE__, [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding]);
#else
#   define WXDLog(...)
#   define WXDAFNErrorLog(error)
#endif


#define NeedPAyMonyText @"NeedPAyMonyText"

//重写NSLog,Debug模式下打印日志和当前行数
#define DEBUG_NSLog(FORMAT, ...) fprintf(stderr,"\n----------------------------------\n\nfunction:%s line:%d content:%s\n\n----------------------------------\n\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif

#define LogMethod DLog(@"------------------------------------------------------ \n %@ \n------------------------------------------------------", NSStringFromSelector(_cmd))

#define WXLog(fmt) DLog(@"------------------------------------------------------ \n %@ \n------------------------------------------------------", fmt)

//------------------------颜色-----------------------------
/**
 *  @brief Hex转换成UIColor对象
 *
 *  @param string Hex如@"#00B9FF"
 *
 *  @return UIColor实例
 */
#define UIColorFromHexString(string) [CommonCode colorWithHexString:string]

/**
 *  RGB值
 *
 *  @param R 值0-255
 *  @param G 值0-255
 *  @param B 值0-255
 *  @param A 值0-1
 *
 *  @return UIColor对象
 */
#define ColorWithRGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorWithRGB(r, g, b)  ColorWithRGBA(r, g, b, 1.0f)

//------------------------图片-----------------------------
//图片对象
#define ImageWithName(imageName) [UIImage imageNamed:imageName]

//------------------------本地文件地址-----------------------------
/**
 *  获取NSBundle文件地址
 *
 *  @param fileName 文件名称
 *  @param type     文件类型
 *
 *  @return 返回文件地址字符串
 */
#define BundleFilePath(fileName, type) [[NSBundle mainBundle] pathForResource:fileName ofType:type]

///搜索历史记录plist文件路径
#define HistoryPlistPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"]

//------------------------线程-----------------------------
//定义代码块类型
#define Async(...) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__ })
#define Async_Main(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })

//------------------------网络请求-----------------------------
//将字符串转化成NSURL
#define URLWithString(urlStr) [NSURL URLWithString:urlStr]

//将URL转化为NSURLRequest
#define RequestWithURL(url) [NSURLRequest requestWithURL:url]

//字符串生成NSURLRequest
#define RequestWithString(urlStr) RequestWithURL(URLWithString(urlStr))

// 字符串生成NSMutableURLRequest
#define MutableURLRequestWithString(urlStr)  [NSMutableURLRequest requestWithURL:URLWithString(urlStr)]

//------------------------其他-----------------------------
//从字典获取对象
#define ObjectWithKey(dictionary, key) [dictionary valueForKey:key]
#define ObjectWithKeyPath(dictionary, key) [dictionary valueForKeyPath:key]

#define ChooseWithCondition(condition, A, B) condition ? A : B

#define ArchivedToData(obj) [NSKeyedArchiver archivedDataWithRootObject:obj]

#define UnarchiveToObject(data) [NSKeyedUnarchiver unarchiveObjectWithData:data]

/// 四舍五入
#define RoundDecimal(decimal, digitNum) [CommonCode roundWithDecimal:decimal digit:digitNum]

//--------------------------------------------------------



@interface CommonCode : NSObject
//获取对应编号的图片名称
+ (NSString*)getImageName:(NSInteger)index;
//获取对应图片的编号
+ (NSString*)getImageType:(NSString*)imageName;
//获取主机mac地址
+(NSString *)getMac;
/**
 *  @brief 获取当前系统版本
 *
 */
+ (NSString *)getCurrentSystemVersion;


/**
 *  @brief 获取设备屏幕的大小
 *
 */
+ (CGRect)getDeviceBounds;

/**
 *  @brief 计算文本所需的高度或宽度
 *
 *  @param string  文本内容
 *  @param font    显示的字体
 *  @param maxSize 最大宽度或者最大高度， 需要准确值  比如计算高度，CGSizeMake(280, 9999), 宽度准确值， 高度要比较大
 *
 */
+ (CGSize)calculateSizeWithString:(NSString *)string andFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/**
 *  @brief 获取设备型号
 *
 *  @return 返回如 iPhone 5s (A1453/A1533)
 */
+ (NSString *)deviceModelString;


+(NSString *)getCurrentTime;

/**
 *  Hex生成Color对象
 *
 *  @param stringToConvert 传入如26BFFC或者#FFB25C
 *
 *  @return Color对象
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *  绘制纯色图片
 *
 *  @param color 颜色对象
 *  @param size  图片大小
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  字数统计
 *
 *  @param string 要统计的字符串
 *
 *  @return 返回字数
 */
+ (int)countWord:(NSString *)string;

/**
 *  去掉一些字符，防止json解析不正确
 *
 *  @param jsonString json字符串
 *
 */
+ (NSString *)removeIllegalCharactersWithString:(NSString *)jsonString;

/**
 *  验证手机号
 *
 *  @param mobileNum 要验证的手机号
 *
 *  @return 正确返回YES
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/**
 *  判断是否是数字
 *
 *  @param string 需要判断的字符串
 *
 */
+ (BOOL)isNumberWithString:(NSString *)string;

/**
 *  判断是否浮点数
 *
 *  @param string 要判断的字符串
 *
 */
+ (BOOL)isPureFloat:(NSString *)string;

/**
 *  将时间转化为所需的格式
 *
 *  @param date 要转换的NSDate对象
 *
 */
+ (NSString *)timeStringWithDate:(NSDate *)date;

/**
 *  截取View为图片
 *
 *  @param v 要截取的view
 *
 *  @return 图片对象
 */
+ (UIImage*)convertViewToImage:(UIView*)v;

/**
 *  将字符串百分比转化为浮点数
 *
 *  @param strNum 要转化的字符串
 *
 */
+ (float)numberWithString:(NSString *)strNum;

/**
 *  将浮点数转化为百分比
 *
 *  @param progress 要转化的浮点数
 *
 */
+ (NSString *)percentStringWithfloat:(float)progress;

/**
 *  @brief  格式话小数 四舍五入类型
 *
 *  @param format 格式例如 0.000 ，保留三位小数
 *  @param floatV 数字
 *
 */
+ (NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV;

/**
 *  @brief  四舍五入
 *
 *  @param doubleV  四舍五入的小数
 *  @param digitNum 保留几位小数
 *
 */
+ (NSString *)roundWithDecimal:(double)doubleV digit:(NSInteger)digitNum;

/**
 *  @brief  字符串带有删除线
 *
 *  @param str 要添加删除线的
 *
 */
+ (NSAttributedString *)strikethroughWithString:(NSString *)str;

/**
 *  @brief  移除html中的图片宽度和高度
 *
 *  @param string HTML代码
 *
 */
+ (NSString *)removeImgWHWithString:(NSString *)string;

/**
 *  @brief  移除html中的图片宽度和高度
 *
 *  @param string HTML代码
 *
 */
+ (NSString *)removeImgWidthAndHeightWithString:(NSString *)string;

//将数据库时间转换成标准时间
+ (NSString *)timeWithNumber:(NSInteger)num;
//计算到现在经过的时间
+(NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime;
#pragma mark - <直播>项目新增

///身份证校验
+ (BOOL)checkUserIdCard: (NSString *)idCard;

+ (BOOL)requestMediaCapturerAccessWithCompletionHandler:(void (^)(BOOL, NSError*))handler;

+ (void)showAlertByTitle:(NSString *)title Message:(NSString*)message Block:(void (^)())block Controller:(UIViewController *)controller;
/**
 *  @param datas 要格式化的数据
 *
 *  @return json字符串
 */
+(NSString*)formatToJson:(id)datas;

+ (NSArray *)stringToJSON:(NSString *)jsonStr;
/**
 *  @param tmpStr 要截取的字符串
 *  @param str 要截取到那个字符串
 *  @return 字符串
 */
+(NSString*)subStr:(NSString*) tmpStr str:(NSString*)str;
/**
 *获取当前的时间搓
 *@return 字符串
 */
+(NSString*)getCurrentTimeRubbing;
@end



