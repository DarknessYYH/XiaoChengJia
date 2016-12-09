//
//  YYHMainViewController.m
//  XiaoChengJia
//
//  Created by yyh2016 on 16/8/27.
//  Copyright © 2016年 yyh2016. All rights reserved.
//

#import "YYHMainViewController.h"
#import "YYHBuinessController.h"
#import "YYHCollectionController.h"
#import "YYHMineController.h"

@implementation YYHMainViewController

- (void)viewDidLoad
{
    [self setupAllChildViewControllers];

    [super viewDidLoad];
}


- (void)setupAllChildViewControllers
{
    YYHBuinessController *buiness = [[YYHBuinessController alloc] init];
    [self setupChildViewController:buiness
                             title:@"首页"
                         imageName:@"icon_tabbar_01"
                   selectImageName:@"icon_tabbar_01_h"];
    
    YYHCollectionController * collection = [[YYHCollectionController alloc] init];
    [self setupChildViewController:collection
                             title:@"收藏"
                         imageName:@"icon_tabbar_02"
                   selectImageName:@"icon_tabbar_02_h"];
    
    YYHMineController * mine = [[YYHMineController alloc] init];
    [self setupChildViewController:mine
                             title:@"个人"
                         imageName:@"icon_tabbar_03"
                   selectImageName:@"icon_tabbar_03_h"];
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    //如果不设置，默认是自动生成黑色背景，当右滑拖动返回根视图时，导航栏右边有黑色阴影显示
    nav.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:nav];
}



@end
