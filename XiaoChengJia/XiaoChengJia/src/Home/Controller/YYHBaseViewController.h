//
//  YYHBaseViewController.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/28.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYHBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end
