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


@interface MMLoginController ()


@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *phoneNumTextField;


@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UILabel *recommendPasswordLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *bottomLabel;





@end

@implementation MMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Login_Bg.jpg"]];
    [self initUI];
    

}
- (void)initUI{
    
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.phoneNumTextField];
    [self.bgView addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.recommendPasswordLabel];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.bottomLabel];

    
}


- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    CGFloat magin = 72;
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
    
    
    
    [self.recommendPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.loginButton.mas_centerX);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@150);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100);
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.height.mas_equalTo(@1.5);
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
    
    
    NSString * mdsPass = [@"test123" MD5Digest];
    
    
    [NetworkEntity postLoginWithPhotoNumber:@"rjw20051111@126.com" password:mdsPass deviceId:@"wwwookooikii" deviceType:@"1" success:^(id responseObject) {
        
        
        UIWindow *window  = [UIApplication sharedApplication].keyWindow;
        
        MMMainController *mainVC = [[MMMainController alloc] init];
        
        
        
        UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
        window.rootViewController = navigationVC;
        

        NSLog(@"responseObject  responseObject  responseObject%@",responseObject);
    } failure:^(NSError *failure) {
        
        
        
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
        _phoneNumTextField.placeholder  = @" Email";
        [_phoneNumTextField setValue:[UIColor colorWithHexString:@"fff100"] forKeyPath:@"_placeholderLabel.textColor"];
        [_phoneNumTextField setValue:[UIFont systemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
           
           
           
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
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
        
        //       [_phoneNumTextField.leftView SET]
    }
    
    return _phoneNumTextField;
    
}
- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @" password";
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
        
    }
    return _passwordTextField;
}
- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor colorWithHexString:@"00b6d8"];;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_loginButton addTarget:self action:@selector(pushHomeMainController:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 22;
        
    }
    return _loginButton;
    
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
