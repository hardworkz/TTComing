//
//  AppDelegate+AppInitializeWindows.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/29.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "AppDelegate+AppInitializeWindows.h"
#import "ZRootTabBarController.h"

@implementation AppDelegate (AppInitializeWindows)
- (void)setAppWindows
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
- (void)setRootViewController
{
    //获取当前应用版本和上一个应用版本进行比较，如果不相同则为进行过更新
    UserLoginManager *manager = [UserLoginManager shareUserLoginManager];
    [manager readAuthorizeData];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    if ([manager.identity.lastSoftVersion isEqualToString:currentVersion])
    {
        //不是第一次安装
        if ([manager.user.userNo intValue] != 0) {
            //设置主控制器
            [self setTabbarController];
        }else{
            //设置登录控制器
            [self setLoginController];
        }
    }
    else
    {
        //新特性界面展示
        UIViewController *emptyView = [[UIViewController alloc] init];
        self.window.rootViewController = emptyView;
        [self createLoadingScrollView];
        
        //保存当前版本号
        manager.identity.lastSoftVersion = currentVersion;
        [manager saveAuthorizeData];
    }
}
- (void)setTabbarController
{
    [[[UIApplication sharedApplication].delegate window] setRootViewController:[[ZRootTabBarController alloc] init]/*需要切换的控制器*/];
    
    //切换根控制器动画方案二
    CATransition *animation = [CATransition animation];
    
    [animation setDuration:0.6];//设置动画时间
    
    animation.type = kCATransitionFade;//设置动画类型
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
}
- (void)setLoginController
{
    [[[UIApplication sharedApplication].delegate window] setRootViewController:[[ZLoginViewController alloc] init]/*需要切换的控制器*/];
    
    //切换根控制器动画方案二
    CATransition *animation = [CATransition animation];
    
    [animation setDuration:0.6];//设置动画时间
    
    animation.type = kCATransitionFade;//设置动画类型
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:@"animation"];
}
- (void)setRoot
{
    [[[UIApplication sharedApplication].delegate window] setRootViewController:[[ZLoginViewController alloc] init]/*需要切换的控制器*/];
}
#pragma mark - 引导页
/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView
{
    //引导页
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    for (NSInteger i = 0; i<arr.count; i++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
        if (i == arr.count - 1)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((self.window.frame.size.width/2)-50, SCREEN_WIDTH - 110, 100, 40);
            btn.backgroundColor = white_color;
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = white_color.CGColor;
        }
    }
    sc.contentSize = CGSizeMake(SCREEN_WIDTH * arr.count, self.window.frame.size.height);
}
- (void)goToMain
{
    [self setRoot];
}
@end
