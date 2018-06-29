//
//  ZMyAllOrderViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyAllOrderViewController.h"
#import "ZMyOrderListView.h"
#import "ZMyOrderListViewModel.h"


@interface ZMyAllOrderViewController ()

@property (nonatomic, strong) ZMyOrderListView *mainView;

@property (nonatomic, strong) ZMyOrderListViewModel *viewModel;

@end

@implementation ZMyAllOrderViewController
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
    [self rightSwipeWithView:self.mainView];
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
- (ZMyOrderListView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZMyOrderListView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZMyOrderListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyOrderListViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
