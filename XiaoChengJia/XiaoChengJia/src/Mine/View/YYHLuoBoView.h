//
//  YYHLuoBoView.h
//  XiaoChengJia
//
//  Created by yyh2016 on 16/11/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYHLunBoCollectionViewCell.h"

@interface YYHLuoBoView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,assign) CGFloat timeInterval;
@property(nonatomic,strong) NSMutableArray *locationImageArr;
@property(nonatomic,strong) UIColor *pageIndicatorTintColor;
@property(nonatomic,strong) UIColor *currentPageIndicatorTintColor;

+(instancetype)bannerViewWithLocationImagesArr:(NSArray *)locationImgArr frame:(CGRect)frame;

@end
