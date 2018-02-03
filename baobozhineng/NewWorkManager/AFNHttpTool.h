//
//  AFNHttpTool.h
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFNHttpTool : NSObject
///普通Get请求
+ (void)getRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure;

///普通Post请求
+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)postCarRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure;

///上传文件Post请求（图片上传）
+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void (^)(NSError *error))failure;
/**
 *  普通Post请求
 *
 *  @param url      Url地址
 *  @param params   参数
 *  @param success  成功Block
 *  @param failure  失败Block
 */
+ (void)postParkingRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure;
@end
