//
//  ZShoppingCartController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZShoppingCartController.h"
#import "ZShoppingCartView.h"
#import "ZShoppingCartViewModel.h"

@interface ZShoppingCartController ()

@property (nonatomic, strong) ZShoppingCartView *mainView;

@property (nonatomic, strong) ZShoppingCartViewModel *viewModel;

@end

@implementation ZShoppingCartController

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
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //点击cell操作
        ZOrderDetailViewController *orderDetailVC = [[ZOrderDetailViewController alloc] init];
        [self.navigationController pushViewController:orderDetailVC animated:YES];
    }];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"购物车" bgColor:white_color backBtn:nil sel:nil rightBtn:nil sel:nil devider:NO];
}
#pragma mark - lazyload
- (ZShoppingCartView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZShoppingCartView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZShoppingCartViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZShoppingCartViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
