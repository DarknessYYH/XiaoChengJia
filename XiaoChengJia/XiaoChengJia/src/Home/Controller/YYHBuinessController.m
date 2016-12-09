//
//  YYHBuinessController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHNavigationCell.h"
#import "YYHBuinessController.h"
#import "YYHBusinessAPITool.h"
#import "YYHStoreViewController.h"
#import "YYHStoreCell.h"
#import "YYHDetailOfStoreModel.h"
#import "YYHDetailOfStoreViewController.h"
#import "UIImageView+WebCache.h"
#import "YYHDetailOfStoreFrame.h"
#import "YYHBuinessTitleHeadView.h"
#import "MBProgressHUD+MJ.h"
#import "DATManager.h"
#import "BaseDAT.h"
#import "MJRefresh.h"
#import "YYHReachability.h"

@interface YYHBuinessController ()<SDWebImageManagerDelegate,MJRefreshBaseViewDelegate>

@property(nonatomic,strong) NSArray *naviClassesByButtonTag;
@property(nonatomic,weak) MJRefreshFooterView *footer;
@property(nonatomic,weak) MJRefreshHeaderView *header;

@end

@implementation YYHBuinessController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _naviClassesByButtonTag = @[@"宵夜外卖",@"出行包车",@"休闲娱乐",@"餐饮美食",
                                @"快递物流",@"服装相关",@"家居装修",@"驾校学车",
                                @"横幅海报",@"蛋糕订制",@"周边住宿",@"其他"
                                ];

    [self loadLocalData];//先加载本地数据，然后加载服务器数据
    //自定义返回按钮
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] init];
    backBtn.title = @"";
    self.navigationItem.backBarButtonItem = backBtn;
    
    [self setupRefreshView];
    [self loadNetData];
    
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


#pragma mark - 根据后面需求，按照查询约束来插入以及查询数据
- (void)loadLocalData
{
    //加载本地数据库的数据
    if ([[BaseDAT sharedBaseDAT] hasTableWithName:@"DetailModelDAT"])
    {
        NSArray *storeModel = [NSArray arrayWithArray:[[DATManager sharedDATManager].detailModelDAT getAll]];
        for (id model in storeModel)
        {
            YYHDetailOfStoreFrame *frameModel = [[YYHDetailOfStoreFrame alloc] init];
            frameModel.detailStoreModel = model;
            [self.dataSource addObject:frameModel];
        }
        [self.tableView reloadData];
    }
}
- (void)loadNetData
{
    if ([[YYHReachability sharedReach] hasNetWork])
    {
        //请求服务器的最新数据，注意请求的数据的个数要与数据库里面的个数保持一致
        [YYHBusinessAPITool getAllBusiness:HOT_STORE_PATH success:^(id result)
         {
             if (result)
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
                 [self updateLocalData:self.dataSource];
                 [self.tableView reloadData];
                 
             }
         }
                                   failure:^(NSError *error)
         {
             YLog(@"error:%@",error);
         }];
    }else
    {
        [[YYHReachability sharedReach] showNotification];
    }
    
    
}
#pragma mark - 网络数据更新数据库中热门商家的数据
- (void)updateLocalData:(NSMutableArray *)dataSource
{

    //删除本地SQL数据，再根据网络数据更新本地SQL数据.但是数据存入的数据模型已经发生改变
    [[DATManager sharedDATManager].detailModelDAT deleteAll];
    
    for (id model in dataSource)
    {
        [[DATManager sharedDATManager].detailModelDAT insert:[model detailStoreModel]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return  1;
    return self.dataSource.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return  section == 0 ? 0 : 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0)
    {
        static NSString * cellID = @"YYHNavigationCell";
        
        YYHNavigationCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [[YYHNavigationCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellID];
        }
        
        [cell addBlock:^(id sender)
        {//为按钮添加block
            self.hidesBottomBarWhenPushed = YES;
            UIButton *btn = (UIButton *)sender;
            YYHStoreViewController *store = [[YYHStoreViewController alloc] init];
            //根据title来判断属于哪个页面，从而向后台发起对应的请求
            store.title =_naviClassesByButtonTag[btn.tag];
            [self.navigationController pushViewController:store animated:YES];
        }];
        return cell;
    }
    else
    {//显示热门商家信息的cell
        static NSString *cellID = @"YYHStoreCell_id";
        
        YYHStoreCell * cell = (YYHStoreCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [YYHStoreCell instanceWithXib];//使用Xib建立的cell，使用方法都是不同的。
        }
        //使用模型来更新数据
         YYHDetailOfStoreFrame * b_frame = self.dataSource[indexPath.row];
         cell.detailOfStoreFrame = b_frame;
        return  cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 210 : 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.hidesBottomBarWhenPushed = YES;
    
    if (indexPath.section == 1)
    {
        //点击该row的cell，先从数据源从获取当前的数据，然后跳转到下一个商家详情界面。
        YYHDetailOfStoreViewController *detailController = [[YYHDetailOfStoreViewController alloc] init];
        //将使用model，首先数据模型与字典之间的转换。而不适用直接的方式赋值
        detailController.dataSource[0] = self.dataSource[indexPath.row];//获取选中商店的数据
        detailController.title = [detailController.dataSource[0] detailStoreModel].storeName;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YYHBuinessTitleHeadView * titleView = [[YYHBuinessTitleHeadView alloc] init];
    
    return titleView;
}


- (void)showAlertToUser
{
    
    NSString *str = [[UIDevice currentDevice] systemVersion];
    NSInteger verson = [str integerValue];
    if (verson < 9.0)
    {
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"无法连接到互联网" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [myAlertView show];
    }
    else
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法连接到互联网" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
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
    }
}

#pragma  加载数据
- (void)loadMoreData
{
    [self.footer endRefreshing];
}

- (void)loadNewData
{
    [self loadNetData];
    [self.header endRefreshing];
}




@end
