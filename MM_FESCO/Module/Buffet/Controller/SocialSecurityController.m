//
//  SocialSecurityController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SocialSecurityController.h"
#import "SocialSecurityCardIDView.h"

#define kFooterCardH  140

@interface SocialSecurityController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic,strong) UIView *footerView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *leftLabel;

@property (nonatomic, strong) UILabel *cardLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) SocialSecurityCardIDView *oneCardIDView;

@property (nonatomic,strong) SocialSecurityCardIDView *twoCardIDView;

@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation SocialSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"员工社保信息自助";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self.footerView addSubview:self.bgView];
    [self.bgView addSubview:self.leftLabel];
    [self.bgView addSubview:self.cardLabel];
    [self.footerView addSubview:self.titleLabel];
    [self.footerView addSubview:self.oneCardIDView];
    [self.footerView addSubview:self.twoCardIDView];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
    
}
#pragma mark --- Action
- (void)didCancelButton:(UIButton *)sender{
    // 保存
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, self.view.height - 50 - 64,self.view.width, 50);
        [_cancelButton setTitle:@"保存" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
    }
    return _cancelButton;
}
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,kFooterCardH * 2 + 10 + 40 + 10 + 50 + 44)];
        _footerView.backgroundColor = [UIColor clearColor];
        
    }
    return _footerView;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,44)];
        _bgView.backgroundColor = [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UILabel *)leftLabel{
    if (_leftLabel == nil) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, CGRectGetHeight(self.bgView.frame))];
        _leftLabel.text = @"身份证号";
        _leftLabel.font = [UIFont systemFontOfSize:14];
        _leftLabel.textColor = [UIColor blackColor];
    }
    return _leftLabel;
}
- (UILabel *)cardLabel{
    if (_cardLabel == nil) {
        _cardLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLabel.frame), 0, self.view.width - CGRectGetMaxX(self.leftLabel.frame), CGRectGetHeight(self.bgView.frame))];
        _cardLabel.text = @"11010819640546";
        _cardLabel.font = [UIFont systemFontOfSize:14];
        _cardLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    }
    return _cardLabel;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.leftLabel.frame) + 20, self.view.width, 15)];
        _titleLabel.text = @"上传身份证";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (SocialSecurityCardIDView *)oneCardIDView{
    if (_oneCardIDView == nil) {
        _oneCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, self.view.width, kFooterCardH)];
        _oneCardIDView.imgStr = @"Buffer_CardIDBg";
        _oneCardIDView.backgroundColor = [UIColor whiteColor];
    }
    return _oneCardIDView;
}
- (SocialSecurityCardIDView *)twoCardIDView{
    if (_twoCardIDView == nil) {
        _twoCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneCardIDView.frame) + 10, self.view.width, kFooterCardH)];
        _twoCardIDView.backgroundColor = [UIColor whiteColor];
        _twoCardIDView.imgStr = @"Buffer_CardIDBg_F";
    }
    return _twoCardIDView;
}

@end

