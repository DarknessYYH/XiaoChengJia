//
//  YYHNavigationCell.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/9/2.
//  Copyright © 2016年 yyh2016. All rights reserved.
//


typedef void(^setIconBlock) (id sender);
@interface YYHNavigationCell : UITableViewCell

@property(nonatomic,copy)setIconBlock iconBlock;
@property(nonatomic,weak)UIImageView *cellBackGroundImageView;

- (UIButton *)addbtn:(NSString *)title icon:(NSString *)icon index:(int)index;
- (void)setDapaidang:(UIButton *)sender;
- (void)addAllButton;
- (void)addBlock:(setIconBlock)block;

@end
