//
//  MMLoginController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/28.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMLoginController.h"
#import "MMMainController.h"

@interface MMLoginController ()


@property (nonatomic, strong) UIImageView *iconImage;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITextField *phoneNumTextField;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UILabel *recommendPasswordLabel;

@property (nonatomic, strong) UIButton *regiestButton;



@end

@implementation MMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_Color(245, 245, 245);
    [self initUI];
    

}
- (void)initUI{
    
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.phoneNumTextField];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.passwordTextField];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.recommendPasswordLabel];
        [self.view addSubview:self.regiestButton];
    
}


- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    CGFloat magin = self.view.frame.size.width/7;
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(self.view.frame.size.height/6);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImage.mas_bottom).offset(30);
        make.right.mas_equalTo(self.view.mas_right).offset(-magin);
        make.left.mas_equalTo(self.view.mas_left).offset(magin);
        make.height.mas_equalTo(@101);
        
    }];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.height.mas_equalTo(@50);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.height.mas_equalTo(@1);
        
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.height.mas_equalTo(@50);
        
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-magin);
        make.left.mas_equalTo(self.view.mas_left).offset(magin);
        make.height.mas_equalTo(@44);
        
    }];
    
    
    
    [self.recommendPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(15);
        make.left.mas_equalTo(self.loginButton.mas_left).offset(0);
        make.height.mas_equalTo(@25);
        
    }];
    
    
    
    [self.regiestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(80);
        make.right.mas_equalTo(self.view.mas_right).offset(-80);
        make.left.mas_equalTo(self.view.mas_left).offset(80);
        make.height.mas_equalTo(@30);
        
    }];
}

#pragma make --- Action
- (void)pushHomeMainController:(UIButton *)btn{
    
    
    
    UIWindow *window  = [UIApplication sharedApplication].keyWindow;
    
    MMMainController *mainVC = [[MMMainController alloc] init];
    
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    window.rootViewController = navigationVC;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark ---- Lazy
- (UIImageView *)iconImage{
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
        _iconImage.image = [UIImage imageNamed:@"LoginIcon"];
        _iconImage.backgroundColor = [UIColor clearColor];
    }
    return _iconImage;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 5;
    }
    return _bgView;
}

- (UITextField *) phoneNumTextField {
    
    if (_phoneNumTextField == nil) {
        
        _phoneNumTextField    = [[UITextField alloc] init];
        _phoneNumTextField.font = [UIFont systemFontOfSize:17];
        _phoneNumTextField.textColor = [UIColor colorWithRed:(51)/255.f green:(51)/255.f blue:(51)/255.f alpha:1.f];
        _phoneNumTextField.placeholder  = @"  用户名";
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 20)];
        leftView.image = [UIImage imageNamed:@"LoginUser"];
        
        _phoneNumTextField.leftView = leftView;
        
        _phoneNumTextField.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
        //        _phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        _phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        //       [_phoneNumTextField.leftView SET]
    }
    
    return _phoneNumTextField;
    
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        _lineView.alpha = 0.2;
    }
    return _lineView;
}
- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"  密码";
        
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:17];
        _passwordTextField.textColor = [UIColor colorWithRed:(51)/255.f green:(51)/255.f blue:(51)/255.f alpha:1.f];
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 20)];
        leftView.image = [UIImage imageNamed:@"LoginPassword"];
        
        //        _passwordTextField.textAlignment = NSTextAlignmentCenter;
        //        _passwordTextField.leftView.frame = CGRectMake(0, 0, 10, 10);
        _passwordTextField.leftView = leftView;
        
        // _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.secureTextEntry = YES;
        
    }
    return _passwordTextField;
}
- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = [UIColor colorWithRed:(63)/255.f green:(153)/255.f blue:(235)/255.f alpha:1.f];;
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_loginButton addTarget:self action:@selector(pushHomeMainController:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 3;
        
    }
    return _loginButton;
    
}

- (UILabel *)recommendPasswordLabel{
    if (_recommendPasswordLabel == nil) {
        _recommendPasswordLabel = [[UILabel alloc] init];
        _recommendPasswordLabel.text = @"记住密码";
        _recommendPasswordLabel.font = [UIFont systemFontOfSize:12];
        _recommendPasswordLabel.textColor = [UIColor colorWithRed:(63)/255.f green:(153)/255.f blue:(235)/255.f alpha:1.f];
    }
    return _recommendPasswordLabel;
}

- (UIButton *)regiestButton {
    if (_regiestButton == nil) {
        _regiestButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _regiestButton.backgroundColor = [UIColor colorWithRed:(63)/255.f green:(153)/255.f blue:(235)/255.f alpha:1.f];;
        [_regiestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_regiestButton setTitle:@"注册" forState:UIControlStateNormal];
        _regiestButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _regiestButton.layer.masksToBounds = YES;
        _regiestButton.layer.cornerRadius = 3;
        
    }
    return _regiestButton;
    
}


@end
