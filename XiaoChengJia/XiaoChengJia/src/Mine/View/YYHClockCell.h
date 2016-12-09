//
//  YYHClockCell.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/10.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHNKColorSwitch.h"
@class YYHAlarmClockVC;
@interface YYHClockCell : UITableViewCell
@property(nonatomic,assign) YYHAlarmClockVC *delegate;
@property(nonatomic,strong) YYHNKColorSwitch *clockSwitch;
@property(nonatomic,strong) UILabel *clockTimeLabel;
@property(nonatomic,strong) UILabel *clockWeeksLabel;
@property(nonatomic,assign) int numberID;
@property(nonatomic,strong) NSString *weeks;
@property(nonatomic,strong) NSString *remainString;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;
@end
