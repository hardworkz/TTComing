//
//  ZUserCenterViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZUserCenterViewModel.h"
#import "ZUserCenterCellViewModel.h"

@implementation ZUserCenterViewModel
- (void)z_initialize {
    
    NSMutableArray *firstSectionArray = [NSMutableArray array];
    NSMutableArray *secondSectionArray = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        
        ZUserCenterCellViewModel *viewModel = [[ZUserCenterCellViewModel alloc] init];
        
        switch (i) {
            case 0:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"头像";
                viewModel.icon = @"全部订单";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 1:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"昵称";
                viewModel.icon = @"我的收藏";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 2:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"简介";
                viewModel.icon = @"全部订单";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 3:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"性别";
                viewModel.icon = @"我的收藏";
                viewModel.hideDevider = YES;
                viewModel.bgView = @"";
                break;
                
            default:
                break;
        }
        [firstSectionArray addObject:viewModel];
    }
    for (int i = 0; i < 3; i++) {
        
        ZUserCenterCellViewModel *viewModel = [[ZUserCenterCellViewModel alloc] init];
        
        switch (i) {
            case 0:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"地区";
                viewModel.icon = @"全部订单";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 1:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"收货地址";
                viewModel.icon = @"我的收藏";
                viewModel.hideDevider = NO;
                viewModel.bgView = @"";
                break;
            case 2:
                viewModel.content = @"哈哈哈哈哈哈";
                viewModel.title = @"手机";
                viewModel.icon = @"全部订单";
                viewModel.hideDevider = YES;
                viewModel.bgView = @"";
                break;
                
            default:
                break;
        }
        [secondSectionArray addObject:viewModel];
    }
    [self.sectionDataArray addObject:firstSectionArray];
    [self.sectionDataArray addObject:secondSectionArray];
    
    [self.refreshUI sendNext:nil];
}
- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (NSMutableArray *)sectionDataArray {
    
    if (!_sectionDataArray) {
        
        _sectionDataArray = [[NSMutableArray alloc] init];
    }
    
    return _sectionDataArray;
}
- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}
@end
