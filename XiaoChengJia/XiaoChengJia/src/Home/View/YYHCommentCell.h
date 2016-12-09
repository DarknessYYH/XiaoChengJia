//
//  YYHCommentCell.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/21.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHCommentFrame.h"

@interface YYHCommentCell : UITableViewCell

@property(nonatomic,strong)YYHCommentFrame *commentFrame;
@property(nonatomic,strong)UILabel *commentLabel;
@property(nonatomic,strong)UILabel *commentPoster;
@property(nonatomic,strong)UILabel *commentTime;
@property(nonatomic,assign)CGFloat commentCellHeight;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
