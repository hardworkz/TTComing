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
    
    NSMutableArray *oneSectionArray = [[NSMutableArray alloc] init];
    NSMutableArray *twoSectionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i++) {
        
        if (i == 0) {
            ZMyTableViewCellViewModel *viewModel = [[ZMyTableViewCellViewModel alloc] init];
            viewModel.title = @"全部订单";
            viewModel.icon = @"icon_setting";
            viewModel.hideDevider = NO;
            viewModel.rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
            [oneSectionArray addObject:viewModel];
        }else  if (i == 1) {
            ZMyTableViewCellViewModel *viewModel = [[ZMyTableViewCellViewModel alloc] init];
            viewModel.title = @"我的收藏";
            viewModel.icon = @"icon_setting";
            viewModel.hideDevider = YES;
            viewModel.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            [oneSectionArray addObject:viewModel];
        }
    }
    [self.sectionDataArray addObject:oneSectionArray];
    for (int i = 0; i < 2; i++) {
        
        if (i == 0) {
            ZMyTableViewCellViewModel *viewModel = [[ZMyTableViewCellViewModel alloc] init];
            viewModel.title = @"个人信息";
            viewModel.icon = @"icon_setting";
            viewModel.hideDevider = NO;
            viewModel.rectCorner = UIRectCornerTopLeft | UIRectCornerTopRight;
            [twoSectionArray addObject:viewModel];
        }else  if (i == 1) {
            ZMyTableViewCellViewModel *viewModel = [[ZMyTableViewCellViewModel alloc] init];
            viewModel.title = @"账户安全";
            viewModel.icon = @"icon_setting";
            viewModel.hideDevider = YES;
            viewModel.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            [twoSectionArray addObject:viewModel];
        }
    }
    [self.sectionDataArray addObject:twoSectionArray];
    
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
@end
