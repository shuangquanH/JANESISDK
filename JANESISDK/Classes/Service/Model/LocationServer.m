//
//  LocationServer.m
//  AFNetworking
//
//  Created by apple on 2018/4/20.
//

#import "LocationServer.h"
#import <CoreLocation/CoreLocation.h>

static  CLLocationManager *locationmanager;//定位服务

@implementation LocationServer

+ (void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        [locationmanager requestAlwaysAuthorization];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
        
    }
}

@end
