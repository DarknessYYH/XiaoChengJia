//
//  YYHCollectionController.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHBaseViewController.h"

@interface YYHCollectionController : YYHBaseViewController <UIActionSheetDelegate>

@property(nonatomic,assign,readonly)CGFloat cellHeight;
@property(nonatomic,assign,readonly)CGRect  instructionFrame;
@property(nonatomic,assign,readonly)CGRect  addressFrame;

@end
