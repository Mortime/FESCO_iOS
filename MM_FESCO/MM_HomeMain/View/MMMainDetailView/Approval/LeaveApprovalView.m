//
//  LeaveApprovalView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApprovalView.h"
#import "ApprovalViewModel.h"
#import "LeaveApprovalCell.h"

@interface LeaveApprovalView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ApprovalViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@end

@implementation LeaveApprovalView

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
            [self.refreshFooter endRefreshing];
            
            
        }];
        [self.viewModel successLoadMoreBlockAndNoData:^{
            [self.parementVC showTotasViewWithMes:@"已经加载更多"];
            [self.refreshFooter endRefreshing];
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
    
    self.viewModel.approvalType = self.approvalType;
    
    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    
    self.viewModel.approvalType = self.approvalType;
    
    [self.viewModel networkRequestLoadMore];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return self.viewModel.checkListArray.count;
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 116;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    LeaveApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[LeaveApprovalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    //    cell.listModel = self.viewModel.checkListArray[indexPat.row];
    
    return cell;
    
}
@end