//
//  YYHUserImageCell.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/10/18.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHUserImageCell.h"
#import "WBaccountTool.h"
#import "UIImageView+WebCache.h"
#import "NSString+JJ.h"
#import "UIImage+MJ.h"
#import "YYHLuoBoView.h"

#define NICKNAME_FONT_SIZE 22.0
#define DESCRIPTION_FONT_SIZE 18.0
#define HEADIMAGE_WITH   80
#define GENDERIMAGE_WITH 20

@implementation YYHUserImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupCell];
    }
    return self;
}

- (void)setupCell
{
    UIImageView * backImageView = [[UIImageView alloc] init];
    backImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    backImageView.image = [UIImage imageNamed:@"userInfoImage"];

    NSString *image1 = @"zeng1";
    NSString *image2 = @"zeng2";
    NSString *image3 = @"zeng3";
    NSString *image4 = @"zeng4";
    NSString *image5 = @"zeng5";
    NSArray *imgArr = [NSArray arrayWithObjects:image1,image2,image3,image4,image5, nil];
    YYHLuoBoView *lunboView = [YYHLuoBoView bannerViewWithLocationImagesArr:imgArr frame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    lunboView.timeInterval = 2.1;
    lunboView.pageIndicatorTintColor = [UIColor whiteColor];
    lunboView.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    [self.contentView addSubview:lunboView];
    if ([WBaccountTool account])
    {
    //设置头像
    UIImageView * headImageView = [[UIImageView alloc] init];
    headImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - HEADIMAGE_WITH / 2, 10, HEADIMAGE_WITH, HEADIMAGE_WITH);
    //创建圆角头像
    headImageView.layer.cornerRadius = headImageView.frame.size.width / 2;
    headImageView.clipsToBounds = YES;
    NSURL * url = [NSURL URLWithString:[WBaccountTool account].profile_image_url];
    UIImage * image = [self readImageDataFromFile];
    if (image)
    {
        //从归档中直接读取数据
        headImageView.image = image;
    }
    else
    {
        //如果本地没有存储直接发起网路请求
        SDWebImageManager * manager = [SDWebImageManager sharedManager];
        [manager downloadImageWithURL:url
                              options:0
                             progress:^(NSInteger receivedSize, NSInteger expectedSize)
        {
            
        }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
        {
            headImageView.image = image;
            [self writeImageDataToFile:headImageView.image];
        }];
    }
    
    [self.contentView addSubview:headImageView];
    //设置昵称
    NSString * nickName = [WBaccountTool account].name;
    CGSize nickNameSize = [nickName sizeWithFont:[UIFont systemFontOfSize:NICKNAME_FONT_SIZE] maxSize:CGSizeMake(SCREEN_WIDTH - 100, MAXFLOAT)];
    UILabel * nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.frame = CGRectMake(50, headImageView.frame.origin.y + 80, SCREEN_WIDTH - 100, nickNameSize.height);
    nickNameLabel.numberOfLines = 0;
    nickNameLabel.text = nickName;
    nickNameLabel.font = [UIFont systemFontOfSize:NICKNAME_FONT_SIZE];
    nickNameLabel.textAlignment = NSTextAlignmentCenter;
    [nickNameLabel setTextColor:[UIColor whiteColor]];
    [self.contentView addSubview:nickNameLabel];
    //设置性别
    
    UIImageView * genderImageView = [[UIImageView alloc] init];
    genderImageView.frame = CGRectMake(SCREEN_WIDTH / 2 - GENDERIMAGE_WITH / 2, nickNameLabel.frame.origin.y + nickNameSize.height + 5, GENDERIMAGE_WITH , GENDERIMAGE_WITH);
    if ([[WBaccountTool account].gender isEqualToString:@"m"])
    {
        genderImageView.image = [UIImage imageNamed:@"male"];
    }
    else
    {
        genderImageView.image = [UIImage imageNamed:@"female"];
    }
    [self.contentView addSubview:genderImageView];
//    //设置个性签名
//    NSString * description = [WBaccountTool account].idescription;
//    CGSize descriptionSize = [description sizeWithFont:[UIFont systemFontOfSize:DESCRIPTION_FONT_SIZE] maxSize:CGSizeMake(SCREEN_WIDTH - 100, MAXFLOAT)];
//    UILabel * descriptionLabel = [[UILabel alloc] init];
//    descriptionLabel.frame = CGRectMake(50, genderImageView.frame.origin.y + GENDERIMAGE_WITH, descriptionSize.width, descriptionSize.height);
//    descriptionLabel.numberOfLines = 0;
//    descriptionLabel.text = description;
//    descriptionLabel.font = [UIFont systemFontOfSize:DESCRIPTION_FONT_SIZE];
//    descriptionLabel.textAlignment = NSTextAlignmentCenter;
//    [descriptionLabel setTextColor:[UIColor whiteColor]];
//    [self.contentView addSubview:descriptionLabel];
    }
}

- (void)writeImageDataToFile:(UIImage *)image
{
    NSData * imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"headImage"];
}

- (UIImage *)readImageDataFromFile
{
    NSData * imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
    UIImage * image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
    
    return image;
}

@end
