//
//  WTNotificationManager.h
//  LocationManager
//
//  Created by MOYO on 2019/7/30.
//  Copyright © 2019年 songwentao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
    app推送相关
 */

@interface WTNotificationManager : NSObject


+(WTNotificationManager*)sharedManager;

-(void)checkNotificationAuthrization;

@end

NS_ASSUME_NONNULL_END
