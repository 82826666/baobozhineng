//
//  CommonCode.m
//  CommonCode
//
//  Created by Pop Web on 15/1/8.
//  Copyright (c) 2015年 黄旺鑫. All rights reserved.
//

#import "CommonCode.h"
#import "UtilsMacro.h"
#import <sys/utsname.h>
#import <AVFoundation/AVFoundation.h>

@implementation CommonCode
//获取对应编号的图片名称
+ (NSString*)getImageName:(NSInteger)index{
    switch (index) {
        case 20111:
            return @"in_equipment_switch_one";
            break;
        case 20121:
            return @"in_equipment_switch_two";
            break;
        case 20131:
            return @"in_equipment_switch_three";
            break;
        case 20141:
            return @"in_equipment_switch_four";
            break;
        case 10211:
            return @"in_select_aiming_default";
            break;
        case 3001:
            return @"in_scene_select_hand";
        default:
            break;
    }
    return @"";
}
//获取对应图片的编号
+ (NSString*)getImageType:(NSString*)imageName{
    if ([imageName isEqualToString:@"in_equipment_switch_one"]) {
        return @"20111";
    }else if ([imageName isEqualToString:@"in_equipment_switch_two"]){
        return @"20121";
    }else if([imageName isEqualToString:@"in_equipment_switch_three"]){
        return @"20131";
    }else if([imageName isEqualToString:@"in_equipment_switch_four"]){
        return @"20141";
    }else if([imageName isEqualToString:@"in_select_aiming_default"]){
        return @"10211";
    }else if([imageName isEqualToString:@"in_scene_select_hand"]){
        return @"3001";
    }
    return @"";
}
/**
 *  获取当前系统版本
 *  如果直接调用读取系统的方法， 可能出现一些问题
 *
 */
+ (NSString *)getCurrentSystemVersion {
    
    //静态全局变量  用来存系统版本，以便反复读取
    static NSString *currentVersion = nil;
    
    if (!currentVersion) {
        currentVersion = [User_Defaults objectForKey:@"currentSystemVersion"];
    }
    
    //当NSUserDefaults中没有值时，获取系统的版本并存进去
    if (!currentVersion) {
        currentVersion = [[UIDevice currentDevice] systemVersion];
        
        [User_Defaults setObject:currentVersion forKey:@"currentSystemVersion"];
        [User_Defaults synchronize];
    }
    
    return currentVersion;
}



/**
 *  获取设备屏幕的大小
 *
 */
+ (CGRect)getDeviceBounds {
    
    static CGRect deviceBounds;
    static CGFloat width = 0;
    if (CGRectGetWidth(deviceBounds) != width || width == 0) {
        //获取设备的屏幕大小
        deviceBounds = [[UIScreen mainScreen] bounds];
        width = CGRectGetWidth(deviceBounds);
    }
    
    return deviceBounds;
}

/**
 *  @brief 计算文本所需的高度或宽度
 *
 *  @param string  文本内容
 *  @param font    显示的字体
 *  @param maxSize 最大宽度或者最大高度， 需要准确值  比如计算高度，CGSizeMake(280, 9999), 宽度准确值， 高度要比较大
 *
 */
+ (CGSize)calculateSizeWithString:(NSString *)string andFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    
    if (!string) {
        //当不存在string 返回0
        return CGSizeZero;
    }else if (!font){
        //字体为nil时，使用系统默认的字体
        font = [UIFont systemFontOfSize:17];
    }
    
    if (IOS_7_OR_LATER) {
        
        //设置字体属性
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
        NSRange range = NSMakeRange(0, attrString.length);
        NSDictionary *attributesDictionary = [attrString attributesAtIndex:0 effectiveRange:&range];
        
        //计算大小 此方法在ios7以上才能使用
        CGSize contentSize = [string boundingRectWithSize:maxSize //宽高限制
                                                  options:NSStringDrawingUsesLineFragmentOrigin //文本绘制时的附加选项
                                               attributes:attributesDictionary //文字的属性
                                                  context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为ni
        
        contentSize.width = ceil(contentSize.width);
        contentSize.height = ceil(contentSize.height);
        
        return contentSize;
        
    }

    
    //ios6上运行
    #pragma clang diagnostic push
    
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGSize contentSize = [string sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByCharWrapping];

#pragma clang diagnostic pop
    
    contentSize.width = ceil(contentSize.width);
    contentSize.height = ceil(contentSize.height);
    
    return contentSize;

}

/**
 *  @brief 获取设备型号
 *
 *  @return 返回如 iPhone 5s (A1453/A1533)
 */
+ (NSString *)deviceModelString {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModelString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceModelString isEqualToString:@"iPhone1,1"])   return @"iPhone 2G (A1203)";
    if ([deviceModelString isEqualToString:@"iPhone1,2"])   return @"iPhone 3G (A1241/A1324)";
    if ([deviceModelString isEqualToString:@"iPhone2,1"])   return @"iPhone 3GS (A1303/A1325)";
    if ([deviceModelString isEqualToString:@"iPhone3,1"])   return @"iPhone 4 (A1332)";
    if ([deviceModelString isEqualToString:@"iPhone3,2"])   return @"iPhone 4 (A1332)";
    if ([deviceModelString isEqualToString:@"iPhone3,3"])   return @"iPhone 4 (A1349)";
    if ([deviceModelString isEqualToString:@"iPhone4,1"])   return @"iPhone 4S (A1387/A1431)";
    if ([deviceModelString isEqualToString:@"iPhone5,1"])   return @"iPhone 5 (A1428)";
    if ([deviceModelString isEqualToString:@"iPhone5,2"])   return @"iPhone 5 (A1429/A1442)";
    if ([deviceModelString isEqualToString:@"iPhone5,3"])   return @"iPhone 5c (A1456/A1532)";
    if ([deviceModelString isEqualToString:@"iPhone5,4"])   return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([deviceModelString isEqualToString:@"iPhone6,1"])   return @"iPhone 5s (A1453/A1533)";
    if ([deviceModelString isEqualToString:@"iPhone6,2"])   return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([deviceModelString isEqualToString:@"iPhone7,1"])   return @"iPhone 6 Plus (A1522/A1524)";
    if ([deviceModelString isEqualToString:@"iPhone7,2"])   return @"iPhone 6 (A1549/A1586)";
    
    if ([deviceModelString isEqualToString:@"iPod1,1"])     return @"iPod Touch 1G (A1213)";
    if ([deviceModelString isEqualToString:@"iPod2,1"])     return @"iPod Touch 2G (A1288)";
    if ([deviceModelString isEqualToString:@"iPod3,1"])     return @"iPod Touch 3G (A1318)";
    if ([deviceModelString isEqualToString:@"iPod4,1"])     return @"iPod Touch 4G (A1367)";
    if ([deviceModelString isEqualToString:@"iPod5,1"])     return @"iPod Touch 5G (A1421/A1509)";
    
    if ([deviceModelString isEqualToString:@"iPad1,1"])     return @"iPad 1G (A1219/A1337)";
    if ([deviceModelString isEqualToString:@"iPad2,1"])     return @"iPad 2 (A1395)";
    if ([deviceModelString isEqualToString:@"iPad2,2"])     return @"iPad 2 (A1396)";
    if ([deviceModelString isEqualToString:@"iPad2,3"])     return @"iPad 2 (A1397)";
    if ([deviceModelString isEqualToString:@"iPad2,4"])     return @"iPad 2 (A1395+New Chip)";
    if ([deviceModelString isEqualToString:@"iPad2,5"])     return @"iPad Mini 1G (A1432)";
    if ([deviceModelString isEqualToString:@"iPad2,6"])     return @"iPad Mini 1G (A1454)";
    if ([deviceModelString isEqualToString:@"iPad2,7"])     return @"iPad Mini 1G (A1455)";
    
    if ([deviceModelString isEqualToString:@"iPad3,1"])     return @"iPad 3 (A1416)";
    if ([deviceModelString isEqualToString:@"iPad3,2"])     return @"iPad 3 (A1403)";
    if ([deviceModelString isEqualToString:@"iPad3,3"])     return @"iPad 3 (A1430)";
    if ([deviceModelString isEqualToString:@"iPad3,4"])     return @"iPad 4 (A1458)";
    if ([deviceModelString isEqualToString:@"iPad3,5"])     return @"iPad 4 (A1459)";
    if ([deviceModelString isEqualToString:@"iPad3,6"])     return @"iPad 4 (A1460)";
    
    if ([deviceModelString isEqualToString:@"iPad4,1"])     return @"iPad Air (A1474)";
    if ([deviceModelString isEqualToString:@"iPad4,2"])     return @"iPad Air (A1475)";
    if ([deviceModelString isEqualToString:@"iPad4,3"])     return @"iPad Air (A1476)";
    if ([deviceModelString isEqualToString:@"iPad4,4"])     return @"iPad Mini 2G (A1489)";
    if ([deviceModelString isEqualToString:@"iPad4,5"])     return @"iPad Mini 2G (A1490)";
    if ([deviceModelString isEqualToString:@"iPad4,6"])     return @"iPad Mini 2G (A1491)";
    
    if ([deviceModelString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModelString isEqualToString:@"x86_64"])       return @"Simulator";
    
    
    NSLog(@"NOTE: Unknown device type: %@", deviceModelString);
    return deviceModelString;
    
    
}

/**
 *  Hex生成Color对象 支持Hex转换成UIColo对象
 *
 *  @param stringToConvert 传入如26BFFC或者#FFB25C
 *
 *  @return Color对象
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 *  绘制纯色图片
 *
 *  @param color 颜色对象
 *  @param size  图片大小
 *
 *  @return 纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  字数统计
 *
 *  @param string 要统计的字符串
 *
 *  @return 返回字数
 */
+ (int)countWord:(NSString *)string {
    int i, n = (int)[string length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[string characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

/**
 *  去掉一些字符，防止json解析不正确
 *
 *  @param jsonString json字符串
 *
 */
+ (NSString *)removeIllegalCharactersWithString:(NSString *)jsonString {
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\s" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\v" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\f" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\b" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\a" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\e" withString:@""];
    return jsonString;
}



/**
 *  查找第一响应的控件
 *
 */
+ (UIView *)findFirstResponderBeneathView:(UIView *)view {
    
    for (UIView *childView in view.subviews) {
        if ([childView respondsToSelector:@selector(isFirstResponder)] && childView.isFirstResponder) {
            return childView;
        }
        //在查找子视图的子视图
        UIView *result = [self findFirstResponderBeneathView:childView];
        if (result) {
            return result;
        }
    }
    
    return nil;
    
}

/**
 *  截取View为图片
 *
 *  @param v 要截取的view
 *
 *  @return 图片对象
 */
+ (UIImage*)convertViewToImage:(UIView*)v {
    UIGraphicsBeginImageContext(v.bounds.size);
    
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  验证手机号
 *
 *  @param mobileNum 要验证的手机号
 *
 *  @return 正确返回YES
 */
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  判断是否是数字
 *
 *  @param string 需要判断的字符串
 *
 */
+ (BOOL)isNumberWithString:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  判断是否浮点数
 *
 *  @param string 要判断的字符串
 *
 */
+ (BOOL)isPureFloat:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
/**
 *  获取当前时间字符串
 *
 *  @param date 获取当前时间字符串
 *
 */
+(NSString *)getCurrentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    return currentTime;
}

/**
 *  将时间转化为所需的格式
 *
 *  @param date 要转换的NSDate对象
 *
 */
+ (NSString *)timeStringWithDate:(NSDate *)date {
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    
    return timeStr;
}
//将数据库时间转换成标准时间
+ (NSString *)timeWithNumber:(NSInteger)num
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(int)(num/1000)];
    //定义时间格式器
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd' 'HH':'mm':'ss"];//注意格式以及月和小时需要大写
    //转化为字符串
    NSString *dateStr = [formatter stringFromDate:date];
    //获取子串的方式获取需要色时间，也可以在格式器中直接定义。
    return dateStr;
}

+(NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate =[formatter dateFromString:startTime];
    
    NSString *nowstr = [formatter stringFromDate:now];
    NSDate *nowDate = [formatter dateFromString:nowstr];
    
    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
    NSInteger time;//剩余时间为多少分钟
    if (day != 0) {
        str = [NSString stringWithFormat:@"共%d天%d小时%d分%d秒",day,house,minute,second];
        time = day*24*60+house*60+minute;
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"共%d小时%d分%d秒",house,minute,second];
        time = house*60+minute;
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"共%d分%d秒",minute,second];
        time = minute;
    }else{
        str = [NSString stringWithFormat:@"共%d秒",second];
    }
    return str;
}
/**
 *  将字符串百分比转化为浮点数
 *
 *  @param strNum 要转化的字符串
 *
 */
+ (float)numberWithString:(NSString *)strNum {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSNumber *number = [formatter numberFromString:strNum];
    
    return [number floatValue];
}

/**
 *  将浮点数转化为百分比
 *
 *  @param progress 要转化的浮点数
 *
 */
+ (NSString *)percentStringWithfloat:(float)progress {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterPercentStyle];
    
    return [formatter stringFromNumber:@(progress)];
    
}

/**
 *  @brief  格式话小数 四舍五入类型
 *
 *  @param format 格式例如 0.000 ，保留三位小数
 *  @param floatV 数字
 *
 */
+ (NSString *)decimalwithFormat:(NSString *)format  floatV:(float)floatV {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}

/**
 *  @brief  四舍五入
 *
 *  @param doubleV  四舍五入的小数
 *  @param digitNum 保留几位小数
 *
 */
+ (NSString *)roundWithDecimal:(double)doubleV digit:(NSInteger)digitNum {
    
    NSString *formater = @"0.";
    
    if (digitNum == 0) {
        formater = @"0";
    }
    
    for (NSInteger index = 0; index < digitNum; index++) {
        formater = [formater stringByAppendingString:@"0"];
    }
    
    return [CommonCode decimalwithFormat:formater floatV:doubleV];
}

/**
 *  @brief  字符串带有删除线
 *
 *  @param str 要添加删除线的
 *
 */
+ (NSAttributedString *)strikethroughWithString:(NSString *)str {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@1
                            range:NSMakeRange(0, [attributeString length])];
    return attributeString;
}

/**
 *  @brief  移除html中的图片宽度和高度
 *
 *  @param string HTML代码
 *
 */
+ (NSString *)removeImgWidthAndHeightWithString:(NSString *)string {
    
    NSString *regexToReplaceWidth = @"\\s+width\\s*=\\s*\\S+";
    
//    NSString *regexToReplaceWidth = @"<img\\s*\\w*\\S*\\s*width\\S*\\s*height\\S*";
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexToReplaceWidth
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSString *regexToReplaceHeight = @"\\s+height\\s*=\\s*\\S+";
    NSRegularExpression *regularEx = [NSRegularExpression regularExpressionWithPattern:regexToReplaceHeight
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSString *replacedStr = [regex stringByReplacingMatchesInString:string
                                                         options:0
                                                           range:NSMakeRange(0, string.length)
                                                    withTemplate:@""];
    
    
    
    replacedStr = [regularEx stringByReplacingMatchesInString:replacedStr
                                                  options:0
                                                    range:NSMakeRange(0, replacedStr.length)
                                             withTemplate:@""];
    
    return replacedStr;
}

/**
 *  @brief  移除html中的图片宽度和高度
 *
 *  @param string HTML代码
 *
 */
+ (NSString *)removeImgWHWithString:(NSString *)string {
    
    NSString *regexToReplaceWidth = @"\\s+style=\"(.*)\""; /* <img\s\w*.*style=".*" */
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexToReplaceWidth
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    
    NSString * stringLast = [regex stringByReplacingMatchesInString:string
                                                            options:0
                                                              range:NSMakeRange(0, string.length)
                                                       withTemplate:@""];
    return stringLast;
}



#pragma mark - <网咖>项目新增

+ (BOOL)checkUserIdCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0)
    {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    return flag;
    /*
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    } */
}


/**
 *  申请音视频使用权限
 *
 *  @param handler 授权回调
 *
 *  @return 授权结果
 */
+ (BOOL)requestMediaCapturerAccessWithCompletionHandler:(void (^)(BOOL authResult, NSError *error))handler {
    AVAuthorizationStatus videoAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    AVAuthorizationStatus audioAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (AVAuthorizationStatusAuthorized == videoAuthorStatus && AVAuthorizationStatusAuthorized == audioAuthorStatus) {
        handler(YES,nil);
    }else{
        if (AVAuthorizationStatusRestricted == videoAuthorStatus || AVAuthorizationStatusDenied == videoAuthorStatus) {
            NSString *errMsg = NSLocalizedString(@"此应用需要访问摄像头，请设置", @"此应用需要访问摄像头，请设置");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            handler(NO,error);
            
            return NO;
        }
        
        if (AVAuthorizationStatusRestricted == audioAuthorStatus || AVAuthorizationStatusDenied == audioAuthorStatus) {
            NSString *errMsg = NSLocalizedString(@"此应用需要访问麦克风，请设置", @"此应用需要访问麦克风，请设置");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            handler(NO,error);
            
            return NO;
        }
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    if (granted) {
                        handler(YES,nil);
                    }else{
                        NSString *errMsg = NSLocalizedString(@"不允许访问麦克风", @"不允许访问麦克风");
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                        NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                        handler(NO,error);
                    }
                }];
            }else{
                NSString *errMsg = NSLocalizedString(@"不允许访问摄像头", @"不允许访问摄像头");
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                handler(NO,error);
            }
        }];
        
    }
    return YES;
}

+ (void)showAlertByTitle:(NSString *)title Message:(NSString*)message Block:(void (^)())block Controller:(UIViewController *)controller
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:block];
    [alert addAction:action];
    [controller presentViewController:alert animated:false completion:^{
        
    }];
}

/**
 * 格式化数据为json数据
 *  @param datas 要格式化的数据
 *  @return json字符串
 */
+(NSString*)formatToJson:(id)datas{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    return jsonTemp;
//    NSData *data=[NSJSONSerialization dataWithJSONObject:datas options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    return jsonStr;
}
+ (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}

/**
 * 截取字符串
 *  @param tmpStr 要截取的字符串
 *  @param str 要截取到那个字符串
 *  @return 字符串
 */
+(NSString*)subStr:(NSString*) tmpStr str:(NSString*)str{
    NSRange range = [tmpStr rangeOfString:str];
    if (range.location != NSNotFound) {
        return [tmpStr substringToIndex:range.location];
    }
    return @"";
}
/**
 *获取当前的时间搓
 *@return 字符串
 */
+(NSString*)getCurrentTimeRubbing{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

    return timeSp;
}
@end

/*
 
 对应指令地址 http://fuckingclangwarnings.com
 防止警告
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "对应指令"
 self.completionBlock = ^ {
 ...
 };
 #pragma clang diagnostic pop
 弃用通知和保留周期误报是这个情况可能发生的常见情况。在这些罕见的，你绝对肯定一个特定的编译器或者稳态分析器警告需要被抑制时，#pragma就派上用场了
 Clang提供了一个方便的方法来解决这一切。通过使用#pragma clang diagnostic push/pop，你可以告诉编译器仅仅为某一特定部分的代码（最初的诊断设置在最后的pop被恢复）来忽视特定警告。
 常见用法
 
 1.方法弃用告警
 
 
 #pragma clang diagnostic push
 
 #pragma clang diagnostic ignored "-Wdeprecated-declarations"
 [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
 
 #pragma clang diagnostic pop
 
 2.不兼容指针类型
 
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wincompatible-pointer-types"
 //
 #pragma clang diagnostic pop
 
 3.循环引用
 // completionBlock is manually nilled out in AFURLConnectionOperation to break the retain cycle.
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Warc-retain-cycles"
 self.completionBlock = ^ {
 ...
 };
 #pragma clang diagnostic pop
 
 4.未使用变量
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wunused-variable"
 int a;
 #pragma clang diagnostic pop
 
 5.
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wobjc-property-synthesis"
 // superclass type for currentValue was "id"
 @property (nonatomic, strong) NSDate *currentValue;
 #pragma clang diagnostic pop
 
 */
