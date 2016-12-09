//
//  YYHOAuthController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/28.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHOAuthController.h"
#import "AFNetworking.h"
#import "YYHAccountModel.h"
#import "WBaccountTool.h"
#import "YYHMainViewController.h"

@interface YYHOAuthController ()<UIWebViewDelegate>

@end

@implementation YYHOAuthController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIWebView * webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(self.view.x, self.view.y + 20, self.view.width, self.view.height - 20);
    webView.delegate = self;
    [self.view addSubview:webView];
  
    NSURL * url = [NSURL URLWithString:signURL];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];

    //清除cookie
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //缓存web清除
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    [webView loadRequest:request];
}
/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @param request        <#request description#>
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //页面加载之前先获得code，然后根据这个code来获得access token。
    //并根据token向新浪发起post请求

    NSString * urlString = request.URL.absoluteString;
    NSRange  range = [urlString rangeOfString:@"code="];
    if (range.length)
    {
        unsigned long loc = range.location + range.length;
        NSString *code = [urlString substringFromIndex:loc];
        // 5.发送POST请求给新浪,  通过code换取一个accessToken.每次code都是不一样的。
        [self accessTokenWithCode:code];
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"client_id"] = kAppKey;
    params[@"client_secret"] = kAppSecret;
    params[@"grant_type"] = kAPPType;
    params[@"redirect_uri"] = kRedirectURL;
    params[@"code"] = code;

    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager POST:BASE_TOKEN_URL
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        YYHAccountModel * accountModel = [[YYHAccountModel alloc] init];
        [accountModel initWithRespondObject:responseObject];
        [self getUserInfo:accountModel];
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        YLog(@"error:%@",error);
    }];
}

- (void)getUserInfo:(YYHAccountModel *)accountModel
{
    YYHAccountModel *userInfoModel = [[YYHAccountModel alloc] init];
    userInfoModel.access_token = accountModel.access_token;
    userInfoModel.expires_in = accountModel.expires_in;
    userInfoModel.remind_id = accountModel.remind_id;
    userInfoModel.uid       = accountModel.uid;
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = userInfoModel.access_token;
    params[@"uid"] = userInfoModel.uid;
    
    AFHTTPSessionManager *managerSession = [AFHTTPSessionManager manager];
    managerSession.responseSerializer = [AFJSONResponseSerializer serializer];
    managerSession.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [managerSession GET:kBaseURL
             parameters:params
                success:^(NSURLSessionDataTask *task, id responseObject)
    {
        userInfoModel.name = responseObject[@"name"];
        userInfoModel.profile_image_url = responseObject[@"profile_image_url"];
        userInfoModel.idescription = responseObject[@"description"];
        userInfoModel.gender       = responseObject[@"gender"];
        userInfoModel.location     = responseObject[@"location"];
        
        //归档用户信息，后面还需要头像的图片数据实现归档
        [NSKeyedArchiver archiveRootObject:userInfoModel toFile:WB_ACCOUNT_FILE_PATH];

        self.view.window.rootViewController = [[YYHMainViewController alloc] init];
    }
                failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        YLog(@"error:%@",error);
    }];
}


@end
