//
//  ZOrderPayViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderPayViewController.h"
#import "ZOrderPayView.h"
#import "ZOrderPayViewModel.h"

@interface ZOrderPayViewController ()<DQAlertViewDelegate>

@property (nonatomic, strong) ZOrderPayView *mainView;

@property (nonatomic, strong) ZOrderPayViewModel *viewModel;

@end

@implementation ZOrderPayViewController

#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(kNavHeight, 0, 0, 0));
    }];
    [super updateViewConstraints];
}
#pragma mark - private
- (void)z_addSubviews
{
    [self.view addSubview:self.mainView];
}
- (void)z_bindViewModel
{
    @weakify(self)
    //    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
    //        @strongify(self);
    //        //点击cell操作
    //    }];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"订单支付" bgColor:white_color backBtn:@"icon_back_black" sel:@selector(backClicked) rightBtn:nil sel:nil devider:YES];
    [self setFd_interactivePopDisabled:YES];
}
#pragma mark - lazyload
- (ZOrderPayView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZOrderPayView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZOrderPayViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZOrderPayViewModel alloc] init];
    }
    
    return _viewModel;
}
#pragma mark - action
- (void)backClicked {
    //弹窗提示
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"确定放弃支付?" message:@"下单后30分钟未完成支付，订单将被取消，请您尽快支付" delegate:self cancelButtonTitle:@"确认离开" otherButtonTitles:@"继续支付", nil];
    [alertView.cancelButton setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
    [alertView.otherButton setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
    alertView.otherButton.titleLabel.font = BOLD_SYSTEM_FONT(17);
    alertView.cancelButton.titleLabel.font = FONT(17);
    [alertView show];
}
#pragma mark - DQAlertViewDelegate
- (void)otherButtonClickedOnAlertView:(DQAlertView *)alertView {
}
- (void)cancelButtonClickedOnAlertView:(DQAlertView *)alertView
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
