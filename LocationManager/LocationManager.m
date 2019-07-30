//
//  LocationManager.m
//  LocationManager
//
//  Created by MOYO on 2019/7/30.
//  Copyright © 2019年 songwentao. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager *manager;


@end

@implementation LocationManager




+ (LocationManager *)sharedManager{
    static LocationManager *location;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [[LocationManager alloc]init];
    });
    return location;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
    }
    return self;
}


-(void)checkLocationAuthorization{
    //判断系统是否开启定位服务
    if (![CLLocationManager locationServicesEnabled]) {
        //定位不可用
    }
    /*
     kCLAuthorizationStatusNotDetermined  //用户没有选择是否要使用定位服务（弹框没选择，或者根本没有弹框）
     kCLAuthorizationStatusRestricted          //定位服务授权状态受限制，可能由于活动限制了定位服务，并且用户不能改变当前的权限，这个状态有可能不是用户拒绝的，但是也有可能是用户拒绝的
     kCLAuthorizationStatusDenied               //用户在设置中关闭定位功能，或者用户明确的在弹框之后选择禁止定位
     kCLAuthorizationStatusAuthorized        //用户已经明确使用定位功能
     kCLAuthorizationStatusAuthorizedWhenInUse  //用户在使用期间允许使用定位功能
     kCLAuthorizationStatusAuthorizedAlways          //App始终允许使用定位功能
     
     */
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        //使用期间可用定位
        [self.manager requestWhenInUseAuthorization];
    }
}

//改变授权状态的代理
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusDenied) {
        
    }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.manager startUpdatingLocation];
    }
}

//更新位置信息-经纬度
/*
    涉及到的类包括：
 CLLocation :位置的地理信息(经纬度、海拔等)
 CLPlacemark: 地标信息（省市街道）
 CLGeocoder:CLLocation和CLPlacemark之间的转换
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations firstObject];
    
    CLGeocoder *coder = [[CLGeocoder alloc]init];
    
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //得到地标信息
    }];
    [self.manager stopUpdatingHeading];
}



@end
