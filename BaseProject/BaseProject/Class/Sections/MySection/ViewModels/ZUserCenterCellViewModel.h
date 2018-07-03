//
//  ZUserCenterCellViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZUserCenterCellViewModel : ZViewModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *bgView;

@property (assign, nonatomic) BOOL hideDevider;

@end
