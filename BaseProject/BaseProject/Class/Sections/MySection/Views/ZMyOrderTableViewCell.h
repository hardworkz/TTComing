//
//  ZMyOrderTableViewCell.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZTableViewCell.h"
#import "ZMyOrderTableViewCellViewModel.h"


typedef NS_ENUM(NSInteger, OrderType) {
    OrderTypeWaitPay = 0,//未付款
    OrderTypeWaitReceived,//未收货
    OrderTypeWaitComment//未留言
};
@interface ZMyOrderTableViewCell : ZTableViewCell

@property (nonatomic, strong) ZMyOrderTableViewCellViewModel *viewModel;

@property (assign, nonatomic) OrderType orderType;
/**
 根绝数据计算cell的高度
 */
- (CGFloat)cellHeightForViewModel:(ZMyOrderTableViewCellViewModel *)viewModel;
@end
