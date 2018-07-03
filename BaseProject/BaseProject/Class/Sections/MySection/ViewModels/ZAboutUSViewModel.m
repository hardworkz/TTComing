//
//  ZAboutUSViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZAboutUSViewModel.h"
#import "ZAboutUSCellViewModel.h"

@implementation ZAboutUSViewModel
- (void)z_initialize {
    
    for (int i = 0; i < 4; i++) {
        
        ZAboutUSCellViewModel *viewModel = [[ZAboutUSCellViewModel alloc] init];
        
        switch (i) {
            case 0:
                viewModel.icon = @"全部订单";
                viewModel.title = @"功能介绍";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 1:
                viewModel.icon = @"全部订单";
                viewModel.title = @"关注我们";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 2:
                viewModel.icon = @"全部订单";
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"客服QQ";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 3:
                viewModel.icon = @"全部订单";
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"客服电话";
                viewModel.hideDevider = YES;
                viewModel.bgView = @"";
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
- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}

@end
