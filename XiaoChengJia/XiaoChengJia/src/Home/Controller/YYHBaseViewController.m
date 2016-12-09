//
//  YYHBaseViewController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/28.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseViewController.h"

@implementation YYHBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    //让多余的空cell不显示
    self.tableView.tableFooterView= [[UIView alloc] init];
}


#pragma mark -UI控件
- (UITableView *)tableView
{
    if (!_tableView)
    {

        UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                               style:UITableViewStylePlain];

        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tintColor= [UIColor orangeColor];
        _tableView = tableView;
        
    }
    return _tableView;
}
#pragma mark -数据源
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // in subClass
    return nil;
}

@end
