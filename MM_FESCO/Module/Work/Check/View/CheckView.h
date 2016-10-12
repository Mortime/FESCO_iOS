//
//  CheckView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKMapView.h>

@interface CheckView : UIView


@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) BMKLocationService *locService;

@end
