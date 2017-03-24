//
//  MMFindPasswordController.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/3/24.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "MMFindPasswordController.h"
#import "MMRegisterTextFiledView.h"

#define kTextFiledH  44

#define kMarginH   15

#define h_iconViewHeight [UIScreen mainScreen].bounds.size.height *170/667

@interface MMFindPasswordController ()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UIView *iconBgView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *iconTopBgView;

@property (nonatomic, strong) UIView *bgTextFiled;

@property (nonatomic, strong) MMRegisterTextFiledView *mailTextFiled;

@property (nonatomic, strong) MMRegisterTextFiledView *userNameTextFiled;

@property (nonatomic, strong) MMRegisterTextFiledView *passwordTextFiled;

@property (nonatomic,strong) MMRegisterTextFiledView *codeNumTextFiled;

@property (nonatomic, strong) MMRegisterTextFiledView *confirmPasswordTextFiled;

@property (nonatomic, strong) UIButton *codeNumButton;

@property (nonatomic, strong) UIButton *registButton;

@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic ,strong) NSString *mailStr;
@property (nonatomic ,strong) NSString *userName;
@property (nonatomic ,strong) NSString *password;
@property (nonatomic ,strong) NSString *codeNum;


@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign)  NSInteger ValidateCode;


@property (nonatomic, assign) int codeTime;
@end

@implementation MMFindPasswordController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopPainting];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    _codeTime = 60;
    [self initUI];
    [self addNotify];
}
- (void)initUI{
    
    [self.view addSubview:self.headerImageView];
    [self.view addSubview:self.backButton];
    [self.view addSubview:self.iconBgView];
    [self.view addSubview:self.iconTopBgView];
    [self.iconTopBgView addSubview:self.iconImageView];
    [self.view addSubview:self.iconImageView];
    
    [self.view addSubview:self.bgTextFiled];
    [self.bgTextFiled addSubview:self.codeNumTextFiled];
    [self.bgTextFiled addSubview:self.codeNumButton];
    [self.bgTextFiled addSubview:self.mailTextFiled];
    [self.bgTextFiled addSubview:self.userNameTextFiled];
    [self.bgTextFiled addSubview:self.passwordTextFiled];
    [self.bgTextFiled addSubview:self.confirmPasswordTextFiled];
    [self.view addSubview:self.registButton];
}
- (void)viewWillLayoutSubviews{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@180);
    }];
    
    [self.iconBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headerImageView.mas_centerX);
        make.centerY.mas_equalTo(self.headerImageView.mas_centerY).offset(10);
        make.height.mas_equalTo(@133);
        make.width.mas_equalTo(150);
    }];
    [self.iconTopBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headerImageView.mas_centerX).offset(-10);
        make.centerY.mas_equalTo(self.headerImageView.mas_centerY).offset(0);
        make.height.mas_equalTo(@133);
        make.width.mas_equalTo(@150);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconTopBgView.mas_centerX);
        make.centerY.mas_equalTo(self.iconTopBgView.mas_centerY);
        make.height.mas_equalTo(@62);
        make.width.mas_equalTo(@100);
    }];
    
    [self.bgTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImageView.mas_bottom).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@295);
        
    }];
    [self.mailTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTextFiled.mas_top).offset(0);
        make.left.mas_equalTo(self.bgTextFiled.mas_left).offset(0);
        make.right.mas_equalTo(self.bgTextFiled.mas_right).offset(0);
        make.height.mas_equalTo(@kTextFiledH);
        
    }];
    [self.codeNumTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mailTextFiled.mas_bottom).offset(kMarginH);
        make.left.mas_equalTo(self.mailTextFiled.mas_left).offset(0);
        make.right.mas_equalTo(self.mailTextFiled.mas_right).offset(0);
        make.height.mas_equalTo(@kTextFiledH);
        
    }];
    [self.codeNumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeNumTextFiled.mas_top);
        make.bottom.mas_equalTo(self.codeNumTextFiled.mas_bottom);
        make.right.mas_equalTo(self.codeNumTextFiled.mas_right).offset(-10);
        
    }];
    [self.userNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeNumTextFiled.mas_bottom).offset(kMarginH);
        make.left.mas_equalTo(self.mailTextFiled.mas_left).offset(0);
        make.right.mas_equalTo(self.mailTextFiled.mas_right).offset(0);
        make.height.mas_equalTo(@kTextFiledH);
        
    }];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userNameTextFiled.mas_bottom).offset(kMarginH);
        make.left.mas_equalTo(self.mailTextFiled.mas_left).offset(0);
        make.right.mas_equalTo(self.mailTextFiled.mas_right).offset(0);
        make.height.mas_equalTo(@kTextFiledH);
        
    }];
    [self.confirmPasswordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextFiled.mas_bottom).offset(kMarginH);
        make.left.mas_equalTo(self.mailTextFiled.mas_left).offset(0);
        make.right.mas_equalTo(self.mailTextFiled.mas_right).offset(0);
        make.height.mas_equalTo(@kTextFiledH);
        
    }];
    
    
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmPasswordTextFiled.mas_bottom).offset(40);
        make.left.mas_equalTo(self.mailTextFiled.mas_left).offset(0);
        make.right.mas_equalTo(self.mailTextFiled.mas_right).offset(0);
        make.height.mas_equalTo(@kTextFiledH);
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --- Action
- (void)initWithTextFile:(UITextField *)textFiled indexTag:(NSInteger )indexTag{
    if (indexTag == 4000) {
        // 邮箱
        MMLog(@"textFiled == %@",textFiled.text);
        _mailStr = textFiled.text;
        MMLog(@"邮箱");
    }
    if (indexTag == 4001) {
        //  账户
        MMLog(@"账户");
        _userName = textFiled.text;
    }
    
    if (indexTag == 4002) {
        // 密码
        MMLog(@"密码");
        _password = textFiled.text;
    }
    
    if (indexTag == 4003) {
        // 验证码
        MMLog(@"验证码");
        _codeNum = textFiled.text;
    }
    
}
- (void)didClick{
    [_passwordTextFiled.rightTextFiled resignFirstResponder];
    if (_mailStr == nil || [_mailStr isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入邮箱"];
        return;
    }
    if (_codeNum == nil || [_codeNum isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入验证码"];
        return;
    }if (_userName == nil || [_userName isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入账户"];
        return;
    }if (_password == nil || [_password isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入密码"];
        return;
    }
    // 本地判断验证码是否正确
    if (_ValidateCode != [_codeNum integerValue]) {
        [self showTotasViewWithMes:@"请输入正确验证码"];
        return;
        
    }
    [NetworkEntity postFindPassworkWithMail:_mailStr userName:_userName password:_password success:^(id responseObject) {
        MMLog(@"RegisterNumber ========responseObject ============%@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"already exist"]) {
            [self showTotasViewWithMes:@"该用户已经存在"];
            return;
        }
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            [self showTotasViewWithMes:@"找回密码成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }

    } failure:^(NSError *failure) {
        MMLog(@"RegisterNumber ========failure ============%@",failure);
        [self showTotasViewWithMes:@"找回密码失败"];
    }];

}
- (void)pushBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didClickCodeNum{
    MMLog(@"点击了发送验证吗");
    _codeTime = 60;
    [self.mailTextFiled.rightTextFiled resignFirstResponder];
    
    
    if (_mailStr == nil || [_mailStr isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入邮箱"];
        return;
    }
    // 验证邮箱和手机号
    if (!([_mailStr isValidateEmail]||[_mailStr checkTel])) {
        [self showTotasViewWithMes:@"请输入正确的邮箱或手机号"];
        return;
    }
    
    self.codeNumButton.userInteractionEnabled = NO;
    [self startPainting];
    
    [NetworkEntity postFindPasswordCodeNumberWithMail:_mailStr success:^(id responseObject) {
        MMLog(@"RegisterCodeNumber ========responseObject ============%@",responseObject);
        if (responseObject) {
            NSArray *allkey = [responseObject allKeys];
            
            for (NSString *str in allkey) {
                if ([str isEqualToString:@"ValidateCode"]) {
                    [self showTotasViewWithMes:@"验证码发送成功"];
                    _ValidateCode = [[responseObject objectForKey:@"ValidateCode"] integerValue];
                    return ;
                    
                }
            }
            
            if ([[responseObject objectForKey:@"message"] isEqualToString:@"invalid email address"] || [[responseObject objectForKey:@"message"] isEqualToString:@"invalid phone number"]) {
                [self showTotasViewWithMes:@"系统没有信息,请联系HR"];
                self.codeNumButton.userInteractionEnabled = YES;
                [self  stopPainting];
                [self.codeNumButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                return;
            }
            if ([[responseObject objectForKey:@"message"] isEqualToString:@"already exist"]) {
                [self showTotasViewWithMes:@"该用户已经存在"];
                self.codeNumButton.userInteractionEnabled = YES;
                [self  stopPainting];
                [self.codeNumButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                return;
            }
        }
    } failure:^(NSError *failure) {
        MMLog(@"RegisterCodeNumber ========failure ============%@",failure);
        self.codeNumButton.userInteractionEnabled = YES;
        [self  stopPainting];
        [self.codeNumButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self showTotasViewWithMes:@"网络错误"];
    }];
}
#pragma mark ---- Lazy
- (UIImageView *)headerImageView{
    if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.image = [UIImage imageNamed:@"Regist_BG"];
    }
    return _headerImageView;
}

- (UIView *)iconBgView{
    if (_iconBgView == nil) {
        _iconBgView = [[UIView alloc] init];
        _iconBgView.backgroundColor = [UIColor blackColor];
        _iconBgView.alpha = 0.2;
        
    }
    return _iconBgView;
}
- (UIView *)iconTopBgView{
    if (_iconTopBgView == nil) {
        _iconTopBgView = [[UIView alloc] init];
        _iconTopBgView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _iconTopBgView.alpha = 0.95;
        
    }
    return _iconTopBgView;
}

- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"Register_Icon"];
    }
    return _iconImageView;
}

- (UIView *)bgTextFiled{
    if (_bgTextFiled == nil) {
        _bgTextFiled = [[UIView alloc] init];
        _bgTextFiled.backgroundColor = [UIColor clearColor];
        
        
    }
    return _bgTextFiled;
}

- (MMRegisterTextFiledView *)mailTextFiled{
    if (_mailTextFiled == nil) {
        _mailTextFiled = [[MMRegisterTextFiledView alloc] init];
        _mailTextFiled.leftTitle = @"邮箱或手机号";
        _mailTextFiled.tag = 4000;
        [_mailTextFiled MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
            
        }];
    }
    return _mailTextFiled;
}
- (MMRegisterTextFiledView *)userNameTextFiled{
    if (_userNameTextFiled == nil) {
        _userNameTextFiled = [[MMRegisterTextFiledView alloc] init];
        _userNameTextFiled.leftTitle = @"登录账户";
        _userNameTextFiled.tag = 4001;
        [_userNameTextFiled MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
            
        }];
    }
    return _userNameTextFiled;
}

- (MMRegisterTextFiledView *)passwordTextFiled{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled = [[MMRegisterTextFiledView alloc] init];
        _passwordTextFiled.leftTitle = @"新密码";
        _passwordTextFiled.tag = 4002;
        _passwordTextFiled.rightTextFiled.secureTextEntry = YES;
        [_passwordTextFiled MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
            
        }];
    }
    return _passwordTextFiled;
}
- (MMRegisterTextFiledView *)confirmPasswordTextFiled{
    if (_confirmPasswordTextFiled == nil) {
        _confirmPasswordTextFiled = [[MMRegisterTextFiledView alloc] init];
        _confirmPasswordTextFiled.leftTitle = @"确认密码";
        _confirmPasswordTextFiled.tag = 4004;
        _confirmPasswordTextFiled.rightTextFiled.secureTextEntry = YES;
        [_confirmPasswordTextFiled MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
            
        }];
    }
    return _confirmPasswordTextFiled;
}


- (MMRegisterTextFiledView *)codeNumTextFiled{
    if (_codeNumTextFiled == nil) {
        _codeNumTextFiled = [[MMRegisterTextFiledView alloc] init];
        _codeNumTextFiled.leftTitle = @"验证码";
        _codeNumTextFiled.placeHold = @"请输入验证码";
        _codeNumTextFiled.tag = 4003;
        [_codeNumTextFiled MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
            
        }];
    }
    return _codeNumTextFiled;
}

- (UIButton *)registButton{
    if (_registButton == nil) {
        _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registButton setTitle:@"找回密码" forState:UIControlStateNormal];
        [_registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registButton addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
        //        [_registButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _registButton;
}
- (UIButton *)codeNumButton{
    if (_codeNumButton == nil) {
        _codeNumButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeNumButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeNumButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_codeNumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeNumButton addTarget:self action:@selector(didClickCodeNum) forControlEvents:UIControlEventTouchUpInside];
        //        [_registButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _codeNumButton;
}
- (UIButton *)backButton{
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor clearColor];
        _backButton.frame = CGRectMake(20, 20, 24, 24);
        [_backButton setImage:[UIImage imageNamed:@"side"] forState:UIControlStateNormal];
        [_backButton setImage:[UIImage imageNamed:@"side"] forState:UIControlStateHighlighted];
        
        [_backButton addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
        //        [_registButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _backButton;
}

// 定时器执行的方法
- (void)function:(NSTimer *)paramTimer{
    
    NSLog(@"定时器执行的方法");
    if (_codeTime < 0) {
        [self.codeNumButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeNumButton.userInteractionEnabled = YES;
        [self stopPainting];
        
    }else {
        NSString *str = [NSString stringWithFormat:@"%ds",_codeTime];
        [self.codeNumButton setTitle:str forState:UIControlStateNormal];
        _codeTime--;
    }
    
}

// 开始定时器
- (void) startPainting{
    
    // 定义一个NSTimer
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(function:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    //    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
    //                                                  target:self
    //                                                selector:@selector(function:)  userInfo:nil
    //                                                 repeats:YES];
}

// 停止定时器
- (void) stopPainting{
    if (self.timer != nil){
        // 定时器调用invalidate后，就会自动执行release方法。不需要在显示的调用release方法
        [self.timer invalidate];
    }
}




- (void)showTotasViewWithMes:(NSString *)message{
    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:message];
    [toastView show];
}

#pragma mark - notify

- (void)addNotify {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(keybardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(keyboardWillHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keybardWillShow:(NSNotification *)notify
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.bounds = CGRectMake(0,  h_iconViewHeight , self.view.bounds.size.width, self.view.bounds.size.height);
    }];
    //    CGRect frame = self.view.bounds;
    //    frame.origin.y = h_iconViewHeight ;
    //    _headerImageView.frame = frame;
}

-(void)keyboardWillHidden
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect bounds = self.view.bounds;
        bounds.origin = CGPointZero;
        self.view.bounds = bounds;
    }];
    //    CGRect frame = self.view.bounds;
    //    _headerImageView.frame = frame;
}
- (void)dealloc{
    [self  stopPainting];
}
@end
