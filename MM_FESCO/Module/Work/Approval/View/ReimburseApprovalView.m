//
//  ReimburseApprovalView.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/4.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalView.h"
#import "ApprovalViewModel.h"
#import "ReimburseApprovalCell.h"
#import "OverTimeDetailController.h"
#import "MMNoDataShowBGView.h"
#import "ReimburseApprovalDetailController.h"
#import "ReimburseApprovalListModel.h"

@interface ReimburseApprovalView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ApprovalViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;



@property (nonatomic, strong) MMNoDataShowBGView *noDataShowBGView;

@end

@implementation ReimburseApprovalView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.noDataShowBGView];
        
        
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
    
    self.viewModel.approvalType = self.approvalType;
    
    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    
    self.viewModel.approvalType = self.approvalType;
    
    [self.viewModel networkRequestLoadMore];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.viewModel.reimburseListArray.count == 0) {
        _noDataShowBGView.hidden = NO;
    }else{
        _noDataShowBGView.hidden = YES;
        
    }
    return self.viewModel.reimburseListArray.count;
    //    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    ReimburseApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[ReimburseApprovalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    cell.model = self.viewModel.reimburseListArray[indexPat.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReimburseApprovalDetailController *overVC = [[ReimburseApprovalDetailController alloc] init];
    ReimburseApprovalListModel *model = self.viewModel.reimburseListArray[indexPath.row];
    overVC.applyId = model.applyId;
    [self.parementVC.navigationController pushViewController:overVC animated:YES];
}

- (MMNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[MMNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 0,self.width,self.height)];
        _noDataShowBGView.imgStr = @"MM_NO_Apply";
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}

@end
