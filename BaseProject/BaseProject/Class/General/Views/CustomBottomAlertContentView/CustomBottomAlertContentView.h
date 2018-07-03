//
//  CustomBottomAlertContentView.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBottomAlertContentView : UIView
/**
 *  自定义的view
 */
@property (nonatomic , strong) UIView *customView;
/**
 *  弹出视图的高度
 */
@property (nonatomic,assign)  CGFloat alertHeight;
/**
 *  遮盖
 */
@property (nonatomic , weak) UIButton *cover;
/**
 *  遮盖点击回调block
 */
@property (copy, nonatomic) void (^coverClickBlock)(NSInteger status);

- (void)show;
- (void)coverClick;
@end
