//
//  ZSettleCenterController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterController.h"
#import "ZSettleCenterView.h"
#import "ZSettleCenterViewModel.h"
#import "ZSettleCenterAlertView.h"
#import "ZSettleCenterAlertViewModel.h"

@interface ZSettleCenterController ()

@property (nonatomic, strong) ZSettleCenterView *mainView;

@property (nonatomic, strong) ZSettleCenterAlertView *alertView;

@property (nonatomic, strong) ZSettleCenterViewModel *viewModel;

@property (nonatomic, strong) ZSettleCenterAlertViewModel *alertViewModel;

@property (nonatomic, strong) ZView *toobarView;

@property (nonatomic, strong) CustomBottomAlertContentView *alert;

@end

@implementation ZSettleCenterController

#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(kNavHeight, 0, kTabBarHeight, 0));
    }];
    [self.toobarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.height.equalTo(kTabBarHeight);
    }];
    [super updateViewConstraints];
}
#pragma mark - private
- (void)z_addSubviews
{
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.toobarView];
    
}
- (void)z_bindViewModel
{
    @weakify(self)
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        //点击cell操作
        if ([x isEqualToString:@"alert"]) {
            //弹窗
            self.alert = [[CustomBottomAlertContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.6)];
            self.alert.backgroundColor = [UIColor whiteColor];
            self.alert.alertHeight = SCREEN_HEIGHT * 0.6;
            self.alert.customView = self.alertView;
            [self.alert show];
        }
    }];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"结算订单" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
#pragma mark - lazyload
- (ZSettleCenterView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZSettleCenterView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZSettleCenterAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[ZSettleCenterAlertView alloc] initWithViewModel:self.alertViewModel];
    }
    return _alertView;
}

- (ZSettleCenterViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZSettleCenterViewModel alloc] init];
    }
    
    return _viewModel;
}
- (ZSettleCenterAlertViewModel *)alertViewModel {
    
    if (!_alertViewModel) {
        
        _alertViewModel = [[ZSettleCenterAlertViewModel alloc] init];
    }
    
    return _alertViewModel;
}
- (ZView *)toobarView
{
    if (!_toobarView) {
        _toobarView = [[ZView alloc] init];
        
        UILabel *settleLabel = [[UILabel alloc] init];
        settleLabel.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        settleLabel.font = SYSTEM_FONT(15);
        settleLabel.text = @"结算总计:";
        settleLabel.textAlignment = NSTextAlignmentRight;
        [_toobarView addSubview:settleLabel];
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = MAIN_COLOR;
        priceLabel.font = SYSTEM_FONT(17);
        priceLabel.text = @"¥128";
        priceLabel.textAlignment = NSTextAlignmentRight;
        [_toobarView addSubview:priceLabel];
        
        UIButton *settleButton = [[UIButton alloc] init];
        settleButton.titleLabel.font = BOLD_SYSTEM_FONT(15.0);
        [settleButton setBackgroundColor:MAIN_COLOR];
        [settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [settleButton setTitle:@"结算" forState:UIControlStateNormal];
        settleButton.layer.cornerRadius = 14.5;
        [_toobarView addSubview:settleButton];
        WS(weakSelf)
        [[settleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZOrderPayViewController *orderPayVC = [[ZOrderPayViewController alloc] init];
            [weakSelf.navigationController pushViewController:orderPayVC animated:YES];
        }];
        
        [settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.toobarView);
            make.trailing.equalTo(-20);
            make.size.equalTo(CGSizeMake(100, 29));
        }];
        [settleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.toobarView);
            make.trailing.equalTo(priceLabel.mas_leading).offset(-20);
            make.leading.equalTo(20);
        }];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.toobarView);
            make.trailing.equalTo(settleButton.mas_leading).offset(-20);
        }];
        
    }
    return _toobarView;
}
@end
