//
//  ZGoodsDetailViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/26.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailViewModel.h"
#import "ZHomeListCollectionViewCellViewModel.h"
#import "ZGoodsDetailCommentCellViewModel.h"
#import "ZGoodsDetailImageCellViewModel.h"

@implementation ZGoodsDetailViewModel
- (void)z_initialize {
    
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 1; i++) {
            
            ZGoodsDetailImageCellViewModel *viewModel = [[ZGoodsDetailImageCellViewModel alloc] init];
            viewModel.image = @"15商品详情页";
            [imageArray addObject:viewModel];
        }
        self.imageDataArray = imageArray;
        
        
        NSMutableArray *reArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 8; i++) {
            
            ZHomeListCollectionViewCellViewModel *viewModel = [[ZHomeListCollectionViewCellViewModel alloc] init];
            viewModel.image = [NSString stringWithFormat:@"%d",i+5];
            [reArray addObject:viewModel];
        }
        
        self.dataArray = reArray;
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasMoreData)];
        DismissHud();
    }];
    
    [self.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(NSDictionary *dict) {
        
        @strongify(self);
        
        NSMutableArray *reArray = [[NSMutableArray alloc] initWithArray:self.dataArray];
        for (int i = 0; i < 8; i++) {
            
            ZHomeListCollectionViewCellViewModel *viewModel = [[ZHomeListCollectionViewCellViewModel alloc] init];
            viewModel.image = [NSString stringWithFormat:@"%d",i+5];
            [reArray addObject:viewModel];
        }
        
        self.dataArray = reArray;
        [self.refreshEndSubject sendNext:@(LSFooterRefresh_HasMoreData)];
        DismissHud();
    }];
    
}

- (RACSubject *)refreshUI {
    
    if (!_refreshUI) {
        
        _refreshUI = [RACSubject subject];
    }
    
    return _refreshUI;
}

- (RACSubject *)refreshEndSubject {
    
    if (!_refreshEndSubject) {
        
        _refreshEndSubject = [RACSubject subject];
    }
    
    return _refreshEndSubject;
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

- (RACCommand *)nextPageCommand {
    
    if (!_nextPageCommand) {
        
        @weakify(self);
        _nextPageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            
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
    
    return _nextPageCommand;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [[NSArray alloc] init];
    }
    
    return _dataArray;
}
- (NSArray *)imageDataArray {
    
    if (!_imageDataArray) {
        
        _imageDataArray = [[NSArray alloc] init];
    }
    
    return _imageDataArray;
}
- (NSArray *)commentataArray {
    
    if (!_commentataArray) {
        
        _commentataArray = [[NSArray alloc] init];
    }
    
    return _commentataArray;
}

- (RACSubject *)cellClickSubject {
    
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
    }
    
    return _cellClickSubject;
}
- (RACSubject *)alertClickSubject {
    
    if (!_alertClickSubject) {
        
        _alertClickSubject = [RACSubject subject];
    }
    
    return _alertClickSubject;
}
- (RACSubject *)moreClickSubject {
    
    if (!_moreClickSubject) {
        
        _moreClickSubject = [RACSubject subject];
    }
    
    return _moreClickSubject;
}
@end
