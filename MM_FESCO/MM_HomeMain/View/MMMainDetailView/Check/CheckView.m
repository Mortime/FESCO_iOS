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

#define kButtonW  (kMMWidth / 3)

#define kButtonH  50

@interface CheckView ()<BMKLocationServiceDelegate,BMKMapViewDelegate>

@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKMapView *mapView;

@property (nonatomic, strong) UIView *bgTopView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *signResultLable;

@property (nonatomic, strong) UILabel *bigSignLable;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *timeLable;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic,strong) UIButton *signUpButton;

@property (nonatomic, strong) UIButton *signOutButton;

@property (nonatomic, strong) UIButton *outButton;




@end

@implementation CheckView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}
- (void)initUI{
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 50)];
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
    [self.bgTopView addSubview:self.bigSignLable];
    [self.bgTopView addSubview:self.lineView];
    [self.bgTopView addSubview:self.timeLable];
    [self addSubview:self.signOutButton];
    [self addSubview:self.signUpButton];
    [self addSubview:self.outButton];
    
    
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
        make.height.mas_equalTo(@194);
    }];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
        make.height.mas_equalTo(@80);
        make.width.mas_equalTo(@80);
    }];
    [self.signResultLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(35);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-40);
        make.height.mas_equalTo(@14);
    }];
    [self.bigSignLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signResultLable.mas_bottom).offset(10);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-60);
        make.bottom.mas_equalTo(self.bgTopView.mas_bottom).offset(-34);
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(3);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(3);
        make.bottom.mas_equalTo(self.bgTopView.mas_bottom).offset(0);
        make.height.mas_equalTo(@1);
    }];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bigSignLable.mas_bottom).offset(10);
        make.right.mas_equalTo(self.signResultLable.mas_right);
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

#pragma mark ----- ActionTag
- (void)didSignButon:(UIButton *)btn{
    if (btn.tag == 500) {
        // 签到
    }
    if (btn.tag == 501) {
        // 签退
    }

    if (btn.tag == 502) {
        // 外勤
    }

}
#pragma mark ----- Lazy 加载
- (UIView *)bgTopView{
    if (_bgTopView == nil) {
        _bgTopView = [[UIView alloc] init];
        _bgTopView.backgroundColor = [UIColor blackColor];
        _bgTopView.alpha = 0.8;
        
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
        _signResultLable.text = @"今日完成签到";
        _signResultLable.font = [UIFont systemFontOfSize:14];
        _signResultLable.textColor = [UIColor whiteColor];
        _signResultLable.textAlignment = NSTextAlignmentRight;
    }
    return _signResultLable;
}
- (UILabel *)bigSignLable{
    if (_bigSignLable == nil) {
        _bigSignLable = [[UILabel alloc]init];
        _bigSignLable.text = @"1";
        _bigSignLable.font = [UIFont boldSystemFontOfSize:80];
        _bigSignLable.textColor = [UIColor whiteColor];
        _bigSignLable.textAlignment = NSTextAlignmentRight;
    }
    return _bigSignLable;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB_Color(214, 214, 214);
        
    }
    return _lineView;
}

- (UILabel *)timeLable{
    if (_timeLable == nil) {
        _timeLable = [[UILabel alloc]init];
        _timeLable.text = @"当前时间: 8********8";
        _timeLable.font = [UIFont systemFontOfSize:14];
        _timeLable.textColor = [UIColor whiteColor];
    }
    return _timeLable;
}

- (UIButton *)signOutButton {
    
    if (_signOutButton == nil) {
        _signOutButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _signOutButton.frame = CGRectMake(0, CGRectGetMaxY(self.mapView.frame), kButtonW, kButtonH);
        _signOutButton.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
        [_signOutButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_signOutButton setTitle:@"签退" forState:UIControlStateNormal];
        _signOutButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signOutButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _signOutButton.tag = 501;
    }
    return _signOutButton;
    
}


- (UIButton *)signUpButton {
    
    if (_signUpButton == nil) {
        _signUpButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _signUpButton.frame = CGRectMake(CGRectGetMaxX(self.signOutButton.frame), self.signOutButton.frame.origin.y, kButtonW, kButtonH);
        _signUpButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signUpButton setTitle:@"签到" forState:UIControlStateNormal];
        _signUpButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signUpButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _signUpButton.tag = 500;
    }
    return _signUpButton;
    
}
- (UIButton *)outButton {
    
    if (_outButton == nil) {
        _outButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _outButton.frame = CGRectMake(CGRectGetMaxX(self.signUpButton.frame), self.signOutButton.frame.origin.y, kButtonW, kButtonH);
        _outButton.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
        [_outButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_outButton setTitle:@"外勤" forState:UIControlStateNormal];
        _outButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_outButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _outButton.tag = 502;
    }
    return _outButton;
    
}

@end
