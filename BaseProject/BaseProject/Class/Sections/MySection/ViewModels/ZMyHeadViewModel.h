//
//  ZMyHeadViewModel.h
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZViewModel.h"

@interface ZMyHeadViewModel : ZViewModel

@property (nonatomic, strong) RACSubject *userIconClickSubject;

@property (nonatomic, strong) RACSubject *settingClickSubject;

@property (nonatomic, strong) RACSubject *waitPayClickSubject;

@property (nonatomic, strong) RACSubject *waitReceiveClickSubject;

@property (nonatomic, strong) RACSubject *waitCommentClickSubject;
@end
