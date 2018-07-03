//
//  ZAboutUSViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZAboutUSViewController.h"
#import "ZAboutUSView.h"
#import "ZAboutUSViewModel.h"

@interface ZAboutUSViewController ()

@property (nonatomic, strong) ZAboutUSView *mainView;

@property (nonatomic, strong) ZAboutUSViewModel *viewModel;

@end

@implementation ZAboutUSViewController
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
    [self customNavigationBarWithTitle:@"个人信息" bgColor:white_color backBtn:@"" sel:nil rightBtn:nil sel:nil devider:NO];
}
#pragma mark - lazyload
- (ZAboutUSView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZAboutUSView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZAboutUSViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZAboutUSViewModel alloc] init];
    }
    
    return _viewModel;
}


@end
