//
//  YYHReachability.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/17.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface YYHReachability : NSObject

@property(nonatomic,strong) Reachability *reach;

+(instancetype)sharedReach;
-(void)showNotification;
- (BOOL)hasNetWork;

@end
