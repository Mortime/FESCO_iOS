//
//  MMLoginController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/7/28.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMLoginController.h"
#import "NSString+MD5.h"
#import "UIViewController+HUD.h"
#import "NSData+AES.h"
#import "NSString+BASE64.h"
#import "RegisterController.h"
#import "DVVTabBarController.h"

#import "MMMainController.h"
#import "BuffetController.h"
#import "NewsController.h"
#import "ToolsController.h"
#import "MyController.h"
#import "ApprovalController.h"
#import "ReimburseController.h"
#import "PhoneListController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MMFindPasswordController.h"



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

@property (nonatomic, strong) UILabel *VLabel;






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
    [self.bottomView addSubview:self.VLabel];

    
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
    [self.VLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView.mas_bottom);
        make.centerX.mas_equalTo(self.lineView.mas_centerX);
        make.height.mas_equalTo(@13);
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
        
        
        
        MMLog(@"self.phone = %@",self.phoneNumTextField.text);
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
            
            // 登录环信
            NSString *EEMID = [NSString stringWithFormat:@"zrfesco_%@",[UserInfoModel defaultUserInfo].empId];
            EMError *error = [[EMClient sharedClient] loginWithUsername:EEMID password:[UserInfoModel defaultUserInfo].loginPasswordMD5];
            if (!error) {
                MMLog(@"环信登录成功");
                // 设置自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
            }
            else{
                MMLog(@"环信登录失败 %@",error);
            }

//            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
//            if (!isAutoLogin) {
//                EMError *error = [[EMClient sharedClient] loginWithUsername:EEMID password:[UserInfoModel defaultUserInfo].loginPasswordMD5];
//                if (!error) {
//                    MMLog(@"环信登录成功");
//                    // 设置自动登录
//                    [[EMClient sharedClient].options setIsAutoLogin:YES];
//                    
//                }
//                else{
//                    MMLog(@"环信登录失败 %@",error);
//                }
//
//            }

            
            // 加载用户头像
            [self getUserIcon];
            
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"登录成功"];
            [toastView show];
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            
            // JPush 注册别名
            if ([UserInfoModel defaultUserInfo].empId) {
                NSString *aliasStr = [NSString stringWithFormat:@"%@",[UserInfoModel defaultUserInfo].empId];
                MMLog(@"[UserInfoModel defaultUserInfo].empId == %@",[UserInfoModel defaultUserInfo].empId);
                [JPUSHService setTags:nil alias:aliasStr fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    NSString *callbackString =
                    [NSString stringWithFormat:@"%d, \niTags: %@, \niAlias: %@\n", iResCode,
                     iTags, iAlias];
                    MMLog(@"TagsAlias回调:%@", callbackString);
                }];
            
            }
            
            UIWindow *window  = [UIApplication sharedApplication].keyWindow;
            DVVTabBarController *mainVC = [self homeTabBarView];
            window.rootViewController = mainVC;
        }
        else{
            NSString *msgError = [responseObject objectForKey:@"ERROR"];
            if ([msgError isEqualToString:@"get token error."]) {
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"用户名或密码错误"];
                [toastView show];
                [MBProgressHUD hideHUDForView:self.view animated:NO];
 
            }
            }
        

        MMLog(@"responseObject  responseObject  responseObject%@",responseObject);
    } failure:^(NSError *failure) {
        
        MMLog(@"failure = %@",failure);
        
                    [MBProgressHUD hideHUDForView:self.view animated:NO];
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络连接失败"];
                [toastView show];
//        [self showTotasViewWithMes:@"网络连接失败"];
        
    }];

}
- (void)getUserIcon{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData *cerData = [[NSData alloc] initWithBase64EncodedString:kHttpsCerBase64 options:0];
    NSSet * certSet = [[NSSet alloc] initWithObjects:cerData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    [securityPolicy setPinnedCertificates:certSet];
    manager.securityPolicy  = securityPolicy;
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"methodname":@"emp/showPicture.json"
                          };
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/showPicture.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    [manager POST:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MMLog(@"GetUserIconWithEmpId ====responseObject==== %@",responseObject);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:responseObject forKey:kUsreIcon];

        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MMLog(@"GetUserIconWithEmpId ====failure==== %@",error);
    }];

}
// 跳转到注册界面
- (void)pushRegister:(UITapGestureRecognizer *)tap{
    RegisterController *registerVC = [[RegisterController alloc] init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
// 跳转到找回密码界面
- (void)findPassword:(UITapGestureRecognizer *)tap{
    MMFindPasswordController *findPasswordVC = [[MMFindPasswordController alloc] init];
    [self presentViewController:findPasswordVC animated:YES completion:nil];
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
        _recommendPasswordLabel.text = @"注册";
        _recommendPasswordLabel.font = [UIFont systemFontOfSize:14];
        _recommendPasswordLabel.textAlignment = NSTextAlignmentCenter;
        _recommendPasswordLabel.textColor = [UIColor whiteColor];
        _recommendPasswordLabel.userInteractionEnabled = YES;
         UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushRegister:)];
        [_recommendPasswordLabel addGestureRecognizer:ges];
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
        _bottomLabel.text = @"找回密码";
        _bottomLabel.font = [UIFont systemFontOfSize:14];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = [UIColor whiteColor];
        _bottomLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(findPassword:)];
        [_bottomLabel addGestureRecognizer:ges];

    }
    return _bottomLabel;
}
- (UILabel *)VLabel{
    if (_VLabel == nil) {
        _VLabel = [[UILabel alloc] init];
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        NSString *appVersion = [NSString stringWithFormat:@"V %@",[infoDic objectForKey:@"CFBundleShortVersionString"]];
        _VLabel.text = appVersion;
        _VLabel.font = [UIFont systemFontOfSize:12];
        _VLabel.textAlignment = NSTextAlignmentCenter;
        _VLabel.textColor = [UIColor whiteColor];
    }
    return _VLabel;
}


- (DVVTabBarController *)homeTabBarView {
    
    NSArray *controllerArray = @[ @"MMMainController",
                                  @"ApprovalController",
                                  @"ReimburseController",
                                  @"PhoneListController"];
    
    NSArray *titleArray = @[ @"工作", @"审批", @"报销",@"通讯录"];
    
    DVVTabBarController *tabBarVC = [DVVTabBarController new];
    
    // 循环创建Controller
    for (NSInteger i = 0; i < controllerArray.count; i++) {
        
        Class vcClass = NSClassFromString(controllerArray[i]);
        UIViewController *viewController = [vcClass new];
        HMNagationController *naviVC = [[HMNagationController alloc] initWithRootViewController:viewController];
        viewController.title = titleArray[i];
        if (0 == i) {
            MMMainController *homeVC = (MMMainController *)viewController;
            tabBarVC.homeVC = homeVC;
        }
        if (1 == i) {
            BuffetController *buffetVC = (BuffetController *)viewController;
            tabBarVC.buffetVC = buffetVC;
        }
        if (2 == i) {
            NewsController *newsVC = (NewsController *)viewController;
            tabBarVC.newsVC = newsVC;
        }
        [tabBarVC addChildViewController:naviVC];
        if (3 == i) {
            ToolsController *toolsVC = (ToolsController *)viewController;
            tabBarVC.toolsVC = toolsVC;
        }
        [tabBarVC addChildViewController:naviVC];
        
        
        if (4 == i) {
            MyController *myVC = (MyController *)viewController;
            tabBarVC.myVC = myVC;
        }
        [tabBarVC addChildViewController:naviVC];
        
        
    }
    
    return tabBarVC;
}
@end
