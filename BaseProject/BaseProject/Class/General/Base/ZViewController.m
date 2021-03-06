//
//  ZViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewController.h"
#import "JZNavigationExtension.h"

@interface ZViewController ()

@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL changeStatusBarAnimated;

@end

@implementation ZViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    ZViewController *viewController = [super allocWithZone:zone];
    
    @weakify(viewController)
    
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController z_addSubviews];
        [viewController z_bindViewModel];
    }];
    
    [[viewController rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        
        @strongify(viewController)
        [viewController z_layoutNavigation];
        [viewController z_getNewData];
    }];
    
    return viewController;
}

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.keyboardDistanceFromTextField = 0;
    
    [self setIsExtendLayout:NO];
    
    [self z_removeNavgationBarLine];
    
    [self layoutNavigationBar:ImageNamed(@"navigationBarBG@2x.png") titleColor:black_color titleFont:YC_YAHEI_FONT(18) leftBarButtonItem:nil rightBarButtonItem:nil];
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.view.backgroundColor = white_color;
    
    self.navigationItem.titleView = [UIView new];
}
#pragma mark - system

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if (self.statusBarStyle) {
        
        return self.statusBarStyle;
    } else {
        
        return UIStatusBarStyleDefault;
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return self.statusBarHidden;
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)z_removeNavgationBarLine {
    
    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)changeStatusBarStyle:(UIStatusBarStyle)statusBarStyle
             statusBarHidden:(BOOL)statusBarHidden
     changeStatusBarAnimated:(BOOL)animated {
    
    self.statusBarStyle=statusBarStyle;
    self.statusBarHidden=statusBarHidden;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    else{
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)hideNavigationBar:(BOOL)isHide
                 animated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.navigationController.navigationBarHidden=isHide;
        }];
    }
    else{
        self.navigationController.navigationBarHidden=isHide;
    }
    //处理手势返回时系统导航栏突然显示隐藏，一闪而过的问题
    if (isHide) {
        self.jz_navigationBarBackgroundAlpha = 0;
    }else{
        self.jz_navigationBarBackgroundAlpha = 1;
    }
}

/**
 设置返回手势
 */
- (void)rightSwipeWithView:(UIView *)view {
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backClicked)];
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [view addGestureRecognizer:rightSwipe];
}
- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    if (titleColor&&titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    }
    else if (titleFont) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    }
    else if (titleColor){
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    if (leftItem) {
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    if (rightItem) {
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}
- (void)customNavigationBarWithTitle:(NSString *)title bgColor:(UIColor *)color backBtn:(NSString *)string sel:(SEL)backSel rightBtn:(NSString *)rightString sel:(SEL)rightAction devider:(BOOL)show
{
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavHeight)];
    navigationBarView.backgroundColor = color;
    [self.view addSubview:navigationBarView];
    
    if (string) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, kStatusBarHeight, kTopBarHeight, kTopBarHeight);
        //    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 10)];
        leftBtn.imageView.contentMode = UIViewContentModeCenter;
        [leftBtn setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:backSel?backSel:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
        [navigationBarView addSubview:leftBtn];
    }
    
    if (title) {
        UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(kTopBarHeight, kStatusBarHeight, SCREEN_WIDTH - 2 * kTopBarHeight, kTopBarHeight)];
        topLab.textColor = [UIColor blackColor];
        topLab.font = [UIFont boldSystemFontOfSize:17.0f];
        topLab.text = title;
        topLab.textAlignment = NSTextAlignmentCenter;
        [navigationBarView addSubview:topLab];
    }
    
    if (rightString) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH - kTopBarHeight, kStatusBarHeight, kTopBarHeight, kTopBarHeight);
        rightBtn.imageView.contentMode = UIViewContentModeCenter;
        [rightBtn setImage:[UIImage imageNamed:rightString] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        [navigationBarView addSubview:rightBtn];
    }
    
    if (show) {
        UIView *seperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight - 0.5, SCREEN_WIDTH, 0.5)];
        [seperatorLine setBackgroundColor:MAIN_LINE_COLOR];
        [navigationBarView addSubview:seperatorLine];
    }
}
- (void)customNavigationBarWithTitle:(NSString *)title bgColor:(UIColor *)color backBtn:(NSString *)string sel:(SEL)backSel rightBtnTitle:(NSString *)rightTitle sel:(SEL)rightAction devider:(BOOL)show
{
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavHeight)];
    navigationBarView.backgroundColor = color;
    [self.view addSubview:navigationBarView];
    
    if (string) {
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0, kStatusBarHeight, kTopBarHeight, kTopBarHeight);
        //    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 10)];
        leftBtn.imageView.contentMode = UIViewContentModeCenter;
        [leftBtn setImage:[UIImage imageNamed:string] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:backSel?backSel:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
        [navigationBarView addSubview:leftBtn];
    }
    
    if (title) {
        UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(kTopBarHeight, kStatusBarHeight, SCREEN_WIDTH - 2 * kTopBarHeight, kTopBarHeight)];
        topLab.textColor = [UIColor blackColor];
        topLab.font = [UIFont boldSystemFontOfSize:17.0f];
        topLab.text = title;
        topLab.textAlignment = NSTextAlignmentCenter;
        [navigationBarView addSubview:topLab];
    }
    
    if (rightTitle) {
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(SCREEN_WIDTH - kTopBarHeight - MARGIN_10, kStatusBarHeight, kTopBarHeight, kTopBarHeight);
        rightBtn.imageView.contentMode = UIViewContentModeCenter;
        [rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [rightBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        rightBtn.titleLabel.font = SYSTEM_FONT(15);
        [rightBtn addTarget:self action:rightAction forControlEvents:UIControlEventTouchUpInside];
        [navigationBarView addSubview:rightBtn];
    }
    
    if (show) {
        UIView *seperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, kNavHeight - 0.5, SCREEN_WIDTH, 0.5)];
        [seperatorLine setBackgroundColor:MAIN_LINE_COLOR];
        [navigationBarView addSubview:seperatorLine];
    }
}
- (void)backClicked{
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)firstColor:(UIColor*)firstColor secondColor:(UIColor*)secondColor
{
    if (CGColorEqualToColor(firstColor.CGColor, secondColor.CGColor))
    {
        ZLog(@"颜色相同");
        return YES;
    }
    else
    {
        ZLog(@"颜色不同");
        return NO;
    }
}
#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait;
}

#pragma mark - RAC
/**
 *  添加控件
 */
- (void)z_addSubviews {}

/**
 *  绑定
 */
- (void)z_bindViewModel {}

/**
 *  设置navation
 */
- (void)z_layoutNavigation {}

/**
 *  初次获取数据
 */
- (void)z_getNewData {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
