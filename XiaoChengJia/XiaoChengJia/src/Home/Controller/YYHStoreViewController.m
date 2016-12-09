//
//  YYHStoreViewController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/29.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHStoreViewController.h"
#import "YYHStoreCell.h"
#import "YYHDetailOfStoreViewController.h"
#import "YYHBusinessAPITool.h"
#import "MJRefresh.h"
#import "YYHDetailOfStoreFrame.h"
#import "YYHReachability.h"

@interface YYHStoreViewController ()<MJRefreshBaseViewDelegate>
{
    NSDictionary *uidOfRequest ;
}

@property(nonatomic,weak) MJRefreshFooterView *footer;
@property(nonatomic,weak) MJRefreshHeaderView *header;
@property(nonatomic,strong) Reachability *reach;
@end

@implementation YYHStoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    uidOfRequest = @{
                     @"宵夜外卖":@"classes/xiaoyewaimai",
                     @"出行包车":@"classes/chuxingbaoche",
                     @"休闲娱乐":@"classes/xiuxianyule",
                     @"餐饮美食":@"classes/canyinmeishi",
                     
                     @"快递物流":@"classes/kuaidiwuliu",
                     @"服装相关":@"classes/fushixiangguan",
                     @"家居装修":@"classes/jiajuzhuangxiu",
                     @"驾校学车":@"classes/jiaxiaoxueche",
                     
                     @"横幅海报":@"classes/hengfuhaibao",
                     @"蛋糕订制":@"classes/dangaodingzhi",
                     @"周边住宿":@"classes/jiudianlvyou",
                     @"其他"   :@"classes/other",
                     };
    //自定义返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"";
    self.navigationItem.backBarButtonItem = backBtn;
    
    [self setupRefreshView];
    //加载网络数据
    [self loadNetworkData];

}
#pragma mark -网络
-(void)loadNetworkData
{
    if ([[YYHReachability sharedReach] hasNetWork])
    {
        NSString *pathOfRequest = [uidOfRequest valueForKey:self.title];
        if (pathOfRequest !=nil)
        {
            [YYHBusinessAPITool getAllBusiness:pathOfRequest success:^(id result)
             {
                 
                 NSArray * array = result;
                 NSMutableArray * frameArray = [[NSMutableArray array] init];
                 for (id model in array)
                 {
                     YYHDetailOfStoreFrame *frame = [[YYHDetailOfStoreFrame alloc] init];
                     frame.detailStoreModel = model;
                     [frameArray addObject:frame];
                     
                 }
                 self.dataSource = frameArray;
                 [self.tableView reloadData];
                 
             }
                                       failure:^(NSError *error)
            {
                                           YLog(@"error:%@",error);
                                       }];
            
        }
        else
        {
            YLog(@"失败!:%@",self.title);
        }
        
    }
    else
    {
        [[YYHReachability sharedReach] showNotification];
    }
}

#pragma  设置上拉以及下拉刷新控件
- (void)setupRefreshView
{
    //定义下拉刷新
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.delegate = self;
    self.header = header;
    
    //定义上拉刷新
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.delegate = self;
    self.footer = footer;
    
}
#pragma 必须调用析构来释放
- (void) dealloc
{
    [self.header free];
    [self.footer free];
}

/*
 *重写协议的方法，开始刷新数据时调用
 */

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshFooterView class]])
    {
        [self loadMoreData];
    }
    else
    {
        [self loadNewData];
        [self loadNetworkData];
    }
}

#pragma  加载数据
- (void)loadMoreData
{
    [self.footer endRefreshing];
}

- (void)loadNewData
{
    [self.header endRefreshing];
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
    static NSString *cellID = @"YYHStoreCell_id";
    
    YYHStoreCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [YYHStoreCell instanceWithXib];
    }
    YYHDetailOfStoreFrame * b_frame = self.dataSource[indexPath.row];
    cell.detailOfStoreFrame = b_frame;
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    //点击该row的cell，先从数据源从获取当前的数据，然后跳转到下一个商家详情界面。
    YYHDetailOfStoreViewController *detailController = [[YYHDetailOfStoreViewController alloc] init];
    //将使用model，首先数据模型与字典之间的转换。而不适用直接的方式赋值
    detailController.dataSource[0] = self.dataSource[indexPath.row];//获取某一间商店的数据
    detailController.title = [detailController.dataSource[0] detailStoreModel].storeName;    
    [self.navigationController pushViewController:detailController animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

@end
