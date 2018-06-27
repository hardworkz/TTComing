//
//  ZMyOrderController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyOrderController.h"

@interface ZMyOrderController ()

@property (nonatomic, strong) NSArray *titleData;

@end

@implementation ZMyOrderController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarView];
    
    [self setFd_interactivePopDisabled:YES];
    
}
- (void)setNavigationBarView {
    
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavHeight)];
    navigationBarView.backgroundColor = white_color;
    [self.view addSubview:navigationBarView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, kStatusBarHeight, kTopBarHeight, kTopBarHeight);
    leftBtn.imageView.contentMode = UIViewContentModeCenter;
    [leftBtn setImage:[UIImage imageNamed:@"icon_back_black"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [navigationBarView addSubview:leftBtn];
    
    UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(kTopBarHeight, kStatusBarHeight, SCREEN_WIDTH - 2 * kTopBarHeight, kTopBarHeight)];
    topLab.textColor = [UIColor blackColor];
    topLab.font = [UIFont boldSystemFontOfSize:17.0f];
    topLab.text = @"全部订单";
    topLab.textAlignment = NSTextAlignmentCenter;
    [navigationBarView addSubview:topLab];
    
    UIView *seperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight - 0.5, SCREEN_WIDTH, 0.5)];
    [seperatorLine setBackgroundColor:lightGray_color];
    [navigationBarView addSubview:seperatorLine];
}
#pragma mark 标题数组
- (NSArray *)titleData {
    if (!_titleData) {
        _titleData = @[@"所有", @"待付款", @"待收货",@"待留言"];
    }
    return _titleData;
}
#pragma mark 初始化代码
- (instancetype)init {
    if (self = [super init]) {

        self.titleColorNormal = MAIN_TEXT_COLOR;
        self.titleColorSelected = MAIN_COLOR;
        self.titleSizeNormal = 15;
        self.titleSizeSelected = 17;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuItemWidth = [UIScreen mainScreen].bounds.size.width / self.titleData.count;
    }
    return self;
}
#pragma mark - action
- (void)backClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Datasource & Delegate

#pragma mark 返回子页面的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleData.count;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView
{
    return CGRectMake(0, kNavHeight, SCREEN_WIDTH, 50);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView
{
    return CGRectMake(0, 50 + kNavHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - kNavHeight);
}
#pragma mark 返回某个index对应的页面
- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {


    switch (index) {
        case 0:{

            ZMyAllOrderViewController   *vcClass = [[ZMyAllOrderViewController alloc] init];
            vcClass.title = @"1";

            return vcClass;
        }

            break;
        case 1:{

            ZMyWaitPayViewController *vcClass = [ZMyWaitPayViewController new];
            vcClass.title = @"2";
            return vcClass;

        }
            break;
        case 2:{

            ZMyWaitReceiveViewController *vcClass = [ZMyWaitReceiveViewController new];
            vcClass.title = @"3";
            return vcClass;

        }
            break;

        default:{

            ZMyWaitCommentViewController *vcClass = [ZMyWaitCommentViewController new];
            vcClass.title = @"4";
            return vcClass;

        }

            break;
    }


}

#pragma mark 返回index对应的标题
- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {

    return self.titleData[index];
}

@end
