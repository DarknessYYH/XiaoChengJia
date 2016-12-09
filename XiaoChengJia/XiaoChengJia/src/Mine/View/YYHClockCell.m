//
//  YYHClockCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/10.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHClockCell.h"
#import "YYHAlarmClockVC.h"
@implementation YYHClockCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _clockTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 30)];
        _clockTimeLabel.font = [UIFont boldSystemFontOfSize:24];
        [self.contentView addSubview:_clockTimeLabel];
        
        _clockWeeksLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, _clockTimeLabel.frame.origin.y + _clockTimeLabel.frame.size.height, self.contentView.bounds.size.width - 100, 30)];
        _clockWeeksLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_clockWeeksLabel];
        
        _clockSwitch = [[YYHNKColorSwitch alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 80, 20, 72, 32)];
        [_clockSwitch addTarget:self action:@selector(clockSwitchAction:) forControlEvents:UIControlEventValueChanged];
        [_clockSwitch setOnTintColor:kAppMainColor];
        [_clockSwitch setTintColor:kColor(226, 226, 226)];
        [_clockSwitch setShape:kNKColorSwitchShapeOval];
        _clockSwitch.tag = 1000;
        [self.contentView addSubview:_clockSwitch];
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 1, frame.size.width - 20, 1)];
        [self.contentView addSubview:line];
    }
    return self;
}
-(void)clockSwitchAction:(id)sender
{
    YYHNKColorSwitch *nkswitch = (YYHNKColorSwitch *)sender;
    NSMutableDictionary *clockDictionary = [NSMutableDictionary dictionaryWithCapacity:4];
    [clockDictionary setObject:(nkswitch.isOn == YES ? @"yes" : @"no") forKey:@"ClockState"];
    [clockDictionary setObject:_clockTimeLabel.text forKey:@"ClockTime"];
    [clockDictionary setObject:_weeks forKey:@"ClockWeeks"];
    [clockDictionary setObject:_remainString forKey:@"ClockRemainText"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d",_numberID]];
    if (nkswitch.isOn)
    {
        [_delegate startClock:_numberID];
    }
    else
    {
        [_delegate shutdownClock:_numberID];
    }
    [userDefault synchronize];
}















@end
