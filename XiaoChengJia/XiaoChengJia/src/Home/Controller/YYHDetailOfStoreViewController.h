//
//  YYHDetailOfStoreViewController.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/7.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseViewController.h"
#import "YYHDetailOfStoreModel.h"
#import "YYHCollectionModelinDB.h"

@interface YYHDetailOfStoreViewController : YYHBaseViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)YYHDetailOfStoreModel *detailOfModel;
@property(nonatomic,strong)YYHCollectionModelinDB *inDBModel;
@property(nonatomic,strong)NSMutableArray *commentDataSource;

@end
