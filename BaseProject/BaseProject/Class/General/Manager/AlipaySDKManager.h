//
//  AlipaySDKManager.h
//  BaseProject
//
//  Created by 泡果 on 2018/7/6.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlipaySDKManager : NSObject

/**
 支付结果回调block
 */
@property (nonatomic, copy) void(^CallbackComplete)(NSDictionary *resultDic);

+(instancetype)sharedManager;


/**
 支付宝支付方法

 @param orderString 订单号字符串（由服务器生成）
 */
- (void)alipayWithOrderString:(NSString *)orderString;
/**
 支付宝支付结果回调方法
 
 @param url 订单号字符串（由服务器生成）
 */
- (void)alipayWithUrl:(NSURL *)url;

@end
