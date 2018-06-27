//
//  ZShoppingCartViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZShoppingCartViewModel : ZViewModel

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end
