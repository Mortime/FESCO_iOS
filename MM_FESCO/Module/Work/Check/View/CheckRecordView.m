//
//  CheckRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckRecordView.h"
#import "CheckRecordCell.h"
#import "SignUpViewModel.h"


@interface CheckRecordView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SignUpViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@end

@implementation CheckRecordView

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
    return self.viewModel.checkListArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 162;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    static NSString *IDCell = @"cellID";
      CheckRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCell];
        if (!cell) {
            cell = [[CheckRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
        }
    cell.listModel = self.viewModel.checkListArray[indexPat.row];
        
        return cell;
        
}
@end
