//
//  ModifyPasswordViewController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ModifyPasswordViewController.h"

#define kWLabel 100
#define kHLabel 60

@interface ModifyPasswordViewController ()

@property (nonatomic ,strong) UIView *lineTopView;

@property (nonatomic, strong) UILabel *oldLable;
@property (nonatomic, strong) UITextField *oldTextFiled;

@property (nonatomic ,strong) UIView *lineMightView;

@property (nonatomic, strong) UILabel *neLabel;
@property (nonatomic, strong) UITextField *neTextFiled;

@property (nonatomic ,strong) UIView *lineView;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textFiled;

@property (nonatomic ,strong) UIView *lineBottomView;

@property (nonatomic, strong) UIButton *preservationButton;

@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.view.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
    [self initUI];

}
- (void)initUI{
    [self.view addSubview:self.lineTopView];
    [self.view addSubview:self.oldLable];
    [self.view addSubview:self.oldTextFiled];
    [self.view addSubview:self.lineMightView];
    [self.view addSubview:self.neLabel];
    [self.view addSubview:self.neTextFiled];
    [self.view addSubview:self.lineView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.lineBottomView];
    [self.view addSubview:self.preservationButton];
    
}
- (void)viewWillLayoutSubviews{
    [self.lineTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20 + 64);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@1);
    }];
    [self.oldLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineTopView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.width.mas_equalTo(@kWLabel);
        make.height.mas_equalTo(@kHLabel);
    }];
    [self.oldTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldLable.mas_top);
        make.left.mas_equalTo(self.oldLable.mas_right).offset(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@kHLabel);
    }];
    [self.lineMightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.oldLable.mas_bottom).offset(0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@1);
    }];
    
    [self.neLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineMightView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.oldLable.mas_left);
        make.width.mas_equalTo(@kWLabel);
        make.height.mas_equalTo(@kHLabel);
    }];
    [self.neTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.neLabel.mas_top);
        make.left.mas_equalTo(self.neLabel.mas_right).offset(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@kHLabel);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.neLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@1);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.oldLable.mas_left);
        make.width.mas_equalTo(@kWLabel);
        make.height.mas_equalTo(@kHLabel);
    }];
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_top);
        make.left.mas_equalTo(self.label.mas_right).offset(0);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@kHLabel);
    }];
    [self.lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).offset(0);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@1);
    }];
}

#pragma mark ---- Action
- (void)didPreservationButton:(UIButton *)sengder{
    // 验证旧密码
    if (_oldTextFiled.text == nil || [_oldTextFiled.text isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入旧密码"];
        return;
    }
    [NetworkEntity postVerificationOldPasswordWithOld:_oldTextFiled.text Success:^(id responseObject) {
        MMLog(@"responseObject = %@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
            // 旧密码验证成功
            
            // 判断新密码是否为空
            if (_neTextFiled.text == nil || [_neTextFiled.text isEqualToString:@""]) {
                [self showTotasViewWithMes:@"请输入新密码"];
                return ;
            }
            // 判断新密码两次输入是否一致
            if ([_neTextFiled.text isEqualToString:_textFiled.text]) {
               // 提交新密码
                [NetworkEntity postCommitNewPasswordWithOld:_neTextFiled.text Success:^(id responseObject) {
                    if ([[responseObject objectForKey:@"message"] isEqualToString:@"success"]) {
                        
                        [self showTotasViewWithMes:@"密码修改成功"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                        
                    }else if ([[responseObject objectForKey:@"error"] isEqualToString:@"success"]){
                        
                        [self showTotasViewWithMes:@"密码修改失败"];
                    }
                } failure:^(NSError *failure) {
                    [self showTotasViewWithMes:@"网络错误"];

                }];
                
                
                
                
                
            }else{
                [self showTotasViewWithMes:@"两次密码输入不一致"];
            }
            
            
        }else if ([[responseObject objectForKey:@"message"] isEqualToString:@"error"]){
            
            [self showTotasViewWithMes:@"旧密码输入错误"];
            return ;
        }
    } failure:^(NSError *failure) {
        [self showTotasViewWithMes:@"网络错误"];
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIView *)lineTopView{
    if (_lineTopView == nil) {
        _lineTopView = [[UIView alloc] init];
        _lineTopView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineTopView;
}
- (UILabel *)oldLable{
    if (_oldLable == nil) {
        _oldLable = [[UILabel alloc] init];
        _oldLable.text = @"旧密码";
        _oldLable.textColor = [UIColor whiteColor];
        _oldLable.font = [UIFont systemFontOfSize:14];
    }
    return _oldLable;
}
- (UITextField *)oldTextFiled {
    if (_oldTextFiled == nil) {
        _oldTextFiled = [[UITextField alloc] init];
        _oldTextFiled.placeholder = @"输入旧密码";
        [_oldTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_oldTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _oldTextFiled.font = [UIFont systemFontOfSize:14];
        _oldTextFiled.textColor = [UIColor whiteColor];
        
    }
    return _oldTextFiled;
}
- (UIView *)lineMightView{
    if (_lineMightView == nil) {
        _lineMightView = [[UIView alloc] init];
        _lineMightView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineMightView;
}
- (UILabel *)neLabel{
    if (_neLabel == nil) {
        _neLabel = [[UILabel alloc] init];
        _neLabel.text = @"新密码";
        _neLabel.textColor = [UIColor whiteColor];
        _neLabel.font = [UIFont systemFontOfSize:14];
    }
    return _neLabel;
}
- (UITextField *)neTextFiled {
    if (_neTextFiled == nil) {
        _neTextFiled = [[UITextField alloc] init];
        _neTextFiled.placeholder = @"输入新密码";
        [_neTextFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_neTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _neTextFiled.font = [UIFont systemFontOfSize:14];
        _neTextFiled.textColor = [UIColor whiteColor];
        _neTextFiled.secureTextEntry = YES;
        
    }
    return _neTextFiled;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineView;
}
- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.text = @"确认密码";
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}
- (UITextField *)textFiled {
    if (_textFiled == nil) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.placeholder = @"确认密码";
        [_textFiled setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_textFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        _textFiled.font = [UIFont systemFontOfSize:14];
        _textFiled.textColor = [UIColor whiteColor];
        _textFiled.secureTextEntry = YES;
        
    }
    return _textFiled;
}


- (UIView *)lineBottomView{
    if (_lineBottomView == nil) {
        _lineBottomView = [[UIView alloc] init];
        _lineBottomView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineBottomView;
}
- (UIButton *)preservationButton{
    if (_preservationButton == nil) {
        _preservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preservationButton.frame = CGRectMake(0, self.view.height - 50, kMMWidth, 50);
        [_preservationButton setTitle:@"保存修改" forState:UIControlStateNormal];
        [_preservationButton setTitleColor:MM_MAIN_BACKGROUND_COLOR forState:UIControlStateNormal];
        [_preservationButton addTarget:self action:@selector(didPreservationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_preservationButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
    }
    return _preservationButton;
}
@end
