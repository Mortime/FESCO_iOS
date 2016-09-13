//
//  MMLoginController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/28.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMLoginController.h"
#import "MMMainController.h"
#import "NSString+MD5.h"
#import "UIViewController+HUD.h"
#import "NSData+AES.h"
#import "NSString+BASE64.h"


@interface MMLoginController ()


@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *phoneNumTextField;


@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UILabel *recommendPasswordLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *bottomLabel;





@end

@implementation MMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"Login_Bg.jpg"];
    self.view.layer.contents = (id) image.CGImage;
    
    
    
    
//    [self.view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_Bg.jpg"]]];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Login_Bg.jpg"]];
    [self initUI];
    
    NSLog(@"=======[UserInfoModel defaultUserInfo].password = %@",[UserInfoModel defaultUserInfo].password);

}
- (void)initUI{
    
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.phoneNumTextField];
    [self.bgView addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.recommendPasswordLabel];
    [self.bottomView addSubview:self.lineView];
    [self.bottomView addSubview:self.bottomLabel];

    
}


- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    CGFloat magin = 72;
    CGFloat bottomH = 20;
    if (MMIphone6Plus) {
        bottomH = 70;
    }
    if (MMIphone6) {
        bottomH = 50;
    }
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(90);
        make.width.mas_equalTo(@160);
        make.height.mas_equalTo(@100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImage.mas_bottom).offset(74);
        make.right.mas_equalTo(self.view.mas_right).offset(-magin);
        make.left.mas_equalTo(self.view.mas_left).offset(magin);
        make.height.mas_equalTo(@104);
        
    }];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.height.mas_equalTo(@40);
        
    }];
    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).offset(20);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.height.mas_equalTo(@40);
        
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-magin);
        make.left.mas_equalTo(self.view.mas_left).offset(magin);
        make.height.mas_equalTo(@44);
        
    }];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(bottomH);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        
    }];
    
    [self.recommendPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_top).offset(0);
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo(@150);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.recommendPasswordLabel.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.bottomView.mas_centerX);
        make.height.mas_equalTo(@1);
        make.left.mas_equalTo(self.bgView.mas_left);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.lineView.mas_centerX);
        make.height.mas_equalTo(@16);
        make.width.mas_equalTo(@150);
    }];

    

}

#pragma make --- Action
- (void)pushHomeMainController:(UIButton *)btn{
    
    
//    NSDictionary *param  = @{@"cust_Id": @"zhang",
//                             @"emp_Id":@"yatao",
//                             @"methodname":@"emp/loadEmpInfo.json"};
//    NSString *re = [NSString jsonToJsonStingWith:param];
//
//    
//    
//    return;
//    
//
//    NSLog(@"self.phone = %@",self.phoneNumTextField.text);
    
    if (self.phoneNumTextField.text == nil || [self.phoneNumTextField.text isEqualToString:@""]) {
//        [self showTotasViewWithMes:@"请输入密码"]; a
        
        
        
        NSLog(@"self.phone = %@",self.phoneNumTextField.text);
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入邮箱"];
        [toastView show];

        return;
    }
    
    if (self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""]) {
        //        [self showTotasViewWithMes:@"请输入密码"];
        
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入密码"];
        [toastView show];
        
        return;
    }
    
    // 密码使用AES加密
    NSData *data = [[NSData data] AES256EncryptWithKey:_passwordTextField.text];
    MMLog(@"data ======  ===========  = =============%@",data);
    
    NSString *aesStr = [NSString encodeBase64Data:data];
    MMLog(@"aesStr ======  ===========  = =============%@",aesStr);
    
    // 密码使用md5加密
//    NSString * mdsPass = [_passwordTextField.text MD5Digest];
    
    // 获取设备的UUID
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [self showHudInView:self.view hint:NSLocalizedString(@"登录中...", @"登录中...")];
    
    [NetworkEntity postLoginWithPhotoNumber:_phoneNumTextField.text password:_passwordTextField.text deviceId:idfv deviceType:@"1" success:^(id responseObject) {
        
        
        if ([[responseObject  objectForKey:@"SUCCESS"] isEqualToString:@"success"]) {
            // 登录成功后保存数据
            
            
            NSDate *localDate = [NSDate new];
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm "];
            NSString *loginTime =  [dateFormatter stringFromDate:localDate];
            
            // 基本数据保存
            NSMutableDictionary * loginInfo = [responseObject mutableCopy];
            [loginInfo setValue:_phoneNumTextField.text forKey:@"MM_phoneNum"];
            [loginInfo setValue:_passwordTextField.text forKey:@"MM_password"];
            [loginInfo setValue:loginTime forKey:@"MM_loginTime"];
            
            [[UserInfoModel defaultUserInfo] loginViewDic:loginInfo];
            [NetworkTool setHTTPHeaderField:[loginInfo  objectForKey:@"token"]];
            
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"登录成功"];
            [toastView show];
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            
            UIWindow *window  = [UIApplication sharedApplication].keyWindow;
            MMMainController *mainVC = [[MMMainController alloc] init];
            
            UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
            window.rootViewController = navigationVC;
        }
        else{
            NSString *msgError = [responseObject objectForKey:@"ERROR"];
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:msgError];
            [toastView show];
            [MBProgressHUD hideHUDForView:self.view animated:NO];
        }
        

        NSLog(@"responseObject  responseObject  responseObject%@",responseObject);
    } failure:^(NSError *failure) {
        
        NSLog(@"failure = %@",failure);
        
                    [MBProgressHUD hideHUDForView:self.view animated:NO];
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络连接失败"];
                [toastView show];
//        [self showTotasViewWithMes:@"网络连接失败"];
        
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ---- Lazy
- (UIImageView *)iconImage{
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"Login_Icon"];
        _iconImage.backgroundColor = [UIColor clearColor];
    }
    return _iconImage;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        
    }
    return _bgView;
}

- (UITextField *) phoneNumTextField {
    
    if (_phoneNumTextField == nil) {
        
        _phoneNumTextField    = [[UITextField alloc] init];
        _phoneNumTextField.font = [UIFont systemFontOfSize:16];
        _phoneNumTextField.textColor = [UIColor colorWithHexString:@"fff100"];
        _phoneNumTextField.placeholder  = @" 账号";
        [_phoneNumTextField setValue:[UIColor colorWithHexString:@"fff100"] forKeyPath:@"_placeholderLabel.textColor"];
        [_phoneNumTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
           
           
           
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
//        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@""];
        
        _phoneNumTextField.leftView = leftView;
        
        _phoneNumTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        //        _phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneNumTextField.backgroundColor = [UIColor blackColor];
        _phoneNumTextField.alpha = 0.45;
        
        _phoneNumTextField.layer.masksToBounds = YES;
        _phoneNumTextField.layer.cornerRadius = 5;
        
//        _phoneNumTextField.text = @"abc";
        
        //       [_phoneNumTextField.leftView SET]
    }
    
    return _phoneNumTextField;
    
}
- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @" 密码";
        [_passwordTextField setValue:[UIColor colorWithHexString:@"666666"] forKeyPath:@"_placeholderLabel.textColor"];
        [_passwordTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:16];
        _passwordTextField.textColor = [UIColor colorWithHexString:@"fff100"];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@""];
        
        //        _passwordTextField.textAlignment = NSTextAlignmentCenter;
        //        _passwordTextField.leftView.frame = CGRectMake(0, 0, 10, 10);
        _passwordTextField.leftView = leftView;
        
        // _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.secureTextEntry = YES;
        
        _passwordTextField.backgroundColor = [UIColor blackColor];
        _passwordTextField.alpha = 0.45;
        
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.cornerRadius = 5;
        
//        _passwordTextField.text = @"test123";
        
    }
    return _passwordTextField;
}
- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginButton addTarget:self action:@selector(pushHomeMainController:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 22;
        
    }
    return _loginButton;
    
}

- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor clearColor];
    }
    return _bottomView;
}

- (UILabel *)recommendPasswordLabel{
    if (_recommendPasswordLabel == nil) {
        _recommendPasswordLabel = [[UILabel alloc] init];
        _recommendPasswordLabel.text = @"Forgot password";
        _recommendPasswordLabel.font = [UIFont systemFontOfSize:14];
        _recommendPasswordLabel.textAlignment = NSTextAlignmentCenter;
        _recommendPasswordLabel.textColor = [UIColor whiteColor];
    }
    return _recommendPasswordLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor whiteColor];
    }
    return _lineView;
}

- (UILabel *)bottomLabel{
    if (_bottomLabel == nil) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.text = @"Welcome to Log on";
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = [UIColor whiteColor];
    }
    return _bottomLabel;
}


@end
