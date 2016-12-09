//
//  YYHAddClockVC.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/11.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHAddClockVC.h"
#import "NSString+Expand.h"

#define weekButtonHeight (SCREEN_WIDTH - 100 - 5 * 7) / 7

@implementation YYHAddClockVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        if (!_weeks)
        {
            _weeks = [NSMutableString stringWithString:@""];
            _userDefault = [NSUserDefaults standardUserDefaults];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.navigationItem.title = @"编辑闹钟";
    self.view.backgroundColor = [UIColor whiteColor];

    // 滚动区域
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 64)];
    _contentScrollView.backgroundColor = [UIColor clearColor];
    _contentScrollView.clipsToBounds = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.scrollsToTop = NO;
    [_contentScrollView setContentOffset:CGPointMake(0, 0)];
    [self.view addSubview:_contentScrollView];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(5, 0, self.view.width-10, 150)];
    _datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = locale;
    [_contentScrollView addSubview:_datePicker];

    NSArray *array = [_clockTime componentsSeparatedByString:@":"];
    NSTimeInterval interval = [[array objectAtIndex:0] intValue] * 3600 + [[array objectAtIndex:1] intValue] * 60;
    _datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    _datePicker.date = [NSDate dateWithTimeIntervalSinceReferenceDate:interval];
    [_datePicker addTarget:self action:@selector(datePickAction:) forControlEvents:UIControlEventValueChanged];
    
    //分隔线
    _lineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _datePicker.y + _datePicker.height + 6, mainView.width, 1)];
    _lineView1.image = [UIImage imageNamed:@"icon_common_line"];
    [_contentScrollView addSubview:_lineView1];
    
    _partView1 = [[UIView alloc]initWithFrame:CGRectMake(0, _lineView1.y + 6, self.view.width, 60)];
    [_contentScrollView addSubview:_partView1];
    
    UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(30, _partView1.height/2-15, 70, 30)];
    textLabel1.text = @"重复";
    textLabel1.font = [UIFont systemFontOfSize:15];
    [_partView1 addSubview:textLabel1];
    
    UIButton *weekButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, weekButtonHeight, weekButtonHeight)];
    weekButton1.centerX = textLabel1.x + textLabel1.width;
    weekButton1.centerY = _partView1.height/2;
    [weekButton1 setTitle:@"一" forState:UIControlStateNormal];
    [weekButton1 setTintColor:[UIColor whiteColor]];
    weekButton1.layer.cornerRadius = weekButtonHeight/2;
    weekButton1.backgroundColor = [_weeks rangeOfString:@"一"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton1.tag = 11;
    [weekButton1 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton1];
    
    UIButton *weekButton2 = [[UIButton alloc]initWithFrame:CGRectMake(weekButton1.x + weekButton1.width + 5, weekButton1.y, weekButtonHeight, weekButtonHeight)];
    [weekButton2 setTitle:@"二" forState:UIControlStateNormal];
    [weekButton2 setTintColor:[UIColor whiteColor]];
    weekButton2.layer.cornerRadius = weekButtonHeight/2;
    weekButton2.backgroundColor = [_weeks rangeOfString:@"二"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton2.tag = 12;
    [weekButton2 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton2];
    
    UIButton *weekButton3 = [[UIButton alloc]initWithFrame:CGRectMake(weekButton2.x + weekButton2.width + 5, weekButton1.y, weekButtonHeight, weekButtonHeight)];
    [weekButton3 setTitle:@"三" forState:UIControlStateNormal];
    [weekButton3 setTintColor:[UIColor whiteColor]];
    weekButton3.layer.cornerRadius = weekButtonHeight / 2;
    weekButton3.backgroundColor = [_weeks rangeOfString:@"三"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton3.tag = 13;
    [weekButton3 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton3];
    
    UIButton *weekButton4 = [[UIButton alloc]initWithFrame:CGRectMake(weekButton3.x + weekButton3.width + 5, weekButton1.y, weekButtonHeight, weekButtonHeight)];
    [weekButton4 setTitle:@"四" forState:UIControlStateNormal];
    [weekButton4 setTintColor:[UIColor whiteColor]];
    weekButton4.layer.cornerRadius = weekButtonHeight/2;
    weekButton4.backgroundColor = [_weeks rangeOfString:@"四"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton4.tag = 14;
    [weekButton4 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton4];
    
    UIButton *weekButton5 = [[UIButton alloc]initWithFrame:CGRectMake(weekButton4.x + weekButton4.width + 5, weekButton1.y, weekButtonHeight, weekButtonHeight)];
    [weekButton5 setTitle:@"五" forState:UIControlStateNormal];
    [weekButton5 setTintColor:[UIColor whiteColor]];
    weekButton5.layer.cornerRadius = weekButtonHeight/2;
    weekButton5.backgroundColor = [_weeks rangeOfString:@"五"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton5.tag = 15;
    [weekButton5 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton5];
    
    UIButton *weekButton6 = [[UIButton alloc]initWithFrame:CGRectMake(weekButton5.x + weekButton5.width + 5, weekButton1.y, weekButtonHeight, weekButtonHeight)];
    [weekButton6 setTitle:@"六" forState:UIControlStateNormal];
    [weekButton6 setTintColor:[UIColor whiteColor]];
    weekButton6.layer.cornerRadius = weekButtonHeight/2;
    weekButton6.backgroundColor = [_weeks rangeOfString:@"六"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton6.tag = 16;
    [weekButton6 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton6];
    
    UIButton *weekButton7 = [[UIButton alloc]initWithFrame:CGRectMake(weekButton6.x + weekButton6.width + 5, weekButton1.y, weekButtonHeight, weekButtonHeight)];
    [weekButton7 setTitle:@"日" forState:UIControlStateNormal];
    [weekButton7 setTintColor:[UIColor whiteColor]];
    weekButton7.layer.cornerRadius = weekButtonHeight/2;
    weekButton7.backgroundColor = [_weeks rangeOfString:@"日"].length > 0 ? kAppMainColor:kColor(207,207,207);
    weekButton7.tag = 17;
    [weekButton7 addTarget:self action:@selector(weekButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_partView1 addSubview:weekButton7];
    
    //分隔线
    _lineView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _partView1.y + _partView1.height+1, self.view.width, 1)];
    _lineView2.image = [UIImage imageNamed:@"icon_common_line"];
    [_contentScrollView addSubview:_lineView2];
    
    _partView2 = [[UIView alloc]initWithFrame:CGRectMake(0, _lineView2.y + 1, self.view.width, 60)];
    [_contentScrollView addSubview:_partView2];
    
    _textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, _partView2.height/2-15, 50, 30)];
    _textLabel2.text = @"提示语:";
    _textLabel2.font = [UIFont systemFontOfSize:15];
    [_partView2 addSubview:_textLabel2];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remainTextAction:)];

    _remainTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textLabel2.x + _textLabel2.width + 20, _textLabel2.y, self.view.width - 100, 30)];
    _remainTextLabel.font = [UIFont systemFontOfSize:15];
    
    _remainTextLabel.text = _remainString ? _remainString:@"请点击此处输入提示语";
    _remainTextLabel.numberOfLines = 0;
    _remainTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _remainTextLabel.userInteractionEnabled = YES;
    [_remainTextLabel addGestureRecognizer:tapGestureRecognizer];
    [_partView2 addSubview:_remainTextLabel];
    
    NSString *remainStr = _remainTextLabel.text;
    CGRect rect = [remainStr boundingRectWithSize:CGSizeMake(self.view.width - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    float addressHeight = (rect.size.height>30) ? rect.size.height:30;
    _remainTextLabel.frame =CGRectMake(_textLabel2.x + _textLabel2.width + 20, _textLabel2.y, self.view.width - 100, addressHeight);
    
    //分隔线
    _lineView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _partView2.y + _partView2.height+ (_remainTextLabel.height - 30) + 6, self.view.width, 1)];
    _lineView3.image = [UIImage imageNamed:@"icon_common_line"];
    [_contentScrollView addSubview:_lineView3];
    
    _partView3 = [[UIView alloc]initWithFrame:CGRectMake(0, _lineView3.y + 1, self.view.width, 60)];
    [_contentScrollView addSubview:_partView3];

    _textLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(30, _partView3.height/2-15, 100, 30)];
    _textLabel3.text = @"闹钟提醒";
    _textLabel3.font = [UIFont systemFontOfSize:15];
    [_partView3 addSubview:_textLabel3];
    
    _clockSwitch = [[YYHNKColorSwitch alloc] initWithFrame:CGRectMake(self.view.width - 80, _textLabel3.y, 72, 32)];
    [_clockSwitch addTarget:self action:@selector(addClockSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [_clockSwitch setOnTintColor:kAppMainColor];
    if (!_clockTime)
    {
        _weekFlag = YES;
    }
    [_clockSwitch setOn:_weekFlag];
    [_clockSwitch setTintColor:[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1]];
    [_clockSwitch setShape:kNKColorSwitchShapeOval];
    _clockSwitch.tag = 2000;
    [_partView3 addSubview:_clockSwitch];
    
    //分隔线
    _lineView4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _partView3.y + _partView3.height + 6, self.view.width, 1)];
    _lineView4.image = [UIImage imageNamed:@"icon_common_line"];
    [_contentScrollView addSubview:_lineView4];
    
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _datePicker.height + _partView1.height + _partView2.height + _partView3.height + (_remainTextLabel.height - 30) + 30);
    
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    saveButton.center = CGPointMake(self.view.width/4, self.view.height - 90);

    [saveButton setBackgroundColor:kAppMainColor];
    saveButton.layer.cornerRadius = 5;
    saveButton.clipsToBounds = YES;
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [saveButton setTintColor:[UIColor whiteColor]];
    saveButton.layer.cornerRadius = 5;
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    deleteButton.center = CGPointMake((self.view.width/4)*3, self.view.height - 90);
    [deleteButton setTitle:@"删除闹钟" forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteButton setTintColor:[UIColor whiteColor]];
    deleteButton.backgroundColor = kColor(207,207,207);
    deleteButton.layer.cornerRadius = 5;
    [deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteButton];
    
    if (!_clockTime)
    {
        deleteButton.hidden = YES;
        self.navigationItem.title = @"添加闹钟";
    }
}

- (void)remainTextAction:(UITapGestureRecognizer *)recognizer
{
    YYHClockTextView *clockTextView = [[YYHClockTextView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) remainStr:_remainTextLabel.text];
    clockTextView.addClockTextSuccessDelegate = self;
    [clockTextView fadeIn:[[UIApplication sharedApplication].delegate window]];
}

- (void)addClockTextSuccess:(NSString *)str
{
    _remainTextLabel.text = str;
    
    CGRect rect = [str boundingRectWithSize:CGSizeMake(self.view.width - 100, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    float addressHeight = (rect.size.height>30) ? rect.size.height:30;
    _remainTextLabel.frame =CGRectMake(_textLabel2.x + _textLabel2.width + 20, _textLabel2.y, self.view.width - 100, addressHeight);

    _lineView3.frame = CGRectMake(0, _partView2.y + _partView2.height + (_remainTextLabel.height - 30) + 6, self.view.width, 1);
    _partView3.frame = CGRectMake(0, _lineView3.y + 1, self.view.width, 60);
    _textLabel3.frame = CGRectMake(30, _partView3.height / 2 - 15, 100, 30);
    _clockSwitch.frame = CGRectMake(self.view.width - 80, _textLabel3.y, 72, 32);
    _lineView4.frame = CGRectMake(0, _partView3.y + _partView3.height + 6, self.view.width, 1);
    
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _datePicker.height + _partView1.height + _partView2.height + _partView3.height + (_remainTextLabel.height - 30) + 30);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)saveButtonAction
{
    if (_weeks.length <= 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"至少选择一天" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if ([NSString isEmptyString:_remainTextLabel.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"要添加提示语哦～" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    NSMutableDictionary *clockDictionary = [NSMutableDictionary dictionaryWithCapacity:4];
    
    NSString *clockState = @"no";
    if (_clockSwitch.isOn)
    {
        clockState = @"yes";
    }
    [clockDictionary setObject:clockState forKey:@"ClockState"];
    
    NSString *timeString = @"";
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    comps = [calendar components:unitFlags fromDate:_datePicker.date];
    if ([comps minute] < 10)
        timeString = [NSString stringWithFormat:@"%d:0%d", (int)[comps hour], (int)[comps minute]];
    else
        timeString = [NSString stringWithFormat:@"%d:%d", (int)[comps hour], (int)[comps minute]];
    if ([timeString isEqualToString:@"0:00"])
    {
        timeString = @"0:01";
    }
    [clockDictionary setObject:timeString forKey:@"ClockTime"];
    
    NSMutableString *tempWeeks = [NSMutableString stringWithString:@""];
    if ([_weeks rangeOfString:@"一"].length > 0)
    {
        [tempWeeks appendString:@"一,"];
    }
    if ([_weeks rangeOfString:@"二"].length > 0)
    {
        [tempWeeks appendString:@"二,"];
    }
    if ([_weeks rangeOfString:@"三"].length > 0)
    {
        [tempWeeks appendString:@"三,"];
    }
    if ([_weeks rangeOfString:@"四"].length > 0)
    {
        [tempWeeks appendString:@"四,"];
    }
    if ([_weeks rangeOfString:@"五"].length > 0)
    {
        [tempWeeks appendString:@"五,"];
    }
    if ([_weeks rangeOfString:@"六"].length > 0)
    {
        [tempWeeks appendString:@"六,"];
    }
    if ([_weeks rangeOfString:@"日"].length > 0)
    {
        [tempWeeks appendString:@"日,"];
    }
    [clockDictionary setObject:tempWeeks forKey:@"ClockWeeks"];

    [clockDictionary setObject:_remainTextLabel.text forKey:@"ClockRemainText"];
    
    [_userDefault setObject:clockDictionary forKey:[NSString stringWithFormat:@"%d", _clockID]];
    
    if ([clockState isEqualToString:@"yes"])
    {
        [_delegate startClock:_clockID];
    }
    [_userDefault synchronize];
    [_delegate.clockTableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)deleteButtonAction
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定要删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [_userDefault removeObjectForKey:[NSString stringWithFormat:@"%d", _clockID]];
        [_delegate shutdownClock:_clockID];
        [_userDefault synchronize];
        [_delegate.clockTableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)datePickAction:(UIDatePicker *)sender
{
}

- (void)weekButtonAction:(UIButton *)sender
{
    UIButton *button = sender;
    if ([_weeks rangeOfString:button.titleLabel.text].length > 0)
    {
        NSRange range = NSMakeRange(0, [_weeks length]);
        [_weeks replaceOccurrencesOfString:[NSString stringWithFormat:@"%@,", button.titleLabel.text] withString:@"" options:NSCaseInsensitiveSearch range:range];
        button.backgroundColor = kColor(207, 207, 207);
    }
    else
    {
        [_weeks appendString:[NSString stringWithFormat:@"%@,", button.titleLabel.text]];
        button.backgroundColor = kAppMainColor;
    }
    
}

- (void)addClockSwitchAction:(id)sender
{
}



@end


























