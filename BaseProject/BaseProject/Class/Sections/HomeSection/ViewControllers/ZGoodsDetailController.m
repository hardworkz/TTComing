//
//  ZGoodsDetailController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/19.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailController.h"
#import "ZGoodsDetailView.h"
#import "ZGoodsDetailViewModel.h"
#import "ZSettleCenterAlertView.h"
#import "ZGoodsDetailAlertViewModel.h"

@interface ZGoodsDetailController ()

@property (nonatomic, strong) ZGoodsDetailView *mainView;

@property (nonatomic, strong) ZGoodsDetailViewModel *viewModel;

@property (nonatomic, strong) ZSettleCenterAlertView *alertView;

@property (nonatomic, strong) ZGoodsDetailAlertViewModel *alertViewModel;

@property (nonatomic, strong) ZView *tooBarView;

@property (nonatomic, strong) CustomBottomAlertContentView *alert;

@end

@implementation ZGoodsDetailController
#pragma mark - system
- (void)updateViewConstraints {
    
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(kNavHeight, 0, kTabBarHeight, 0));
    }];
    [super updateViewConstraints];
}

#pragma mark - private
- (void)z_addSubviews {
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.tooBarView];
}

- (void)z_bindViewModel {
    @weakify(self)
    [self.viewModel.alertClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //弹窗
        self.alert = [[CustomBottomAlertContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.6)];
        self.alert.backgroundColor = [UIColor whiteColor];
        self.alert.alertHeight = SCREEN_HEIGHT * 0.6;
        self.alert.customView = self.alertView;
        [self.alert show];
    }];
    [self.viewModel.moreClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //跳转评论更多界面
        [self.navigationController pushViewController:[[ZCommentViewController alloc] init] animated:YES];
    }];
}
- (void)z_layoutNavigation {
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"拦精灵" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:YES];
}
#pragma mark - layzLoad
- (ZGoodsDetailView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZGoodsDetailView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZGoodsDetailViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZGoodsDetailViewModel alloc] init];
    }
    
    return _viewModel;
}
- (ZSettleCenterAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[ZSettleCenterAlertView alloc] initWithViewModel:self.alertViewModel];
    }
    return _alertView;
}
- (ZGoodsDetailAlertViewModel *)alertViewModel {
    
    if (!_alertViewModel) {
        
        _alertViewModel = [[ZGoodsDetailAlertViewModel alloc] init];
    }
    
    return _alertViewModel;
}
- (ZView *)tooBarView
{
    if (!_tooBarView) {
        _tooBarView = [[ZView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - kTabBarHeight, SCREEN_WIDTH, kTabBarHeight)];
        _tooBarView.backgroundColor = white_color;
        
        MCButton *serviceButton = [[MCButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
        serviceButton.buttonStyle = imageTop;
        serviceButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [serviceButton setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [serviceButton setTitle:@"客服" forState:UIControlStateNormal];
        [serviceButton setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
        [_tooBarView addSubview:serviceButton];
        
        MCButton *collectionButton = [[MCButton alloc] initWithFrame:CGRectMake(49, 0, 49, 49)];
        collectionButton.buttonStyle = imageTop;
        collectionButton.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [collectionButton setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [collectionButton setTitle:@"购物车" forState:UIControlStateNormal];
        [collectionButton setImage:[UIImage imageNamed:@"商品详情购物车"] forState:UIControlStateNormal];
        [_tooBarView addSubview:collectionButton];
        
        CGFloat buttonH = 36;
        
        UIButton *buyNowButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - (SCREEN_WIDTH * 2 / 3)*0.5, 7, (SCREEN_WIDTH * 2 / 3)*0.5, buttonH)];
        buyNowButton.titleLabel.font = FONT(15.0);
        [buyNowButton setBackgroundColor:MAIN_COLOR];
        [buyNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_tooBarView addSubview:buyNowButton];
        WS(weakSelf)
        [[buyNowButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZSettleCenterController *settleCenterVC = [[ZSettleCenterController alloc] init];
            [weakSelf.navigationController pushViewController:settleCenterVC animated:YES];
        }];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:buyNowButton.bounds      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(buttonH * 0.5, buttonH * 0.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = buyNowButton.bounds;
        maskLayer.path = maskPath.CGPath;
        buyNowButton.layer.mask = maskLayer;
        
        UIButton *addShoppingCartButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - (SCREEN_WIDTH * 2 / 3), 7, (SCREEN_WIDTH * 2 / 3)*0.5, buttonH)];
        addShoppingCartButton.titleLabel.font = FONT(15.0);
        [addShoppingCartButton setBackgroundColor:MAIN_TEXT_COLOR];
        [addShoppingCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addShoppingCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addShoppingCartButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_tooBarView addSubview:addShoppingCartButton];
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:addShoppingCartButton.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft    cornerRadii:CGSizeMake(buttonH * 0.5, buttonH * 0.5)];
        CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.frame = buyNowButton.bounds;
        maskLayer2.path = maskPath2.CGPath;
        addShoppingCartButton.layer.mask = maskLayer2;
    }
    return _tooBarView;
}
@end
