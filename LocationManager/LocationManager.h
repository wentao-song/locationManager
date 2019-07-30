//
//  LocationManager.h
//  LocationManager
//
//  Created by MOYO on 2019/7/30.
//  Copyright © 2019年 songwentao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 获取位置信息的步骤：
 1、首次使用需获取权限
 两个维度的权限，[是否可用，当前定位状态]
 2、通过CLLocationMnager获取当前位置
 */
@interface LocationManager : NSObject

+(LocationManager*)sharedManager;

-(void)checkLocationAuthorization;


@end

NS_ASSUME_NONNULL_END
