//
//  AppDelegate.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "AppDelegate.h"
#import "YYHMainViewController.h"
#import "WBaccountTool.h"
#import "YYHOAuthController.h"
#import "Reachability.h"
#import "YYHReachability.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([WBaccountTool account])
    {
        self.window.rootViewController = [[YYHMainViewController alloc] init];
    }
    else
    {
        [self logout];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:@"logout" object:nil];

    //bar的背景颜色
    [[UINavigationBar appearance] setBarTintColor:kAppMainColor];
    //bar上面的按钮的颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //标题的颜色
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
    nil, NSShadowAttributeName,
    [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];

    [self.window makeKeyAndVisible];
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    

    return YES;
}

//注册推送服务
- (void)registerJpushNofition
{
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:_notification];
    
}

//关闭推送服务0
- (void)unRegisterJpushNofition
{
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    _notification = notification;
    
    YLog(@"接收本地通知:[%@]",notification);
    //清除 信息的 数字 标识
    [notification setApplicationIconBadgeNumber:0];
}

-(void)logout
{
    if ([[YYHReachability sharedReach] hasNetWork])
    {
        self.window.rootViewController = [[YYHOAuthController alloc] init];
    }
    else
    {
        self.window.rootViewController = [[YYHMainViewController alloc] init];
        [[YYHReachability sharedReach] showNotification];
    }
    
}

- (void)postLocalNotification:(NSString *)clockID isFirst:(BOOL)flag
{
    //-----获取闹钟数据---------------------------------------------------------
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *clockDictionary = [userDefault objectForKey:clockID];
    
    NSString *clockTime = [clockDictionary objectForKey:@"ClockTime"];
    NSString *clockRemainText = [clockDictionary objectForKey:@"ClockRemainText"];
    NSString *clockWeeks = [clockDictionary objectForKey:@"ClockWeeks"];
    //-----组建本地通知的fireDate-----------------------------------------------
    
    //------------------------------------------------------------------------
    NSArray *clockTimeArray = [clockTime componentsSeparatedByString:@":"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSEraCalendarUnit |
                          NSYearCalendarUnit |
                          NSMonthCalendarUnit |
                          NSDayCalendarUnit |
                          NSHourCalendarUnit |
                          NSMinuteCalendarUnit |
                          NSSecondCalendarUnit |
                          NSWeekCalendarUnit |
                          NSWeekdayCalendarUnit |
                          NSWeekdayOrdinalCalendarUnit |
                          NSQuarterCalendarUnit;
    
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    [comps setHour:[[clockTimeArray objectAtIndex:0] intValue]];
    [comps setMinute:[[clockTimeArray objectAtIndex:1] intValue]];
    [comps setSecond:0];
    
    //------------------------------------------------------------------------
    Byte weekday = [comps weekday];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[clockWeeks componentsSeparatedByString:@","]];
    [array removeLastObject];
    Byte i = 0;
    Byte j = 0;
    int days = 0;
    int	temp = 0;
    Byte count = [array count];
    Byte clockDays[7];
    
    NSArray *tempWeekdays = [NSArray arrayWithObjects:@"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    //查找设定的周期模式
    for (i = 0; i < count; i++)
    {
        for (j = 0; j < 7; j++)
        {
            if ([[array objectAtIndex:i] isEqualToString:[tempWeekdays objectAtIndex:j]])
            {
                clockDays[i] = j + 1;
                break;
            }
        }
    }
    
    for (i = 0; i < count; i++)
    {
        temp = clockDays[i] - weekday;
        days = (temp >= 0 ? temp : temp + 7);
        NSDate *newFireDate = [[calendar dateFromComponents:comps] dateByAddingTimeInterval:3600 * 24 * days];
        
        UILocalNotification *newNotification = [[UILocalNotification alloc] init];
        if (newNotification)
        {
            newNotification.fireDate = newFireDate;
            newNotification.alertBody = clockRemainText;
            newNotification.alertAction = @"查看闹钟";
            newNotification.soundName = UILocalNotificationDefaultSoundName;
            newNotification.repeatInterval = NSWeekCalendarUnit;
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:clockID forKey:@"ActivityClock"];
            newNotification.userInfo = userInfo;
            [[UIApplication sharedApplication] scheduleLocalNotification:newNotification];
        }
        YLog(@"Post new localNotification:%@", [newNotification fireDate]);
    }
}


@end
