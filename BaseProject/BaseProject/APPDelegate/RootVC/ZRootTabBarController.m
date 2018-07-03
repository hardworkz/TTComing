//
//  ZRootTabBarController.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/2.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZRootTabBarController.h"

@interface ZRootTabBarController ()

@end

@implementation ZRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ZViewController *Home = [[ZHomeViewController alloc]init];
    [self setTitle:@"首页" image:@"首页" viewController:Home];
    ZNavigationController *NAV1 = [[ZNavigationController alloc] initWithRootViewController:Home];
    
    //    ZViewController *News = [[ZStoreViewController alloc]init];
//    [self setTitle:@"首页" image:@"首页" viewController:Home];
    //    ZNavigationController *NAV2 = [[ZNavigationController alloc] initWithRootViewController:News];
    
    ZViewController *ShoppingCart = [[ZShoppingCartController alloc]init];
    [self setTitle:@"购物车" image:@"购物车" viewController:ShoppingCart];
    ZNavigationController *NAV3 = [[ZNavigationController alloc] initWithRootViewController:ShoppingCart];
    
    ZViewController *My = [[ZMyViewController alloc]init];
    [self setTitle:@"我的" image:@"我的" viewController:My];
    ZNavigationController *NAV4 = [[ZNavigationController alloc] initWithRootViewController:My];
    
    self.itemTitleFont          = [UIFont boldSystemFontOfSize:13];
    self.itemTitleColor         = MAIN_TEXT_COLOR;
    self.selectedItemTitleColor = MAIN_COLOR;
    
    self.viewControllers        = @[NAV1, NAV3, NAV4];
}

/**
 设置tabbar控制器的属性
 
 @param title 标题
 @param image 图片
 @param viewController 控制器
 */
- (void)setTitle:(NSString *)title image:(NSString *)image viewController:(UIViewController *)viewController
{
    if ([title isEqualToString:@"我的"]) {
        viewController.tabBarItem.badgeValue = @"1";
    }
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-暗",image]];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@-亮",image]];
}


@end
