//
//  ZHomeListView.h
//  BaseProject
//
//  Created by 泡果 on 2018/5/31.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZView.h"

@interface ZHomeListView : ZView

@property (nonatomic, copy) void(^scroll)(CGFloat y);

@end
