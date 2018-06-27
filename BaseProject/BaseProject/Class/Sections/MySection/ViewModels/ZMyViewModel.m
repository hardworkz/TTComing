//
//  ZMyViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/5.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyViewModel.h"
#import "ZMyTableViewCellViewModel.h"

@implementation ZMyViewModel
- (void)z_initialize {
    
    for (int i = 0; i < 5; i++) {
        
        ZMyTableViewCellViewModel *viewModel = [[ZMyTableViewCellViewModel alloc] init];
        
        switch (i) {
            case 0:
                viewModel.title = @"全部订单";
                viewModel.icon = @"全部订单";
                break;
            case 1:
                viewModel.title = @"我的收藏";
                viewModel.icon = @"我的收藏";
                break;
            case 2:
                viewModel.title = @"个人信息";
                viewModel.icon = @"个人信息";
                break;
            case 3:
                viewModel.title = @"账户安全";
                viewModel.icon = @"账户安全";
                break;
            case 4:
                viewModel.title = @"设置中心";
                viewModel.icon = @"设置中心";
                break;
                
            default:
                break;
        }
        [self.dataArray addObject:viewModel];
    }
    
    [self.refreshUI sendNext:nil];
}
- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return _dataArray;
}
- (RACSubject *)userIconClickSubject
{
    if (!_userIconClickSubject) {
        
        _userIconClickSubject = [RACSubject subject];
    }
    
    return _userIconClickSubject;
}
- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}
- (RACSubject *)orderClickSubject {
    
    if (!_orderClickSubject) {
        
        _orderClickSubject = [RACSubject subject];
    }
    
    return _orderClickSubject;
}
@end
