//
//  ZMyViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/5.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZMyViewModel : ZViewModel

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) RACSubject *userIconClickSubject;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@property (nonatomic, strong) RACSubject *orderClickSubject;
@end
