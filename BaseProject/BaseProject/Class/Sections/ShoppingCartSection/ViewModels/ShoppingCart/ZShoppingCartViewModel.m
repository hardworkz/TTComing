//
//  ZShoppingCartViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZShoppingCartViewModel.h"
#import "ZShoppingCartTableViewCellViewModel.h"

@implementation ZShoppingCartViewModel
- (void)z_initialize {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        NSMutableArray *reArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {

            ZShoppingCartTableViewCellViewModel *viewModel = [[ZShoppingCartTableViewCellViewModel alloc] init];
            viewModel.title = [NSString stringWithFormat:@"index:%d",i];
            viewModel.image = @"11";
            [reArray addObject:viewModel];
        }
        
        self.dataArray = reArray;
        
        [self.refreshUI sendNext:nil];
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
- (RACSubject *)deleteClickSubject {
    
    if (!_deleteClickSubject) {
        
        _deleteClickSubject = [RACSubject subject];
    }
    
    return _deleteClickSubject;
}
@end
