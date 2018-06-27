//
//  ZSettleCenterTipTableViewCell.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZTableViewCell.h"
#import "ZSettleCenterTipTableViewCellViewModel.h"

@interface ZSettleCenterTipTableViewCell : ZTableViewCell

@property (nonatomic, strong) ZSettleCenterTipTableViewCellViewModel *viewModel;

/**
 根绝重复计算cell的高度
 @return cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZSettleCenterTipTableViewCellViewModel *)viewModel;
@end
