//
//  HttpTool.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"
#import "NSString+JJ.h"

@implementation HttpTool


#pragma mark -GET
+ (void)getWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    
    [HttpTool requestWithPath:path params:params success:success failure:failure method:@"GET"];
}
#pragma mark -POST
+ (void)postWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure
{
    
    [HttpTool requestWithPath:path params:params success:success failure:failure method:@"POST"];
}

+ (void)headWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure
{
    
    [HttpTool requestWithPath:path params:params success:success failure:failure method:@"HEAD"];
    
}

+ (void)requestWithPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure method:(NSString *)method
{
    
    //2.拼接完整请求参数
    NSMutableDictionary *allParams = [NSMutableDictionary dictionary];
    // a.拼接传进来的参数
    if (params)
    {
        [allParams setDictionary:params];
    }
  
#pragma mark -开始POST +GET +PUT +DEL
    
    //1,config
    NSURLSessionConfiguration  *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.timeoutIntervalForRequest = 10;
    
    NSDictionary *headDic =@{@"Content-Type":@"application/json",
                             @"X-AVOSCloud-Application-Id":AVOS_APP_ID,
                             @"X-AVOSCloud-Application-Key":AVOS_APP_KEY};
    
    [sessionConfiguration setHTTPAdditionalHeaders:headDic]; //增加HTTP header

    AFHTTPSessionManager * httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL] sessionConfiguration:sessionConfiguration];
    httpManager.responseSerializer =[AFJSONResponseSerializer serializer];
    httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //3.发送请求
    if ([method isEqualToString:@"GET"])
    {
        NSURLSessionDataTask *getTask = [httpManager GET:path
                                              parameters:allParams
                                                 success:^(NSURLSessionDataTask *task, id responseObject)
        {
            if (responseObject[@"success"] && [responseObject[@"success"] isEqualToNumber:@(0)])
            {
                success(nil);
                return;
            }
            success(responseObject);
        }
        failure:^(NSURLSessionDataTask *task, NSError *error)
        {
            failure(error);
        }];
        
        [getTask resume];
 
    }
    else if ([method isEqualToString:@"POST"])
    {
        
        NSURLSessionDataTask *postTask = [httpManager POST:path
                                                parameters:allParams
                                                   success:^(NSURLSessionDataTask *task, id responseObject)
        {
            if (responseObject[@"success"] && [responseObject[@"success"] isEqualToNumber:@(0)])
            {
                success(nil);
                return;
            }
            success(responseObject);
        }
        failure:^(NSURLSessionDataTask *task, NSError *error)
        {
            YLog(@"URL错误:%@",error);
            failure(error);
        }];
        [postTask resume];
    }
    else if ([method isEqualToString:@"HEAD"])
    {
        
        NSURLSessionDataTask *postTask = [httpManager HEAD:path
                                                parameters:allParams
                                                   success:^(NSURLSessionDataTask *task)
        {
            success(task.response);
        }
        failure:^(NSURLSessionDataTask *task, NSError *error)
        {
            failure(error);
        }];
        [postTask resume];
    }
}

#pragma mark -上传图片
+(void)upLoadimage:(UIImage *)image
              path:(NSString *)path
             param:(NSDictionary *)param
           success:(HttpSuccessBlock)success
           failure:(HttpFailureBlock)failure
{
    
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    NSData *imageData=UIImageJPEGRepresentation(image, 1.0);
    
    [httpManager POST:path parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:imageData
                                     name:@"head"
                                 fileName:@"jjjjjjjj.jpg"
                                 mimeType:@"image/jpeg"];
     }
              success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(responseObject);
     }
              failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(error);
         YLog(@"失败原因:%@---%@",error,operation);
     }];
}

//上传图片,暂时支持JPEG/png两种格式
//也可以通过路径方式上传图片。只需要修改为appendPartWithFileURL,填入文件路径即可。
+ (void)uploadImageWithImageName:(NSString *)baseURL imageName:(NSString *)imageName
                    newImageName:(NSString *)newImageName
{
    NSURLSessionConfiguration *session = [NSURLSessionConfiguration defaultSessionConfiguration];
    session.timeoutIntervalForRequest = 20;
    
    NSDictionary *headerDic = @{@"Content-Type":@"image/png",
                                @"X-AVOSCloud-Application-Id":AVOS_APP_ID,
                                @"X-AVOSCloud-Application-Key":AVOS_APP_KEY};
    if ([imageName hasSuffix:@".jpg"])
    {
        [headerDic setValue:@"Content-Type" forKey:@"image/jpeg"];
    }
    [session setHTTPAdditionalHeaders:headerDic];
    NSData *imageData = nil;
    //获取图片数据
    UIImage *image = [UIImage imageNamed:imageName];
    if ([imageName hasSuffix:@".jpg"])
    {
        imageData = UIImageJPEGRepresentation(image, 1.0);
    }
    else
    {
        imageData = UIImagePNGRepresentation(image);
    }
    
    NSString *url = [baseURL stringByAppendingString:imageName];
    
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer]
                multipartFormRequestWithMethod:@"POST"
                                     URLString:url
                                    parameters:nil
                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
            [formData appendPartWithFileData:imageData
                                        name:@"file"
                                    fileName:newImageName
                                    mimeType:[headerDic objectForKey:@"Content-Type"]];
    }
    error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]
                                    initWithSessionConfiguration:session];
    
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                       progress:&progress
                                                              completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
        {
        if (error)
        {
            YLog(@"Error: %@",error);
        }else{
            YLog(@"%@-%@",response,responseObject);
        }
    }];
    [uploadTask resume];
}

//下载图片，下载的图片全部放在cache当中，每次先查找cache再进行网络请求
//type:Content-Type== image/png
+ (void)downLoadImageWithURL:(NSString *)url Content_Type:(NSString *)type
{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSDictionary *headDic = @{@"Content-Type":type,
                              @"X-AVOSCloud-Application-Id":AVOS_APP_ID,
                              @"X-AVOSCloud-Application-Key":AVOS_APP_KEY
                              };
    [configuration setHTTPAdditionalHeaders:headDic];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:nil
                                                                  destination:^NSURL *(NSURL *targetPath, NSURLResponse *response)
    {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory
                                                                              inDomain:NSUserDomainMask
                                                                     appropriateForURL:nil
                                                                                create:NO
                                                                                 error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    }
    completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error)
    {
        YLog(@"File downloaded to: %@", filePath);
    }];

    [downloadTask resume];
}



@end
