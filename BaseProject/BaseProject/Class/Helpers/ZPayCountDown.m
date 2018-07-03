//
//  ZPayCountDown.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/2.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZPayCountDown.h"

@interface ZPayCountDown ()

@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation ZPayCountDown

#pragma mark 支付过程倒计时 商城倒计时

-(void)countDownWithSeparate:(NSInteger)totalTime completeBlock:(void(^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    
    if(_timer == nil) {
        
        __block NSInteger timeout = totalTime;
        
        if(timeout !=0) {
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
            
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0);
            
            WS(weakSelf)
            dispatch_source_set_event_handler(_timer, ^{
                
                if(timeout <= 0){
                    
                    dispatch_source_cancel(weakSelf.timer);
                    
                    weakSelf.timer = nil;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        completeBlock(0,0,0,0);
                        
                    });
                    
                }else{
                    
                    NSInteger totalTime = timeout;
                    
                    NSInteger s =1;
                    
                    NSInteger m = s *60;
                    
                    NSInteger h = m *60;
                    
                    NSInteger d = h *24;
                    
                    NSInteger day = totalTime / d;//天
                    
                    NSInteger hour = (totalTime - day * d) / h;//时考虑天1天23小时59分钟59秒
                    
                    //NSInteger onlyhour = totalTime / h;//时不考虑天只考虑到小时28小时59分钟59秒
                    
                    NSInteger minute = (totalTime - day * d - hour * h) / m;//分
                    
                    NSInteger second = (totalTime - day * d - hour * h - minute * m) / s;//秒
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        completeBlock(day,hour,minute,second);
                        
                    });
                    
                    //不考虑天的回调28小时59分钟59秒
                    
                    //dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //completeBlock(0,onlyhour,minute,second);
                    
                    //});
                    
                    timeout--;
                    
                }
                
            });
            
            dispatch_resume(_timer);
            
        }
        
    }
    
}

-(void)countDownWithCreateTime:(NSString *)createTime endTime:(NSString *)endTime completeBlock:(void(^)(NSInteger second))completeBlock {
    
    if(_timer == nil) {
        
        // time 结束时间字符串 beginTime开始时间字符串 <--- 从服务器获取到的
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *endDate = [formatter dateFromString:endTime];
        NSDate *nowDate = [NSDate date];
        
//        NSDate *beginDate = [formatter dateFromString:createTime];
//
//        NSTimeInterval beginTimeInterval = [beginDate timeIntervalSinceDate:nowDate];
        
        //剩余时间秒数
        NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:nowDate];
        
        __block NSInteger timeout = timeInterval;
        
        if(timeout !=0) {
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
            
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0);
            
            WS(weakSelf)
            dispatch_source_set_event_handler(_timer, ^{
                
                if(timeout <= 0){
                    
                    dispatch_source_cancel(weakSelf.timer);
                    
                    weakSelf.timer = nil;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        completeBlock(0);
                        
                    });
                    
                }else{
                    NSInteger second = timeout;//秒
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        completeBlock(second);
                        
                    });
                    
                    timeout--;
                    
                }
                
            });
            
            dispatch_resume(_timer);
            
        }
        
    }
    
}


#pragma mark 获取验证码倒计时

-(void)countDownWithTime:(NSInteger)totalTime completeBlock:(void(^)(NSInteger countDown))completeBlock

{
    
    if(_timer == nil) {
        
        __block NSInteger timeout = totalTime;
        
        if(timeout != 0) {
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
            
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0,0,queue);
            
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0),1.0*NSEC_PER_SEC,0);
            
            WS(weakSelf)
            dispatch_source_set_event_handler(_timer, ^{
                ZLog(@"%ld",timeout);
                if(timeout <=0){
                    
                    dispatch_source_cancel(weakSelf.timer);
                    
                    weakSelf.timer = nil;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        completeBlock(0);
                        
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        completeBlock(timeout);
                        
                    });
                    
                    timeout--;
                    
                }
                
            });
            
            dispatch_resume(_timer);
            
        }
        
    }
    
}

#pragma mark主动销毁定时器

-(void)destoryTimer

{
    
    if(_timer){
        
        dispatch_source_cancel(_timer);
        
        _timer=nil;
        
    }
    
}
@end
