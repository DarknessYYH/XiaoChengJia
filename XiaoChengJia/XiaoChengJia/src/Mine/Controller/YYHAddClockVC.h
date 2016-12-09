//
//  YYHAddClockVC.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/11.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHAlarmClockVC.h"
#import "YYHNKColorSwitch.h"
#import "YYHClockTextView.h"
#import "UIView+Expand.h"
@interface YYHAddClockVC : UIViewController<UIAlertViewDelegate, YYHAddClockTextSuccessDelegate>
{
    UIView *mainView;
    UIDatePicker *_datePicker;
    YYHNKColorSwitch *_clockSwitch;
    UILabel *_remainTextLabel;
    UIImageView *_lineView1;
    UIView *_partView1;
    UIView *_partView2;
    UIView *_partView3;
    UILabel *_textLabel2;
    UILabel *_textLabel3;
    UIImageView *_lineView2;
    UIImageView *_lineView3;
    UIImageView *_lineView4;
    UIAlertView *_remainAlertView;
    NSUserDefaults *_userDefault;
    UIScrollView *_contentScrollView;
}

@property (nonatomic,assign) int clockID;
@property (nonatomic,strong) NSString *clockTime;
@property (nonatomic,strong) NSMutableString *weeks;
@property (nonatomic,assign) BOOL weekFlag;
@property (nonatomic,strong) NSString *remainString;
@property (nonatomic,assign) YYHAlarmClockVC *delegate;

@end
