//
//  CheckView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckView.h"
#import <BaiduMapAPI/BMKLocationService.h>
#import <BaiduMapAPI/BMKMapView.h>
#import "NSDate+Category.h"

@interface CheckView ()<BMKLocationServiceDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) UIView *bgTopView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *signResultLable;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bgBottomView;

@property (nonatomic, strong) UILabel *timeLable;

@property (nonatomic, strong) NSTimer *timer;




@end

@implementation CheckView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64 + 150, self.width, 300)];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.compassPosition = CGPointMake(100, 100);
    _mapView.zoomLevel = 19.1; //地图等级，数字越大越清晰
    [self addSubview:self.mapView];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [BMKLocationService setLocationDistanceFilter:10];
    //启动LocationService
    [_locService startUserLocationService];
    
    
    
    [self addSubview:self.bgTopView];
    [self.bgTopView addSubview:self.iconView];
    [self.bgTopView addSubview:self.signResultLable];
    [self.bgTopView addSubview:self.lineView];
    [self addSubview:self.bgBottomView];
    [self.bgBottomView addSubview:self.timeLable];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(initData) userInfo:nil repeats:YES];

}
- (void)initData{
    
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString * na = [df stringFromDate:currentDate];
    self.timeLable.text = na;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@100);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
        make.height.mas_equalTo(@80);
        make.width.mas_equalTo(@80);
    }];
    [self.signResultLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(50);
        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
        make.height.mas_equalTo(@14);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(3);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(3);
        make.bottom.mas_equalTo(self.bgTopView.mas_bottom).offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.bgBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.bgBottomView.mas_left).offset(50);
        make.centerY.mas_equalTo(self.bgBottomView.mas_centerY);
        make.height.mas_equalTo(@14);
    }];
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

- (UIView *)bgTopView{
    if (_bgTopView == nil) {
        _bgTopView = [[UIView alloc] init];
        _bgTopView.backgroundColor = [UIColor clearColor];
        
    }
    return _bgTopView;
}
- (UIImageView *)iconView{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = RGB_Color(76, 129, 181);
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 40;
    }
    return _iconView;
}
- (UILabel *)signResultLable{
    if (_signResultLable == nil) {
        _signResultLable = [[UILabel alloc]init];
        _signResultLable.text = @"今日完成签到2次";
        _signResultLable.font = [UIFont systemFontOfSize:14];
        _signResultLable.textColor = RGB_Color(67, 67, 67);
    }
    return _signResultLable;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB_Color(214, 214, 214);
        
    }
    return _lineView;
}

- (UIView *)bgBottomView{
    if (_bgBottomView == nil) {
        _bgBottomView = [[UIView alloc] init];
        _bgBottomView.backgroundColor = [UIColor clearColor];
        
    }
    return _bgBottomView;
}

- (UILabel *)timeLable{
    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc]init];
        _timeLable.text = @"当前时间: 8********8";
        _timeLable.font = [UIFont systemFontOfSize:14];
        _timeLable.textColor = RGB_Color(67, 67, 67);
    }
    return _timeLable;
}

@end
