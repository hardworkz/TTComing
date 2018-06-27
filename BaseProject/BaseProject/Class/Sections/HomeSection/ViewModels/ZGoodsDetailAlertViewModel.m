//
//  ZGoodsDetailAlertViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/27.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailAlertViewModel.h"
#import "ZSettleCenterTipTableViewCellViewModel.h"

@implementation ZGoodsDetailAlertViewModel
- (void)z_initialize {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        NSMutableArray *reArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 4; i++) {
            
            ZSettleCenterTipTableViewCellViewModel *viewModel = [[ZSettleCenterTipTableViewCellViewModel alloc] init];
            [reArray addObject:viewModel];
            switch (i) {
                case 0:
                    viewModel.title = @"正品保证";
                    viewModel.content = @"保证每一件商品都是原装正品，杜绝一切假货，让您无忧购物。";
                    break;
                case 1:
                    viewModel.title = @"七天包退";
                    viewModel.content = @"收到商品之日7天内如有商品质量问题或者漏发缺发等，均可申请售后。";
                    break;
                case 2:
                    viewModel.title = @"隐私包装";
                    viewModel.content = @"所有发货包裹均用空白纸箱不透明包装，免检发货，保密运输，同事对快递员屏蔽敏感信息，加强隐私保护，放心购物。";
                    break;
                case 3:
                    viewModel.title = @"货到付款";
                    viewModel.content = @"本商品支持货到付款。";
                    break;
                    
                default:
                    break;
            }
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
