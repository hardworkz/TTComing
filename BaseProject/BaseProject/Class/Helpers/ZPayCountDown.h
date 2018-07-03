//
//  ZPayCountDown.h
//  BaseProject
//
//  Created by 泡果 on 2018/7/2.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPayCountDown : NSObject
///支付过程倒计时商城倒计时

-(void)countDownWithSeparate:(NSInteger)totalTime completeBlock:(void(^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock;

/**
 支付过程倒计时商城倒计时 传入时间字符串格式（yyyy-MM-dd HH:mm:ss）
 */
-(void)countDownWithCreateTime:(NSString *)createTime endTime:(NSString *)endTime completeBlock:(void(^)(NSInteger second))completeBlock;

///获取验证码倒计时

-(void)countDownWithTime:(NSInteger)totalTime completeBlock:(void(^)(NSInteger countDown))completeBlock;

///主动销毁定时器

-(void)destoryTimer;
@end
