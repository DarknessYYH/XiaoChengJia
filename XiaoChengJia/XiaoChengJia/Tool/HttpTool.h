//
//  HttpTool.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

typedef void(^HttpSuccessBlock)(id result);
typedef void(^HttpFailureBlock)(NSError * error);
typedef void(^imageSuccessBlock)(CGSize imageSize);

/**
 *  根据URL路径跟请求参数完成GET请求
 *
 *  @param path         详细路径
 *  @param params        请求参数
 *  @param successBlock 请求成功
 *  @param failureBlock 请求失败
 */
+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure;

+ (void)postWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;

+ (void)headWithPath:(NSString *)path
              params:(NSDictionary *)params
             success:(HttpSuccessBlock)success
             failure:(HttpFailureBlock)failure;


/**
    使用URLSession上传图片
 */
+(void)upLoadimage:(UIImage*)image
              path:(NSString*)path
             param:(NSDictionary*)param
           success:(HttpSuccessBlock)success
           failure:(HttpFailureBlock)failure;

+ (void)uploadImageWithImageName:(NSString *)baseURL
                       imageName:(NSString *)imageName
                    newImageName:(NSString *)newImageName;

+ (void)downLoadImageWithURL:(NSString *)url
                Content_Type:(NSString *)type;

+ (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
                success:(HttpSuccessBlock)success
                failure:(HttpFailureBlock)failure
                 method:(NSString *)method;

@end
