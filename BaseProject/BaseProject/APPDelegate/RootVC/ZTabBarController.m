//
//  ZTabBarController.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/31.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZTabBarController.h"
#import "RDVTabBar.h"
#import "RDVTabBarItem.h"
#import "ZNavigationController.h"

@interface ZTabBarController ()

@end

@implementation ZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZViewController *Home = [[ZHomeViewController alloc]init];
    ZNavigationController *NAV1 = [[ZNavigationController alloc] initWithRootViewController:Home];
    
//    ZViewController *News = [[ZStoreViewController alloc]init];
//    ZNavigationController *NAV2 = [[ZNavigationController alloc] initWithRootViewController:News];
    
    ZViewController *Market = [[ZShoppingCartController alloc]init];
    ZNavigationController *NAV3 = [[ZNavigationController alloc] initWithRootViewController:Market];
    
    ZViewController *My = [[ZMyViewController alloc]init];
    ZNavigationController *NAV4 = [[ZNavigationController alloc] initWithRootViewController:My];
    
    self.viewControllers = @[NAV1,NAV3,NAV4];
    [self customizeTabBarForController:self];
    
    self.rdv_tabBarItem.y = iPhoneX? SCREEN_HEIGHT - IPHONEX_BOTTOM_H : self.rdv_tabBarItem.y;
//    self.tabBar.backgroundColor = white_color;
}
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    
    NSArray *tabBarItemImages = @[@"首页", @"购物车",@"我的"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *tabberItem in [[tabBarController tabBar] items]) {
        
        switch (index) {
            case 0:
                tabberItem.title = @"首页";
                break;
//            case 1:
//                tabberItem.title = @"商城";
//                break;
            case 1:
                tabberItem.title = @"购物车";
                break;
            case 2:
                tabberItem.title = @"我的";
                break;
            default:
                break;
        }
        
        NSDictionary *tabBarTitleUnselectedDic = @{NSForegroundColorAttributeName:MAIN_TEXT_COLOR,NSFontAttributeName:[UIFont systemFontOfSize:12]};
        NSDictionary *tabBarTitleSelectedDic = @{NSForegroundColorAttributeName:MAIN_COLOR,NSFontAttributeName:[UIFont systemFontOfSize:12]};
        //修改tabberItem的title颜色
        tabberItem.selectedTitleAttributes = tabBarTitleSelectedDic;
        tabberItem.unselectedTitleAttributes = tabBarTitleUnselectedDic;
        tabberItem.backgroundColor = white_color;
        
        UIImage *selectedimage = [UIImage imageNamed:string([tabBarItemImages objectAtIndex:index], @"-亮")];
        UIImage *unselectedimage = [UIImage imageNamed:string([tabBarItemImages objectAtIndex:index], @"-暗")];
        //设置tabberItem的选中和未选中图片
        [tabberItem setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

@end
