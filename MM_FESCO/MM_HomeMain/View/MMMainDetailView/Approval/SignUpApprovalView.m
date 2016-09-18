//
//  SignUpApprovalView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SignUpApprovalView.h"
#import "ApprovalViewModel.h"
#import "SignUpApprovalCell.h"
#import "SignUpApprovalDetailController.h"

@interface SignUpApprovalView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ApprovalViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@end

@implementation SignUpApprovalView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        self.viewModel = [ApprovalViewModel new];
        [self.viewModel successRefreshBlock:^{
            
            [self refreshUI];
            self.successRequest = 1;
            
            return;
        }];
        [self.viewModel successLoadMoreBlock:^{
            [self refreshUI];
//            [self.refreshFooter endRefreshing];
            
            
        }];
        [self.viewModel successLoadMoreBlockAndNoData:^{
            [self.parementVC showTotasViewWithMes:@"已经加载更多"];
//            [self.refreshFooter endRefreshing];
        }];
    }
    
    return self;
}

#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    
    MMLog(@"=================    %lu",self.approvalType);
    self.viewModel.approvalType = self.approvalType;
    
    
    MMLog(@"=================    %lu",self.viewModel.approvalType);

    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    
    self.viewModel.approvalType = self.approvalType;
    
    [self.viewModel networkRequestLoadMore];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.viewModel.signUpListArray.count;
//    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    SignUpApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[SignUpApprovalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
        cell.listModel = self.viewModel.signUpListArray[indexPat.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SignUpApprovalDetailController *signUpApprovaVC = [[SignUpApprovalDetailController alloc] init];
    signUpApprovaVC.listModel = self.viewModel.signUpListArray[indexPath.row];
    [self.parementVC.navigationController pushViewController:signUpApprovaVC animated:YES];
}
@end