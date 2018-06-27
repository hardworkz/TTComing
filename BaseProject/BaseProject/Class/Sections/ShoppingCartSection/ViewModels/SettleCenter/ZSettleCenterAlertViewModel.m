//
//  ZSettleCenterAlertViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterAlertViewModel.h"
#import "ZSettleCenterTipTableViewCellViewModel.h"

@implementation ZSettleCenterAlertViewModel
- (void)z_initialize {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        NSMutableArray *reArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 1; i++) {
            
            ZSettleCenterTipTableViewCellViewModel *viewModel = [[ZSettleCenterTipTableViewCellViewModel alloc] init];
            viewModel.title = @"包邮规则";
            viewModel.content = @"购物车商品结算订单满99包邮";
            [reArray addObject:viewModel];
        }
        
        self.dataArray = reArray;
        
        [self.refreshUI sendNext:@"ZSettleCenterAlertViewModel"];
        DismissHud();
    }];
    
}
- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}
- (RACSubject *)close {
    
    if (!_close) {
        
        _close = [RACSubject subject];
    }
    
    return _close;
}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    return _dataArray;
}

@end
