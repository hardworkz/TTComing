//
//  ZGoodsDetailViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/26.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZGoodsDetailViewModel : ZViewModel

@property (nonatomic, strong) RACSubject *refreshEndSubject;

@property (nonatomic, strong) RACSubject *refreshUI;

//@property (nonatomic, strong) RACSubject *refreshDetailIMageCellHeight;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACCommand *nextPageCommand;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageDataArray;
@property (nonatomic, strong) NSArray *detailImageDataArray;
@property (nonatomic, strong) NSArray *commentataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@property (nonatomic, strong) RACSubject *imageCellClickSubject;

@property (nonatomic, strong) RACSubject *alertClickSubject;

@property (nonatomic, strong) RACSubject *moreClickSubject;

@end
