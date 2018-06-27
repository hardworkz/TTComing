//
//  ZOrderPayViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderPayViewModel.h"

@implementation ZOrderPayViewModel
- (void)z_initialize {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
//        NSMutableArray *reArray = [[NSMutableArray alloc] init];
//        for (int i = 0; i < 4; i++) {
//
//            ZSettleCenterContentCellViewModel *viewModel = [[ZSettleCenterContentCellViewModel alloc] init];
//            viewModel.title = [NSString stringWithFormat:@"index:%d",i];
//            [reArray addObject:viewModel];
//        }
        
        
        [self.refreshUI sendNext:@"ZSettleCenterViewModel"];
        DismissHud();
    }];
    
}

- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}
- (RACCommand *)refreshDataCommand {
    
    if (!_refreshDataCommand) {
        
        @weakify(self);
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
            @strongify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                @strongify(self);
                //                [self.request POST:REQUEST_URL parameters:nil success:^(CMRequest *request, id responseObject) {
                //
                //                    NSDictionary *dict = responseObject;
                [subscriber sendNext:nil];
                [subscriber sendCompleted];
                //
                //                } failure:^(CMRequest *request, NSError *error) {
                //
                //                    ShowErrorStatus(@"网络连接失败");
                //                    [subscriber sendCompleted];
                //                }];
                return nil;
            }];
        }];
    }
    
    return _refreshDataCommand;
}

@end
