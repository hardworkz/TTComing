//
//  ZMyWaitReceiveViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyWaitReceiveViewController.h"
#import "ZMyWaitReceiveOrderView.h"
#import "ZMyWaitReceiveOrderViewModel.h"

@interface ZMyWaitReceiveViewController ()

@property (nonatomic, strong) ZMyWaitReceiveOrderView *mainView;

@property (nonatomic, strong) ZMyWaitReceiveOrderViewModel *viewModel;

@end

@implementation ZMyWaitReceiveViewController
#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
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
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //点击cell操作
    }];
}
#pragma mark - lazyload
- (ZMyWaitReceiveOrderView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZMyWaitReceiveOrderView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZMyWaitReceiveOrderViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyWaitReceiveOrderViewModel alloc] init];
    }
    
    return _viewModel;
}
@end
