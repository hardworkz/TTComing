//
//  ZCommentTableViewCell.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/27.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZTableViewCell.h"
#import "ZCommentTableViewCellViewModel.h"

@interface ZCommentTableViewCell : ZTableViewCell

@property (nonatomic, strong) ZCommentTableViewCellViewModel *viewModel;
/**
 根绝重复计算cell的高度
 @return cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZCommentTableViewCellViewModel *)viewModel;
@end
