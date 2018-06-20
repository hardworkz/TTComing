//
//  ZMyHeadViewModel.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyHeadViewModel.h"

@implementation ZMyHeadViewModel
- (RACSubject *)userIconClickSubject
{
    if (!_userIconClickSubject) {
        
        _userIconClickSubject = [RACSubject subject];
    }
    
    return _userIconClickSubject;
}
- (RACSubject *)settingClickSubject
{
    if (!_settingClickSubject) {
        
        _settingClickSubject = [RACSubject subject];
    }
    
    return _settingClickSubject;
}
- (RACSubject *)waitPayClickSubject
{
    if (!_waitPayClickSubject) {
        
        _waitPayClickSubject = [RACSubject subject];
    }
    
    return _waitPayClickSubject;
}
- (RACSubject *)waitReceiveClickSubject
{
    if (!_waitReceiveClickSubject) {
        
        _waitReceiveClickSubject = [RACSubject subject];
    }
    
    return _waitReceiveClickSubject;
}
- (RACSubject *)waitCommentClickSubject
{
    if (!_waitCommentClickSubject) {
        
        _waitCommentClickSubject = [RACSubject subject];
    }
    
    return _waitCommentClickSubject;
}
@end
