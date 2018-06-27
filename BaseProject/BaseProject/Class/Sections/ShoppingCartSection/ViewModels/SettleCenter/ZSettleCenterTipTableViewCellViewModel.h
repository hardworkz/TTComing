//
//  ZSettleCenterTipTableViewCellViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZSettleCenterTipTableViewCellViewModel : ZViewModel

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *content;

@property (assign, nonatomic) CGFloat cellHeight;
@end
