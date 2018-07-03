//
//  ZMyViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/31.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyViewController.h"
#import "ZMyView.h"
#import "ZMyViewModel.h"

@interface ZMyViewController ()

@property (nonatomic, strong) ZMyView *mainView;

@property (nonatomic, strong) ZMyViewModel *viewModel;

@end

@implementation ZMyViewController
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
        switch ([x integerValue]) {
            case 0:{
                //全部订单
                ZMyOrderController *orderVC = [[ZMyOrderController alloc] init];
                [self.navigationController pushViewController:orderVC animated:YES];
            }
                break;
            case 1:{
                //收货地址
                ZAddAddressViewController *addAddressVC = [[ZAddAddressViewController alloc] init];
                [self.navigationController pushViewController:addAddressVC animated:YES];
                
            }
                break;
            case 2:{
                //意见反馈
                ZFeedBackViewController *feedbackVC = [[ZFeedBackViewController alloc] init];
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }
                
                break;
            case 3:{
                ZUserCenterViewController *userCenterVC = [[ZUserCenterViewController alloc] init];
                [self.navigationController pushViewController:userCenterVC animated:YES];
            }
                
                break;
            case 4:{
                ZAboutUSViewController *aboutUSVC = [[ZAboutUSViewController alloc] init];
                [self.navigationController pushViewController:aboutUSVC animated:YES];
            }
                
                break;
                
            default:
                break;
        }
    }];
    [self.viewModel.userIconClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //点击头像操作
        ZLoginViewController *loginVC = [[ZLoginViewController alloc] init];
        [self.navigationController presentViewController:loginVC animated:YES completion:nil];
    }];
    [self.viewModel.orderClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isEqualToString:@"waitPay"]) {
            ZMyOrderController *orderVC = [[ZMyOrderController alloc] init];
            orderVC.index = 1;
            [self.navigationController pushViewController:orderVC animated:YES];
            
        }else if ([x isEqualToString:@"waitReceive"]) {
            ZMyOrderController *orderVC = [[ZMyOrderController alloc] init];
            orderVC.index = 2;
            [self.navigationController pushViewController:orderVC animated:YES];
            
        }else if ([x isEqualToString:@"waitComment"]) {
            ZMyOrderController *orderVC = [[ZMyOrderController alloc] init];
            orderVC.index = 3;
            [self.navigationController pushViewController:orderVC animated:YES];
            
        }
    }];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    
}
#pragma mark - lazyload
- (ZMyView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZMyView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZMyViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyViewModel alloc] init];
    }
    
    return _viewModel;
}

@end
