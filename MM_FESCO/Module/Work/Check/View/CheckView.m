//
//  CheckView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckView.h"
#import "DVVImagePickerControllerManager.h"
#import "popOutView.h"

#define kButtonW  (kMMWidth / 3)

#define kButtonH  50

#define kMapTypeW  50

@interface CheckView ()<BMKLocationServiceDelegate,BMKMapViewDelegate,UIImagePickerControllerDelegate>


@property (nonatomic, strong) UIView *bgTopView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *signResultLable;

@property (nonatomic, strong) UILabel *bigSignLable;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *timeLable;

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UIButton *scaleBoomButton; // 放大

@property (nonatomic, strong) UIButton *scaleReduceButton; // 缩小


@property (nonatomic,strong) UIView *bgView;

@property (nonatomic, strong) UIButton *standardButton; //  标准模式

@property (nonatomic, strong) UIButton *statelliteButton;  // 卫星模式


@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic,strong) UIButton *signUpButton; // 签到

@property (nonatomic, strong) UIButton *signOutButton; // 签退

@property (nonatomic, strong) UIButton *outButton; // 外勤

@property (nonatomic, assign) NSInteger signType; // 签到类型 1,签到; 2,签退; 3,外勤

@property (nonatomic,assign) CGFloat latitude;

@property (nonatomic,assign) CGFloat longitude;

@property (nonatomic, strong) popOutView *popView;


@property (nonatomic, strong) NSString *memoOut;



@end

@implementation CheckView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _btnArray = [NSMutableArray array];
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
    _mapView.scrollEnabled = YES;
    [self addSubview:self.mapView];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [BMKLocationService setLocationDistanceFilter:10];
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
//    _locService.desiredAccuracy = kCLLocationAccuracyBest;     
    //启动LocationService
    [_locService startUserLocationService];
    
    
    
//    [self addSubview:self.bgTopView];
//    [self.bgTopView addSubview:self.iconView];
//    [self.bgTopView addSubview:self.signResultLable];
//    [self.bgTopView addSubview:self.bigSignLable];
//    [self.bgTopView addSubview:self.lineView];
//    [self.bgTopView addSubview:self.timeLable];
    
    [self addSubview:self.scaleBoomButton];
    [self addSubview:self.scaleReduceButton];
    
    
    [self addSubview:self.signOutButton];
    [self addSubview:self.signUpButton];
    [self addSubview:self.outButton];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.standardButton];
    [self.bgView addSubview:self.statelliteButton];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(initData) userInfo:nil repeats:YES];
    
    MMLog(@"[[NSUserDefaults standardUserDefaults] objectForKey:kUsreIcon] = %@",[[NSUserDefaults standardUserDefaults] objectForKey:kUsreIcon]);
   
    UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kUsreIcon]];
    if (image) {
        self.iconView.image = image;
    }
    
    
}
//- (void)drawRect:(CGRect)rect{
//    //填充圆，无边框
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    UIColor *aColor = [UIColor redColor];
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    CGContextAddArc(context, 150, 30, 30, 0, 2*M_PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathFill);//绘制填充
//
//}
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
//    [self.bgTopView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_top).offset(0);
//        make.left.mas_equalTo(self.mas_left).offset(0);
//        make.right.mas_equalTo(self.mas_right);
//        make.height.mas_equalTo(@194);
//    }];
//    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgTopView.mas_left).offset(10);
//        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
//        make.height.mas_equalTo(@65);
//        make.width.mas_equalTo(@65);
//    }];
//    [self.signResultLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.bgTopView.mas_top).offset(25);
//        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-40);
//        make.height.mas_equalTo(@14);
//    }];
//    [self.bigSignLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.signResultLable.mas_bottom).offset(10);
//        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-60);
//        make.bottom.mas_equalTo(self.bgTopView.mas_bottom).offset(-44);
//    }];
//
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.bgTopView.mas_left).offset(3);
//        make.right.mas_equalTo(self.bgTopView.mas_right).offset(3);
//        make.bottom.mas_equalTo(self.bgTopView.mas_bottom).offset(0);
//        make.height.mas_equalTo(@1);
//    }];
//    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(self.bigSignLable.mas_bottom).offset(10);
//        make.right.mas_equalTo(self.signResultLable.mas_right);
//        make.height.mas_equalTo(@14);
//    }];
    
    
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
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
//    _latitude = userLocation.location.coordinate.latitude;
//    _longitude = userLocation.location.coordinate.longitude;
    
    [self transformationLongitude:userLocation.location.coordinate.longitude latitude:userLocation.location.coordinate.latitude];
    
    
    //普通态
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
}
- (void)transformationLongitude:(CGFloat)longitude  latitude:(CGFloat)latitude{
    
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = longitude - 0.0065, y = latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    _longitude = z * cos(theta);
    _latitude = z * sin(theta);
}
#pragma mark ---- Data

- (void)postNetWork{
    // 防止一个手机登录多个账号打卡
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kEmpIdKey]) {
    
        if ([[UserInfoModel defaultUserInfo].empId integerValue] != [[[NSUserDefaults standardUserDefaults] objectForKey:kEmpIdKey] integerValue]) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"该手机不能为此用户打卡!"];
            [toastView show];
            return;

        }
    }
    
    NSString *memo = @"";
    if (_signType == 1 || _signType == 2) {
        memo = @"";
    }else if (_signType == 3){
        if (_memoOut) {
            memo = _memoOut;
        }else{
            memo = @"";
        }
    }
    
    [NetworkEntity postSignUpTypeWithLongitude:_longitude latitude:_latitude type:_signType memo:memo success:^(id responseObject) {
        
        
        if (_signType == 3) {
            [self.popView removeFromSuperview];
        }
        
        NSString *msg = [responseObject objectForKey:@"message"];
        
        if ([msg isEqualToString:@"success"]) {
            NSString *showMsg = @"";
            if (_signType == 1 || _signType == 3) {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[NSDate date] forKey:kSignDate];
                
                NSString *numberStr = [[NSUserDefaults standardUserDefaults] objectForKey:kSingNumber];
                NSInteger number = [numberStr integerValue];
                number = number + 1;
                //                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[NSString stringWithFormat:@"%lu",number] forKey:kSingNumber];
                _bigSignLable.text = [NSString stringWithFormat:@"%lu",number];
 
            }
            if (_signType == 1) {
                
                showMsg = @"签到成功";
            }else if (_signType == 2){
                showMsg = @"签退成功";
            }else if (_signType == 3){
                showMsg = @"外勤签到成功";
            }
            // 保存empId
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:[UserInfoModel defaultUserInfo].empId forKey:kEmpIdKey];
            
            // 保存签到的日期中的日
        NSString * curTime = [NSDate dateOfDayWithCurrTime];
            NSLog(@"%@",curTime);
             [def setObject:curTime forKey:kSignUpTime];
            
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:showMsg];
            [toastView show];
            
            
        }else{
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:msg];
            [toastView show];
        }
        
        
        MMLog(@"SignUp=======responseObject======%@",responseObject);
        
    } failure:^(NSError *failure) {
        MMLog(@"SignUp=======failure======%@",failure);
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络连接失败"];
        [toastView show];
    }];
    
    
    
    
}

#pragma mark ----- ActionSignStatus
- (void)didSignButon:(UIButton *)btn{
    
    for (UIButton *btn1 in _btnArray) {
        
        if (btn1.tag == btn.tag) {
            
            btn1.alpha = 0.9;
            
        }else{
             btn1.alpha = 1;
            
        }
    
    }
    
    
    if (btn.tag == 500) {
        // 签到
        _signType = 1;
        [self postNetWork];
        
    }
    if (btn.tag == 501) {
        // 签退
        _signType = 2;
        [self postNetWork];
    }

    if (btn.tag == 502) {
        // 外勤
        _signType = 3;
        // 点击外勤弹出备注输入框
        [self popUI];
    }
    

}
- (void)popUI{
    
    self.popView = [[popOutView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _popView.backgroundColor = [UIColor clearColor];
    
    // 备注输入完成后Block回调
    [_popView dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField) {
        
        _memoOut = textField.text;
    }];
    
    // 按钮点击回调
    [_popView mm_setSignOutSelected:^(UIButton *button) {
        [self didClick:button];
    }];
    [self addSubview:_popView];
}

#pragma mark ----- Button Block

- (void)didClick:(UIButton *)sender{
    
    if (sender.tag == 900) {
        // 取消
        [self.popView removeFromSuperview];
    }
    if (sender.tag == 901) {
        // 确定
        [self postNetWork];
    }
}
#pragma mark --- ActionMapScale
-(void)didClickMapScale:(UIButton *)sender{
    if (sender.tag == 600) {
        // 放大
        _mapView.zoomLevel++;
        
    }
    if (sender.tag == 601) {
        // 缩小
        _mapView.zoomLevel--;
    }
    
}
#pragma  mark ---- ActionMapType
- (void)didClickMapType:(UIButton *)sender{
    
    MMLog(@"%d",sender.selected);
    if (sender.tag == 700) {
        // 地图
        _mapView.mapType = BMKMapTypeStandard;
        
        _standardButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_standardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _statelliteButton.backgroundColor = [UIColor whiteColor];
        [_statelliteButton setTitleColor:MM_MAIN_BACKGROUND_COLOR forState:UIControlStateNormal];
        
        [_scaleBoomButton setBackgroundImage:[UIImage imageNamed:@"MapView_Standard_Boom"] forState:UIControlStateNormal];
         [_scaleReduceButton setBackgroundImage:[UIImage imageNamed:@"MapView_Standard_Reduce"] forState:UIControlStateNormal];
        
        
    }
    if (sender.tag == 701) {
        // 卫星
       _mapView.mapType = BMKMapTypeSatellite;
        
        _statelliteButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_statelliteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _standardButton.backgroundColor = [UIColor whiteColor];
        [_standardButton setTitleColor:MM_MAIN_BACKGROUND_COLOR forState:UIControlStateNormal];
        
        [_scaleBoomButton setBackgroundImage:[UIImage imageNamed:@"MapView_Satellite-Boom"] forState:UIControlStateNormal];
        [_scaleReduceButton setBackgroundImage:[UIImage imageNamed:@"MapView_Satellite-Reduce"] forState:UIControlStateNormal];

    }

}
- (void)selectIcon:(UIGestureRecognizer *)ges{
    [DVVImagePickerControllerManager showImagePickerControllerFrom:self.parentVC delegate:self];
}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/uploadPic.json"];
    //2.上传文件
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"userHeader.png",@"uploadFile",[UserInfoModel defaultUserInfo].empId,@"emp_Id",[UserInfoModel defaultUserInfo].custId,@"cust_Id",nil];
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        //        NSData* imageData = UIImagePNGRepresentation(photoImage);
        NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* totalPath = [documentPath stringByAppendingPathComponent:@"userAvatarInfo"];
        
        //保存到 document
        [photeoData writeToFile:totalPath atomically:NO];
        
        MMLog(@"totalPath = %@",totalPath);
        
        //保存到 NSUserDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:totalPath forKey:@"avatarInfo"];
        
        
        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:totalPath];
        
        NSData *photeoData11 = UIImageJPEGRepresentation(selfPhoto, 0.5);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:photeoData11 forKey:kUsreIcon];
        
        //上传文件参数
        [formData appendPartWithFileData:photeoData11 name:@"uploadFile" fileName:@"userHeader.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
//        CGFloat progress = ;
        MMLog(@"==============oooooo%.2lf%%", 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        MMLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        MMLog(@"请求失败：%@",error);
        
    }];
    
    self.iconView.image = photoImage;
    
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
        _iconView.backgroundColor = [UIColor clearColor];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 32.5;
        _iconView.image = [UIImage imageNamed:@"People_placehode"];
        _iconView.userInteractionEnabled = YES;

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
       
        _bigSignLable.font = [UIFont boldSystemFontOfSize:80];
        _bigSignLable.textColor = [UIColor whiteColor];
        _bigSignLable.textAlignment = NSTextAlignmentRight;
        NSString *number = [[NSUserDefaults standardUserDefaults] objectForKey:kSingNumber];
        if ([number integerValue] > 0) {
            _bigSignLable.text = number;
        }else{
             _bigSignLable.text = @"0";
        }
        
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
        _timeLable.text = @" ";
        _timeLable.font = [UIFont systemFontOfSize:14];
        _timeLable.textColor = [UIColor whiteColor];
    }
    return _timeLable;
}

- (UIButton *)scaleBoomButton {
    
    if (_scaleBoomButton == nil) {
        _scaleBoomButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _scaleBoomButton.frame = CGRectMake(20, CGRectGetMaxY(self.bgView.frame) + 20, 30, 30);
        [_scaleBoomButton setBackgroundImage:[UIImage imageNamed:@"MapView_Standard_Boom"] forState:UIControlStateNormal];
        [_scaleBoomButton addTarget:self action:@selector(didClickMapScale:) forControlEvents:UIControlEventTouchUpInside];
        _scaleBoomButton.tag = 600;
    }
    return _scaleBoomButton;
    
}
- (UIButton *)scaleReduceButton {
    
    if (_scaleReduceButton == nil) {
        _scaleReduceButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _scaleReduceButton.frame = CGRectMake(20, CGRectGetMaxY(self.bgView.frame) + 20 + 30, 30, 30);
        [_scaleReduceButton setBackgroundImage:[UIImage imageNamed:@"MapView_Standard_Reduce"] forState:UIControlStateNormal];
        [_scaleReduceButton addTarget:self action:@selector(didClickMapScale:) forControlEvents:UIControlEventTouchUpInside];
        _scaleReduceButton.tag = 601;
    }
    return _scaleReduceButton;
    
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(20,20 , kMapTypeW, kMapTypeW)];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _bgView.layer.borderWidth = 1;
        _bgView.layer.shadowOffset = CGSizeMake(0, 2);
        _bgView.layer.shadowOpacity = 0.36;
        _bgView.layer.shadowRadius = 2;
    }
    return _bgView;
    
}

- (UIButton *)standardButton {
    
    if (_standardButton == nil) {
        _standardButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _standardButton.frame = CGRectMake(0, kMapTypeW / 2, kMapTypeW, kMapTypeW / 2);
        _standardButton.backgroundColor = [UIColor whiteColor];
        [_standardButton setTitleColor:MM_MAIN_BACKGROUND_COLOR forState:UIControlStateNormal];
        [_standardButton setTitle:@"地图" forState:UIControlStateNormal];
        _standardButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_standardButton addTarget:self action:@selector(didClickMapType:) forControlEvents:UIControlEventTouchUpInside];
        _standardButton.tag = 700;
        _standardButton.selected = YES;
    }
    return _standardButton;
    
}
- (UIButton *)statelliteButton {
    
    if (_statelliteButton == nil) {
        _statelliteButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _statelliteButton.frame = CGRectMake(0, 0, kMapTypeW, kMapTypeW / 2);
        _statelliteButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_statelliteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_statelliteButton setTitle:@"卫星" forState:UIControlStateNormal];
        _statelliteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_statelliteButton addTarget:self action:@selector(didClickMapType:) forControlEvents:UIControlEventTouchUpInside];
        _statelliteButton.tag = 701;
        _statelliteButton.layer.shadowColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _statelliteButton.layer.shadowOffset = CGSizeMake(0, 2);
        _statelliteButton.layer.shadowOpacity = 0.36;
        _statelliteButton.layer.shadowRadius = 2;
    }
    return _statelliteButton;
    
}


- (UIButton *)signOutButton {
    
    if (_signOutButton == nil) {
        _signOutButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _signOutButton.frame = CGRectMake(0, CGRectGetMaxY(self.mapView.frame), kButtonW, kButtonH);
        _signOutButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_signOutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_signOutButton setTitle:@"签退" forState:UIControlStateNormal];
        _signOutButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_signOutButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _signOutButton.tag = 501;
        [_btnArray addObject:_signOutButton];
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
        [_btnArray addObject:_signUpButton];
    }
    return _signUpButton;
    
}
- (UIButton *)outButton {
    
    if (_outButton == nil) {
        _outButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _outButton.frame = CGRectMake(CGRectGetMaxX(self.signUpButton.frame), self.signOutButton.frame.origin.y, kButtonW, kButtonH);
        _outButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_outButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_outButton setTitle:@"外勤" forState:UIControlStateNormal];
        _outButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_outButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
        _outButton.tag = 502;
        [_btnArray addObject:_outButton];
    }
    return _outButton;
    
}
- (void)dealloc{
//     [_locService stopUserLocationService];
}
@end
