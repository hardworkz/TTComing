//
//  ZHomeListCollectionViewCell.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/13.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZCollectionViewCell.h"
#import "ZHomeListCollectionViewCellViewModel.h"

@interface ZHomeListCollectionViewCell : ZCollectionViewCell

@property (strong, nonatomic) ZHomeListCollectionViewCellViewModel *viewModel;

/**
 根绝重复计算cell的高度
 @return cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZHomeListCollectionViewCellViewModel *)viewModel;
@end
