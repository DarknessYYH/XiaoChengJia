//
//  YYHCommentViewController.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHCommentModel.h"
#import "YYHSendComment.h"

@interface YYHCommentViewController : UIViewController <UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,weak) YYHSendComment *commentTextview;
@property(nonatomic,strong) NSString *commentClassName;

@end
