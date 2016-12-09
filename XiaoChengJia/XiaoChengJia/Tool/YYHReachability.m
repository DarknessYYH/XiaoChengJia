//
//  YYHReachability.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/17.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHReachability.h"

@implementation YYHReachability

+(instancetype)sharedReach
{
    static YYHReachability *yyhReachbility;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yyhReachbility = [[YYHReachability alloc] init];
    });
    return yyhReachbility;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self reachabilityNotification];
    }
    
    return self;
}

-(void)reachabilityNotification
{
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotification) name:kReachabilityChangedNotification object:nil];
    
    //开始网络监控
    self.reach = [Reachability reachabilityForInternetConnection];
    [self.reach startNotifier];
    
    
}

-(void)showNotification
{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络连接已断开" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            
        }]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
            
        }];
    }
}

- (BOOL)hasNetWork
{
    if(self.reach.currentReachabilityStatus == NotReachable)
    {
        return NO;
    }
    
    return YES;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
