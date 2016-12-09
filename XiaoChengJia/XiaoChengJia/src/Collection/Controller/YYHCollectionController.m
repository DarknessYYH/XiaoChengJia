//
//  YYHCollectionController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHCollectionController.h"
#import "YYHCollectionCell.h"
#import "YYHCollectionFrame.h"
#import "YYHHeadView.h"
#import "YYHtitleHeadView.h"
#import "ImageViewTransform.h"
#import "HttpTool.h"
#import "MBProgressHUD+MJ.h"
#import "DATManager.h"

@interface YYHCollectionController ()

@property(nonatomic,strong)NSMutableDictionary *status;
@property(nonatomic,strong)NSArray *naviClassesByButtonTag;
@property(nonatomic,strong)NSArray *keyForStore;
@property(nonatomic,strong)NSMutableArray *allDataSource;

@end

static int lastSection;

@implementation YYHCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = [[NSMutableDictionary alloc] init];
    _naviClassesByButtonTag = @[@"宵夜外卖",@"出行包车",@"休闲娱乐",@"餐饮美食",
                                @"快递物流",@"服装相关",@"家居装修",@"驾校学车",
                                @"横幅海报",@"蛋糕订制",@"周边住宿",@"其他"
                                ];
    _keyForStore = @[@"xiaoyewaimai",@"chuxingbaoche",@"xiuxianyule",@"canyinmeishi",
                     @"kuaidiwuliu",@"fushixiangguan",@"jiajuzhuangxiu",@"jiachexueche",
                     @"hengfuhaibao",@"dangaodingzhi",@"jiudianlvyou",@"other"];
}

- (void)viewWillAppear:(BOOL)animated
{

    [self updateAllDataSource];
    lastSection = 13;//fix 重新进入时，图标再次旋转的bug
}

- (void)updateAllDataSource
{
    //同样先清除全部数据
    [self.dataSource removeAllObjects];
    for (int i = 0;i < 12;i++)
    {
        NSMutableArray *classStore = [[NSMutableArray alloc] init];
        NSArray *collectionModel = [[NSMutableArray alloc] init];
        collectionModel = [CollectionModelDAT queryCollectionModelWithWhere:@"keyToDB"
                                                                   property:_keyForStore[i]];

        for (id model in collectionModel)
        {
            YYHCollectionFrame *frameModel = [[YYHCollectionFrame alloc] init];
            frameModel.inDBModel = model;
            [classStore addObject:frameModel];
        }
        [self.dataSource addObject:classStore];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int result = [self.status[@(section)] intValue];
    if (result == 0)
    {
        return 0;
    }
    else
    {
        return [self.dataSource[section] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYHCollectionFrame * frame = self.dataSource[indexPath.section][indexPath.row];
    return  frame.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"YYHCollectiionCell_id";
    YYHCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell =  [[YYHCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellID];
    }
    cell.storeFrame = self.dataSource[indexPath.section][indexPath.row];
    YYHCollectionFrame * b_frame = self.dataSource[indexPath.section][indexPath.row];
    [cell addBlockForPhoneButton:^(id sender)
    {

        NSString * phoneHost = b_frame.inDBModel.phoneHost;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"马上联系商家" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alert addAction:[UIAlertAction actionWithTitle:phoneHost style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
        {
            NSString *ph = [NSString stringWithFormat:@"tel:/%@",phoneHost];
            NSURL *url = [NSURL URLWithString:ph];
            [[UIApplication sharedApplication] openURL:url];
  
        }]];
   
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    YYHtitleHeadView * titleHeadView = [[YYHtitleHeadView alloc] init];
    titleHeadView.headerViewButton.tag = section;
    [titleHeadView.headerViewButton setTitle:_naviClassesByButtonTag[section]
                                    forState:UIControlStateNormal];
    //必须设置titleview的tag，该view对应一个手势，那么手势上面的view就是这个imageview，从而得到这个tag,实现参数的传递
    titleHeadView.tag = section;
    UITapGestureRecognizer * imageViewGuster = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadView:)];
    [titleHeadView addGestureRecognizer:imageViewGuster];
    int result = [self.status[@(section)] intValue];
    //查询状态记录,只更改被触发的headView
    if (lastSection == section)
    {
        if (result == 0){// 1 ---> 0
            [ImageViewTransform imageViewRotateAnimation:titleHeadView.headerViewButton.imageView
                                                    from:@(M_PI_2)
                                                      to:@(0.0)
                                                duration:0.2];
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformIdentity;

        }
        else
        {// 0 ---> 1
            [ImageViewTransform imageViewRotateAnimation:titleHeadView.headerViewButton.imageView
                                                     from:@(0.0)
                                                      to:@(M_PI_2)
                                                duration:0.2];
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }
    else
    {
        if (result == 0)
        {// 1 ---> 0
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformIdentity;
        }
        else
        {// 0 ---> 1
            titleHeadView.headerViewButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
    }
    return titleHeadView;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //先读取当前的数据，然后根据事件操作数据。
    //之前出现的问题就是没有理解好，进入事件后再读取数据源的数据已经太迟了。
    YYHCollectionFrame  * collectionFrame = self.dataSource[indexPath.section][indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.dataSource[indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [[DATManager sharedDATManager].collectionModelDAT deleteCollectionModel:@"storeName"
                                             property:collectionFrame.inDBModel.storeName];
    }
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"移除";
}
 
//通过手势对应的imageview的ID来实现参数传递
//后面将会根据不同的key来分发数据到数据源当中
- (void)clickHeadView:(UITapGestureRecognizer *)guster
{
    int section = (int)guster.view.tag;
    lastSection = section;
    int result = [self.status[@(section)] intValue];
    if (result == 0)
    {
        [self.status setObject:@1 forKey:@(section)];
    }
    else
    {
        [self.status setObject:@0 forKey:@(section)];
    }
    [self.tableView reloadData];
}

@end
