//
//  ZUserCenterViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZUserCenterViewController.h"
#import "ZUserCenterView.h"
#import "ZUserCenterViewModel.h"

@interface ZUserCenterViewController ()

@property (nonatomic, strong) ZUserCenterView *mainView;

@property (nonatomic, strong) ZUserCenterViewModel *viewModel;

@end

@implementation ZUserCenterViewController
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
        switch ([x integerValue]) {
            case 0:{
            }
                break;
            case 1:{
                
            }
                break;
            case 2:{
            }
                
                break;
            case 3:
                
                break;
            case 4:
                
                break;
                
            default:
                break;
        }
    }];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"个人信息" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
#pragma mark - lazyload
- (ZUserCenterView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZUserCenterView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZUserCenterViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZUserCenterViewModel alloc] init];
    }
    
    return _viewModel;
}


@end
