//
//  BuffetController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "BuffetController.h"
#import "BuffetImagLableCell.h"
#import "BuffetLableImageCell.h"
#import "SocialSecurityShowView.h"
#import "SocialSecurityController.h"
#import "NOSocialSecurityController.h"


@interface BuffetController ()<UITableViewDataSource,UITableViewDelegate,SocialSecurityShowViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *imgArray;

@property (nonatomic, strong) NSArray *topTitleArray;

@property (nonatomic, strong) NSArray *bottomTitleArray;

@property (nonatomic, strong) SocialSecurityShowView *socialSecurityShowView;


@end

@implementation BuffetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.imgArray = @[@"Buffet_Ruzhi",@"Buffet_Shebao",@"Buffet_Gongjijin"];
    self.topTitleArray = @[@"入职办理",@"社保",@"公积金"];
    self.bottomTitleArray = @[@"员工基本信息自助",@"员工社保信息自助",@"员工公积金信息自助"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 2) {
        static NSString *cellID = @"imgLabelID";
        BuffetImagLableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[BuffetImagLableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
            cell.topStr = self.topTitleArray[indexPath.row];
            cell.bottomStr = self.bottomTitleArray[indexPath.row];
        cell.imgStr = self.imgArray[indexPath.row];
            return cell;
        
    }else{
        static NSString *cellID = @"lableImgID";
        BuffetLableImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[BuffetLableImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.topStr = self.topTitleArray[indexPath.row];
        cell.bottomStr = self.bottomTitleArray[indexPath.row];
        cell.imgStr = self.imgArray[indexPath.row];
        
        return cell;

    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        // 员工信息
    }
    if (indexPath.row == 1) {
        // 社保自助
        [self.view addSubview:self.socialSecurityShowView];
    }
    if (indexPath.row == 2) {
        // 公积金自助
    }
}
#pragma  mark ----- SocialSecurityShowViewDelegate
- (void)socialSecurityShowViewDelegateWithMessageTag:(NSInteger)messageTag viewTag:(NSInteger)viewTag{
    
   [self.socialSecurityShowView removeFromSuperview];
    if (viewTag == 9001) {
        if (messageTag == 9004) {
            // 参加过社保
            SocialSecurityController *socialVC = [[SocialSecurityController alloc] init];
            socialVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:socialVC animated:YES];

        }
        if (messageTag == 9005) {
            // 没参加过社保
            NOSocialSecurityController *NOsocialVC = [[NOSocialSecurityController alloc] init];
            NOsocialVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:NOsocialVC animated:YES];

        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 39) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}
- (SocialSecurityShowView *)socialSecurityShowView{
    
    if (_socialSecurityShowView == nil) {
        _socialSecurityShowView = [[SocialSecurityShowView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _socialSecurityShowView.delegate = self;
    }
    return _socialSecurityShowView;
}

@end
