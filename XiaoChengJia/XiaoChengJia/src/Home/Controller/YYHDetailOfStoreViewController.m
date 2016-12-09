//
//  YYHDetailOfStoreViewController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHDetailOfStoreViewController.h"
#import "YYHCommentCell.h"
#import "YYHCommentViewController.h"
#import "MJRefresh.h"
#import "controllerCommon.h"
#import "YYHBusinessAPITool.h"
#import "YYHCommentFrame.h"
#import "YYHDetailOfStoreFrame.h"
#import "YYHDetailStoreCell.h"
#import "YYHShareViewController.h"
#import "DATManager.h"
#import "YYHReachability.h"

@interface YYHDetailOfStoreViewController ()

@property(nonatomic,weak)UIImageView * storeImageView;

@end

@implementation YYHDetailOfStoreViewController


- (void)viewWillAppear:(BOOL)animated
{
    //加载网络的评论数据,先加载0-15个评论
    YYHDetailOfStoreFrame *Storeframe = self.dataSource[0];
    YYHDetailOfStoreModel *model = Storeframe.detailStoreModel;
    NSString *commentClassNamePath = [NSString stringWithFormat:@"classes/%@",model.commentClassName];
    
    //发起连接
    if ([[YYHReachability sharedReach] hasNetWork])
    {
        [YYHBusinessAPITool getAllBusinessWithCommentModel:commentClassNamePath success:^(id result)
         {
             if (result)
             {
                 NSArray * array = result;
                 NSMutableArray * frameArray = [[NSMutableArray array] init];
                 for (id model in array)
                 {
                     YYHCommentFrame *frame = [[YYHCommentFrame alloc] init];
                     frame.commmentModel = model;
                     [frameArray addObject:frame];
                 }
                 //从底层的数据后去cell的属性
                 self.commentDataSource = frameArray;
                 [self.tableView reloadData];
             }
         }
                                                   failure:^(NSError *error)
         {
             [YYHBusinessAPITool getAllBusinessWithCommentModel:commentClassNamePath success:^(id result)
              {
                  if (result)
                  {
                      NSArray * array = result;
                      NSMutableArray * frameArray = [[NSMutableArray array] init];
                      for (id model in array){
                          YYHCommentFrame *frame = [[YYHCommentFrame alloc] init];
                          frame.commmentModel = model;
                          [frameArray addObject:frame];
                      }
                      //从底层的数据后去cell的属性
                      self.commentDataSource = frameArray;
                      [self.tableView reloadData];
                  }
              }
                                                        failure:^(NSError *error)
              {
                  YLog(@"error:%@",error);
              }];
         }];
        
    }
    else
    {
        [[YYHReachability sharedReach] showNotification];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.commentDataSource.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.section == 0)
        {
            static NSString * cellID = @"YYHDetailStoreCell_id";
                YYHDetailStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell)
            {
                cell = [[YYHDetailStoreCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                 reuseIdentifier:cellID];
            }
            YYHDetailOfStoreFrame *b_frame = self.dataSource[0];
            cell.detailStoreFrame = b_frame;
            self.storeImageView = cell.storeImage;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            [cell addBlock:^(id sender)
            {
                self.hidesBottomBarWhenPushed = YES;
                //进入评论界面
                YYHCommentViewController *commentController = [[YYHCommentViewController alloc] init];
                commentController.commentClassName = b_frame.detailStoreModel.commentClassName;
                [self.navigationController pushViewController:commentController animated:YES];
            }
            phoneBlock:^(id sender)
            {

                NSString * phoneHost = b_frame.detailStoreModel.phoneHost;
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"马上联系商家"
                                                                               message:nil
                                                                        preferredStyle:UIAlertControllerStyleActionSheet];
  
            [alert addAction:[UIAlertAction actionWithTitle:phoneHost
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * _Nonnull action)
            {
                NSString *ph = [NSString stringWithFormat:@"tel:/%@",phoneHost];
                NSURL *url = [NSURL URLWithString:ph];
                [[UIApplication sharedApplication] openURL:url];
 
            }]];
                
            [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];

            }
           collectionBlock:^(id sender)
            {
                //插入数据库
                YYHCollectionModelinDB * inDBModel = [[YYHCollectionModelinDB alloc] init];

                [self setIndBModelFromDetailStoreModel:inDBModel detailStoreModel:b_frame.detailStoreModel];

                if ([[DATManager sharedDATManager].collectionModelDAT isExistEntity:inDBModel ]) {

                    UIAlertView *collectOPAlertView = [[UIAlertView alloc] initWithTitle:@"已经收藏" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //这是弹出的一个与当前View无关的，所以显示不用showIn，直接show
                    [collectOPAlertView show];
                }
                else
                {
                    [[DATManager sharedDATManager].collectionModelDAT insert:inDBModel];
                    UIAlertView *collectOPAlertView = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    //这是弹出的一个与当前View无关的，所以显示不用showIn，直接show
                    [collectOPAlertView show];
                }
            }
            shareBlock:^(id sender)
            {
                //进入微博分享界面
                self.hidesBottomBarWhenPushed = YES;
                YYHShareViewController * shareViewController = [[YYHShareViewController alloc] init];
                shareViewController.imageToUpLoad = self.storeImageView;
                [self.navigationController pushViewController:shareViewController animated:YES];
                
            }];
            return cell;
        }
        else
        {
            //显示评论
            static NSString *cellID = @"YYHCommentCell_id";
            YYHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell)
            {
                cell = [[YYHCommentCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:cellID];
            }
            cell.commentFrame = self.commentDataSource[indexPath.row];
            
            return  cell;
        }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        YYHDetailOfStoreFrame *cellFrame = self.dataSource[0];
        return cellFrame.imageAndLabelHeight + 80 ;
    }
    else
    {
        YYHCommentFrame *cellFrame = self.commentDataSource[indexPath.row];
        return cellFrame.CellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 25;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? nil : @"评论";
}

- (void)setIndBModelFromDetailStoreModel:(YYHCollectionModelinDB *)inDBModel detailStoreModel:(YYHDetailOfStoreModel *)detailStoreModel
{
    inDBModel.storeName   = detailStoreModel.storeName;
    inDBModel.phoneHost   = detailStoreModel.phoneHost;
    inDBModel.instruction = detailStoreModel.instruction;
    inDBModel.address     = detailStoreModel.storeAddress;
    inDBModel.key         = detailStoreModel.key;
    inDBModel.keyToDB     = detailStoreModel.keyToDB;
}


@end
