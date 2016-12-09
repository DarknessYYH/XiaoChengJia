//
//  YYHMineController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHMineController.h"
#import "AFNetworking.h"
#import "YYHUserImageCell.h"
#import "YYHUserInfoCell.h"
#import "WBaccountTool.h"
#import "UIImage+Fit.h"
#import "YYHAlarmClockVC.h"


@implementation YYHMineController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.sectionFooterHeight = 10;
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    logout.frame = CGRectMake(30, 5, self.view.width - 60, 50);
    if ([WBaccountTool account])
    {
        [logout setTitle:@"退出当前账号" forState:UIControlStateNormal];
    }
    else
    {
       [logout setTitle:@"请点击登陆" forState:UIControlStateNormal];
    }
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg.png"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg_highlighted.png"] forState:UIControlStateHighlighted];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logout.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 80)];
    [view1 addSubview:logout];
    self.tableView.tableFooterView = view1;
    self.tableView.scrollEnabled = NO;

    //利用颜色转图片
    CGRect rect= CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, kAppMainColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:theImage forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}

-(void)logout
{

    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL bRet = [fileMgr fileExistsAtPath:WB_ACCOUNT_FILE_PATH];
    
    NSError *err ;
    if (bRet)
    {
        [fileMgr removeItemAtPath:WB_ACCOUNT_FILE_PATH error:&err];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:nil forKey:@"1"];
        [defaults setObject:nil forKey:@"2"];
        [defaults setObject:nil forKey:@"3"];
        [defaults setObject:nil forKey:@"4"];
        [defaults setObject:nil forKey:@"5"];
        [defaults setObject:nil forKey:@"6"];
        [defaults setObject:nil forKey:@"7"];
        [defaults setObject:nil forKey:@"headImage"];
        [defaults synchronize];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 200 : 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString * cellID = @"userImage_id";
        YYHUserImageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [[YYHUserImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:cellID];
        }
        
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        static NSString *cellID = @"userInfoCell_id";
        YYHUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [[YYHUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.cellImage.image =[UIImage imageNamed:@"userInfolocation"];
        cell.cellLabel.text = [WBaccountTool account].location;
        
        return cell;
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
        static NSString *cellID = @"userInfoCell_id";
        YYHUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [[YYHUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellID];
        }
        cell.cellImage.image =[UIImage imageNamed:@"school_os7"];
        cell.cellLabel.text = @"生活百科";
        
        return cell;
    }
    else
    {
        static NSString *cellID = @"userInfoCell_naozhong";
        YYHUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [[YYHUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellID];
        }
        cell.cellImage.image =[UIImage imageNamed:@"naozhong"];
        cell.cellLabel.text = @"闹钟";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2)
    {
    self.hidesBottomBarWhenPushed = YES;
    YYHAlarmClockVC *alerm = [[YYHAlarmClockVC alloc] init];
    [self.navigationController pushViewController:alerm animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
