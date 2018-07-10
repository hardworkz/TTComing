//
//  AlipaySDKManager.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/6.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "AlipaySDKManager.h"

@implementation AlipaySDKManager
#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static AlipaySDKManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[AlipaySDKManager alloc] init];
    });
    return instance;
}

/**
 支付宝支付方法
 
 @param orderString 订单号字符串（由服务器生成）
 */
- (void)alipayWithOrderString:(NSString *)orderString {
    
    //应用注册urlscheme,在Info.plist定义URL types
    NSString *appScheme = @"Alipay-TT";
    
    WS(weakSelf)
    // NOTE: 调用支付结果开始支付
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        if (weakSelf.CallbackComplete) {
            weakSelf.CallbackComplete(resultDic);
        }
    }];
}
/**
 支付宝支付结果回调方法
 
 @param url 订单号字符串（由服务器生成）
 */
- (void)alipayWithUrl:(NSURL *)url {
    
    WS(weakSelf)
    // 支付跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        if (weakSelf.CallbackComplete) {
            weakSelf.CallbackComplete(resultDic);
        }
    }];
}
@end
