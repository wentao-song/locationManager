//
//  WTNotificationManager.m
//  LocationManager
//
//  Created by MOYO on 2019/7/30.
//  Copyright © 2019年 songwentao. All rights reserved.
//

#import "WTNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
@interface WTNotificationManager()<UNUserNotificationCenterDelegate>



@end

@implementation WTNotificationManager

+ (WTNotificationManager *)sharedManager{
    static WTNotificationManager *notificationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationManager = [[WTNotificationManager alloc]init];
    });
    return notificationManager;
}




//检查是否允许推送
- (void)checkNotificationAuthrization{
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge |UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == true) {
            //允许推送 设置本地或远程推送
           // [self locaNotification];//本地推送
            //注册远程推送
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication]registerForRemoteNotifications];
            });
        }
    }];
}

//本地推送
-(void)locaNotification{
    //生成推送内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.badge = @(1);
    content.title = @"本地推送";
    content.body = @"测试一下本地推送";
    //本地推送有三种
    //UNCalendarNotificationTrigger（本地通知） 一定日期之后，重复或者不重复推送通知
    //UNLocationNotificationTrigger （本地通知）地理位置的一种通知，使用这个通知，你需要导入#import<CoreLocation/CoreLocation.h>这个系统类库
    //生成推送发生条件，这里是时间间隔为条件,当时间小于60秒的时候m，不能设为YES
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:30 repeats:NO];
    //生成推送请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"locationPush" content:content trigger:trigger];
    //把请求提交到系统
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}

//将要展示
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //弹窗显示
    completionHandler(UNNotificationPresentationOptionAlert);
}

//已经收到
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    //处理业务，根据推送内容，跳转页面等逻辑
    completionHandler();
}


@end
