//
//  ZCommentViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/27.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZCommentViewController.h"
#import "ZCommentListView.h"
#import "ZCommentListViewModel.h"

@interface ZCommentViewController ()

@property (nonatomic, strong) ZCommentListView *mainView;

@property (nonatomic, strong) ZCommentListViewModel *viewModel;

@end

@implementation ZCommentViewController

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
    }];
}
- (void)z_layoutNavigation
{
    self.title = @"听闻区块链";
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"全部留言" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
#pragma mark - lazyload
- (ZCommentListView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZCommentListView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZCommentListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZCommentListViewModel alloc] init];
    }
    
    return _viewModel;
}
@end
