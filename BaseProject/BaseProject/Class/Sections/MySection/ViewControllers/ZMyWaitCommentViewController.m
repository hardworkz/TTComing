//
//  ZMyWaitCommentViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyWaitCommentViewController.h"
#import "ZMyWaitCommentOrderView.h"
#import "ZMyWaitCommentOrderViewModel.h"

@interface ZMyWaitCommentViewController ()

@property (nonatomic, strong) ZMyWaitCommentOrderView *mainView;

@property (nonatomic, strong) ZMyWaitCommentOrderViewModel *viewModel;

@end

@implementation ZMyWaitCommentViewController
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
- (ZMyWaitCommentOrderView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZMyWaitCommentOrderView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZMyWaitCommentOrderViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyWaitCommentOrderViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
