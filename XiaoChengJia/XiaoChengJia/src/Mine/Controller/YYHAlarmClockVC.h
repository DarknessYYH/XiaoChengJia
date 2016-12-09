//
//  YYHAlarmClockVC.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/8.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHClockView.h"
#import "YYHClockCell.h"

@interface YYHAlarmClockVC : UIViewController<UITableViewDataSource, UITableViewDelegate>
{

    YYHClockView *_clockView;
    NSUserDefaults *_userDefault;
    NSMutableArray *_clockKeyArray;
}

@property (nonatomic, strong) UITableView *clockTableView;

- (void)startClock:(int)clockID;

- (void)shutdownClock:(int)clockID;

@end

