//
//  AppDelegate+RemoteNotification.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/29.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "AppDelegate+RemoteNotification.h"
#import <UserNotifications/UserNotifications.h>

@implementation AppDelegate (RemoteNotification)
#pragma mark - UIApplicationDelegate 推送相关

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // 注册APNS失败.
    // 自行处理.
    ZLog(@"error: %@", [error localizedDescription]);
    
}
//接收到通知调用
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [ MiPushSDK handleReceiveRemoteNotification :userInfo];
    [[MiPushSDKManager sharedManager] miPushDidClickNotification:userInfo];
}
// 点击通知进入应用iOS7+
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [ MiPushSDK handleReceiveRemoteNotification :userInfo];
    [[MiPushSDKManager sharedManager] miPushDidClickNotification:userInfo];
}
// 点击通知进入应用iOS10+
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [ MiPushSDK handleReceiveRemoteNotification :userInfo];
        [[MiPushSDKManager sharedManager] miPushDidClickNotification:userInfo];
    }
    completionHandler();
}
@end
