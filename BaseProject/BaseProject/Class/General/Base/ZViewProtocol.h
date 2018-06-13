//
//  ZViewProtocol.h
//  BaseProject
//
//  Created by 泡果 on 2018/5/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZViewModelProtocol;

@protocol ZViewProtocol <NSObject>

@optional

- (instancetype)initWithViewModel:(id <ZViewModelProtocol>)viewModel;

- (void)z_bindViewModel;
- (void)z_setupViews;
- (void)z_addReturnKeyBoard;

@end