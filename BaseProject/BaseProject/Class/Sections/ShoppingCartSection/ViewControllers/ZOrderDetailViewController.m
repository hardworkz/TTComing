//
//  ZOrderDetailViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderDetailViewController.h"
#import "ZOrderDetailView.h"
#import "ZOrderDetailViewModel.h"

@interface ZOrderDetailViewController ()

@property (nonatomic, strong) ZOrderDetailView *mainView;

@property (nonatomic, strong) ZOrderDetailViewModel *viewModel;

@property (nonatomic, strong) ZView *toobarView;

@property (nonatomic, strong) UIButton *settleButton;

@property (nonatomic, strong) UIButton *cancleOrderButton;

@property (nonatomic, strong) UIButton *deleteOrderButton;
@end

@implementation ZOrderDetailViewController

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
        
    }];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"结算订单" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
#pragma mark - lazyload
- (ZOrderDetailView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZOrderDetailView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (ZOrderDetailViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZOrderDetailViewModel alloc] init];
    }
    
    return _viewModel;
}
- (ZView *)toobarView
{
    if (!_toobarView) {
        _toobarView = [[ZView alloc] init];
        
        _settleButton = [[UIButton alloc] init];
        _settleButton.titleLabel.font = BOLD_SYSTEM_FONT(15.0);
        [_settleButton setBackgroundColor:MAIN_COLOR];
        [_settleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settleButton setTitle:@"去结算" forState:UIControlStateNormal];
        _settleButton.layer.cornerRadius = 18;
        [_toobarView addSubview:_settleButton];
        
        _cancleOrderButton = [[UIButton alloc] init];
        _cancleOrderButton.titleLabel.font = BOLD_SYSTEM_FONT(15.0);
        [_cancleOrderButton setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [_cancleOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
        [_toobarView addSubview:_cancleOrderButton];
        
        _deleteOrderButton = [[UIButton alloc] init];
        _deleteOrderButton.titleLabel.font = BOLD_SYSTEM_FONT(15.0);
        [_deleteOrderButton setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [_deleteOrderButton setTitle:@"删除订单" forState:UIControlStateNormal];
        [_toobarView addSubview:_deleteOrderButton];
        
        WS(weakSelf)
        [[_settleButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZOrderPayViewController *orderPayVC = [[ZOrderPayViewController alloc] init];
            [weakSelf.navigationController pushViewController:orderPayVC animated:YES];
        }];
        [_settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(-MARGIN_20);
            make.centerY.equalTo(weakSelf.toobarView).offset(-MARGIN_20);
            make.size.equalTo(CGSizeMake(100, 36));
        }];
        [_cancleOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.settleButton.mas_leading);
            make.centerY.equalTo(weakSelf.toobarView).offset(-MARGIN_20);
            make.size.equalTo(CGSizeMake(100, 40));
        }];
        
        [_deleteOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.toobarView).offset(-MARGIN_20);
            make.centerX.equalTo(weakSelf.toobarView);
            make.size.equalTo(CGSizeMake(100, 40));
        }];
        
    }
    return _toobarView;
}
@end
