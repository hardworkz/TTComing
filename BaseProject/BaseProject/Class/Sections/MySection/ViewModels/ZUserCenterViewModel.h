//
//  ZUserCenterViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZUserCenterViewModel : ZViewModel

@property (nonatomic, strong) RACSubject *refreshUI;

@property (nonatomic, strong) NSMutableArray *sectionDataArray;

@property (nonatomic, strong) RACSubject *cellClickSubject;

@end
