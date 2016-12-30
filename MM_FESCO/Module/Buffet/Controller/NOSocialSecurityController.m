//
//  NOSocialSecurityController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NOSocialSecurityController.h"
#import "SocialSecurityCell.h"
#import "SocialSecurityHearerView.h"
#import "SocialSecurityCardIDView.h"

#define kFooterCardH  140

@interface NOSocialSecurityController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic,strong) SocialSecurityHearerView *headerView;

@property (nonatomic,strong) UIView *footerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) SocialSecurityCardIDView *oneCardIDView;

@property (nonatomic,strong) SocialSecurityCardIDView *twoCardIDView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *placeArray;

@property (nonatomic, strong) NSArray *contentArray;





@end

@implementation NOSocialSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"员工社保信息自助";
    self.titleArray = @[@"出生日期",@"身份证号",@"国籍",@"工作居住证号",@"参加工作时间",@"户口性质",@"居住地址"];
    self.placeArray = @[@"请选择出生日期",@"请输入身份证号",@"请选择国籍",@"请输入工作居住证号",@"请输入参加工作时间",@"请选择户口性质",@"请输入居住地址"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    [self.footerView addSubview:self.titleLabel];
    [self.footerView addSubview:self.oneCardIDView];
    [self.footerView addSubview:self.twoCardIDView];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.tableView];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 3;
    }
    if (1 == section) {
        return 4;
    }
    
    return 3;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"socialSecurityID";
        SocialSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[SocialSecurityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
    if (indexPath.section == 0) {
        cell.socialTextFiledView.leftTitle = self.titleArray[indexPath.row];
        cell.socialTextFiledView.placeHold = self.placeArray[indexPath.row];
        
    }
    if (indexPath.section == 1) {
        cell.socialTextFiledView.leftTitle = self.titleArray[indexPath.row + 3];
        cell.socialTextFiledView.placeHold = self.placeArray[indexPath.row + 3];
        
    }

    
    return cell;
    
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

- (SocialSecurityHearerView *)headerView{
    if (_headerView == nil) {
        _headerView = [[SocialSecurityHearerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44 * 3 + 10)];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
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
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.height,kFooterCardH * 2 + 10 + 40 + 10)];
        _footerView.backgroundColor = [UIColor clearColor];

    }
    return _footerView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.view.width, 15)];
        _titleLabel.text = @"上传身份证";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (SocialSecurityCardIDView *)oneCardIDView{
    if (_oneCardIDView == nil) {
        _oneCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, kFooterCardH)];
        _oneCardIDView.backgroundColor = [UIColor whiteColor];
        _oneCardIDView.imgStr = @"Buffer_CardIDBg";
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
