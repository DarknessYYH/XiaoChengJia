//
//  AppDelegate.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UILocalNotification *_notification;
}
@property (strong, nonatomic) UIWindow *window;

- (void)postLocalNotification:(NSString *)clockID
                      isFirst:(BOOL)flag;

@end
