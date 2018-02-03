//
//  AFNHttpTool.m
//  baobozhineng
//
//  Created by 魏俊阳 on 2017/12/24.
//  Copyright © 2017年 魏俊阳. All rights reserved.
//

#import "AFNHttpTool.h"
#import "CommonCode.h"
#import <AFNetworking.h>
@implementation AFNHttpTool

/**
 *  普通Get请求
 *
 *  @param url      Url地址
 *  @param params   参数
 *  @param success  成功Block
 *  @param failure  失败Block
 */
+ (void)getRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置Header
    if(GET_USERDEFAULT(USER_TOKEN) != nil){
        [manager.requestSerializer setValue:GET_USERDEFAULT(USER_TOKEN) forHTTPHeaderField:@"token"];
    }
    
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
   
    
         [manager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    
    //发起请求
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
       
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


/**
 *  普通Post请求
 *
 *  @param url      Url地址
 *  @param params   参数
 *  @param success  成功Block
 *  @param failure  失败Block
 */
+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置Header
    if(GET_USERDEFAULT(USER_TOKEN) != nil){
        [manager.requestSerializer setValue:GET_USERDEFAULT(USER_TOKEN) forHTTPHeaderField:@"token"];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
   
 
    //发起请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
          
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
         
            failure(error);
        }
    }];
}
+ (void)postCarRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置Header
   
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
    
   
    
    //设置Header
  
    //发起请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
          
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
          
            failure(error);
        }
    }];
}

/**
 *  普通Post请求
 *
 *  @param url      Url地址
 *  @param params   参数
 *  @param success  成功Block
 *  @param failure  失败Block
 */
+ (void)postParkingRequestWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void (^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置Header
   
    
    //发起请求
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
        
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
        
            failure(error);
        }
    }];
}

/**
 *  上传多张图片
 *
 *  @param url      接口地址
 *  @param params   上传的参数
 *  @param file     图片数组(UIImage对象)
 *  @param name     API对应的参数名称
 *  @param success  成功block
 *  @param failure  失败block
 */
+ (void)postRequestWithUrl:(NSString *)url params:(NSMutableDictionary *)params file:(NSMutableArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void (^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //创建请求，拼接图片数据
    NSMutableURLRequest *request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSInteger ID = 100;
        //将UIImage转换为NSData
        for (UIImage *images in file) {
            //压缩比例
            NSData *data = UIImageJPEGRepresentation(images, 0.001);
            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%ld.jpg",(long)ID] mimeType:@"image/jpeg"];
            ID++;
        }
    } error:nil];
    
    //发起请求
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            if (failure) {
                failure(error);
            }
        }else {
            if (success) {
            
                
                success(responseObject);
            }
        }
    }];
    
    //开始上传
    [uploadTask resume];
}


///下载文件
+ (void)downloadFileWithUrlString:(NSString *)urlString success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
 
    //创建请求Request
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //发起请求
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        //下载路径
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        //成功Block
        if (success) {
            success(filePath);
            //失败Block
        }else if (error) {
            failure(error);
        }
    }];
    
    //开始下载
    [downloadTask resume];
}


@end
