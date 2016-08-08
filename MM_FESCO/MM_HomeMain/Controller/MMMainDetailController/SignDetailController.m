//
//  SignDetailController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SignDetailController.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKMapView.h>



@interface SignDetailController ()<BMKLocationServiceDelegate>

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKMapView *mapView;

@end

@implementation SignDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mapView];
    
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
    //普通态
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    //普通态
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
