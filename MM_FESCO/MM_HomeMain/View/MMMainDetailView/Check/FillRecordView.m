//
//  FillRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FillRecordView.h"
#import "FillRecordCell.h"
#import "SignUpViewModel.h"

@interface FillRecordView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SignUpViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;


@end

@implementation FillRecordView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        
        self.viewModel = [SignUpViewModel new];
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
    
    self.viewModel.recodeType = self.recodeType;
    
    [self.viewModel networkRequestRefresh];
}

#pragma mark --- 加载更多
- (void)moreData{
    
    self.viewModel.recodeType = self.recodeType;
    
    [self.viewModel networkRequestLoadMore];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 163;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
    FillRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!cell) {
        cell = [[FillRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    
    return cell;
    
}
@end
