//
//  YYHAlarmClockVC.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/8.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHAlarmClockVC.h"
#import "YYHClockView.h"
#import "YYHAddClockVC.h"
#import "AppDelegate.h"

#define MAXCLOCKCOUNT 7

@implementation YYHAlarmClockVC
{
    UIImageView *_navBarHairLineImageView;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _userDefault = [NSUserDefaults standardUserDefaults];
        _clockKeyArray = [NSMutableArray array];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"闹钟";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    self.navigationItem.backBarButtonItem = backItem;
    
    self.hidesBottomBarWhenPushed = YES;

    UIView *clockBackground = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    clockBackground.backgroundColor = kAppMainColor;
    [self.view addSubview:clockBackground];
    
    _clockView = [[YYHClockView alloc] initWithFrame:CGRectMake(0, 0, 226, 227)];
    _clockView.center = CGPointMake(clockBackground.width/2, clockBackground.height/2);
    [_clockView setClockBackgroundImage:[UIImage imageNamed:@"icon_alarm_bottom"].CGImage];
    [_clockView setHourHandImage:[UIImage imageNamed:@"icon_alarm_hour"].CGImage];
    [_clockView setMinHandImage:[UIImage imageNamed:@"icon_alarm_minute"].CGImage];
    [_clockView setSecHandImage:[UIImage imageNamed:@"icon_alarm_second"].CGImage];
    _clockView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [clockBackground addSubview:_clockView];
    
    UIImageView *clockSecondPoint = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    [clockSecondPoint setImage:[UIImage imageNamed:@"icon_alarm_second_point"]];
    clockSecondPoint.center = CGPointMake(clockBackground.width/2, clockBackground.height/2);
    [clockBackground addSubview:clockSecondPoint];
    
    _clockTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, clockBackground.y + clockBackground.height , self.view.width, self.view.height - clockBackground.height - 160)];
    _clockTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _clockTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _clockTableView.dataSource = self;
    _clockTableView.delegate = self;
    [self.view addSubview:_clockTableView];

    UIButton *addClockButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width / 2 - 25, _clockTableView.y + _clockTableView.height + 5, 50, 50)];
    [addClockButton setTitle:@"+" forState:UIControlStateNormal];
    addClockButton.titleLabel.font = [UIFont boldSystemFontOfSize:55];
    addClockButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 5.5, 0.0);
    [addClockButton setBackgroundColor:kAppMainColor];
    addClockButton.layer.cornerRadius = addClockButton.bounds.size.height/2;
    [addClockButton addTarget:self action:@selector(addClockAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addClockButton];
    
    UILabel *addClockLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    addClockLabel.center = CGPointMake(self.view.frame.size.width/2, addClockButton.frame.origin.y + addClockButton.frame.size.height + 15);
    addClockLabel.text = @"添加闹钟";
    addClockLabel.textAlignment = NSTextAlignmentCenter;
    addClockLabel.textColor = [UIColor grayColor];
    [self.view addSubview:addClockLabel];
}

- (void)addClockAction:(UIButton *)sender
{
    if (_clockKeyArray.count == MAXCLOCKCOUNT)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能添加更多了" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        [alertView show];
        return;
    }

    YYHAddClockVC *addClockVC = [[YYHAddClockVC alloc]init];
    addClockVC.delegate = self;
    for (int i = 1; i < MAXCLOCKCOUNT+1; i++)
    {
        if (![_userDefault objectForKey:[NSString stringWithFormat:@"%d", i]])
        {
            addClockVC.clockID = (int)i;
            break;
        }
    }
    [self.navigationController pushViewController:addClockVC animated:YES];  
}

- (int)initClockCount
{
    [_clockKeyArray removeAllObjects];
    for (int i = 1; i < MAXCLOCKCOUNT+1; i++)
    {
        if ([_userDefault objectForKey:[NSString stringWithFormat:@"%d", i]])
        {
            [_clockKeyArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        else
        {
            //删除通知
            [self shutdownClock:i];
        }
    }
    return (int)_clockKeyArray.count;
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self initClockCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    YYHClockCell *cell = (YYHClockCell *)[tableView dequeueReusableCellWithIdentifier:@"ClockCell"];
    if (!cell)
    {
        cell = [[YYHClockCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ClockCell" frame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
        
        UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70 - 1, _clockTableView.frame.size.width - 5, 1)];
        lineView.image = [UIImage imageNamed:@"icon_common_line"];
        [cell addSubview:lineView];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
    }
    cell.delegate = self;
    
    NSMutableDictionary *clockDictionary = [_userDefault objectForKey:_clockKeyArray[indexPath.row]];
    [cell.clockSwitch setOn:[[clockDictionary objectForKey:@"ClockState"] isEqualToString:@"yes"] ? YES : NO];
    cell.clockTimeLabel.text = [clockDictionary objectForKey:@"ClockTime"];
    NSString *weeks = [clockDictionary objectForKey:@"ClockWeeks"];
    cell.clockWeeksLabel.text = [NSString stringWithFormat:@"周%@", [weeks substringToIndex:[weeks length]-1]];
    cell.remainString = [clockDictionary objectForKey:@"ClockRemainText"];
    cell.weeks = [clockDictionary objectForKey:@"ClockWeeks"];
    cell.numberID = [_clockKeyArray[indexPath.row] intValue];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_userDefault removeObjectForKey:_clockKeyArray[indexPath.row]];
    [self shutdownClock:[_clockKeyArray[indexPath.row] intValue]];
    [_userDefault synchronize];
    [_clockTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *clockDictionary = [_userDefault objectForKey:_clockKeyArray[indexPath.row]];
    YYHAddClockVC *addClockVC = [[YYHAddClockVC alloc]init];
    addClockVC.delegate = self;
    addClockVC.clockID = [_clockKeyArray[indexPath.row] intValue];
    addClockVC.weeks = [NSMutableString stringWithString:[clockDictionary objectForKey:@"ClockWeeks"]];
    addClockVC.clockTime = [clockDictionary objectForKey:@"ClockTime"];
    addClockVC.weekFlag = [[clockDictionary objectForKey:@"ClockState"] isEqualToString:@"yes"] ? YES : NO;
    addClockVC.remainString = [clockDictionary objectForKey:@"ClockRemainText"];
    
    [self.navigationController pushViewController:addClockVC animated:YES];
}

- (void)startClock:(int)clockID
{
    //首先查找以前是否存在此本地通知,若存在,则删除以前的该本地通知,
    //再重新发出新的本地通知
    [self shutdownClock:clockID];
    
    NSString *clockIDString = [NSString stringWithFormat:@"%d", clockID];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] postLocalNotification:clockIDString isFirst:YES];
    
}

- (void)shutdownClock:(int)clockID
{
    NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for(UILocalNotification *notification in localNotifications)
    {
        if ([[[notification userInfo] objectForKey:@"ActivityClock"] intValue] == clockID)
        {
            NSLog(@"Shutdown localNotification:%@", [notification fireDate]);
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{

    [_clockView start];
}

- (void)viewWillDisappear:(BOOL)animated
{

    [_clockView stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
