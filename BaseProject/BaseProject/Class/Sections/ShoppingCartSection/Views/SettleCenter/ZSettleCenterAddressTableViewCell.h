//
//  ZSettleCenterAddressTableViewCell.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/21.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZTableViewCell.h"

@interface ZSettleCenterAddressTableViewCell : ZTableViewCell

@property (nonatomic, strong) ZSettleCenterContentCellViewModel *viewModel;

@property (assign, nonatomic) BOOL hasAddress;
@end
