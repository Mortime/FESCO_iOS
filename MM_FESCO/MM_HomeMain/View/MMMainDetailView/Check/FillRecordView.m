//
//  FillRecordView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FillRecordView.h"
#import "FillRecordCell.h"

@interface FillRecordView () <UITableViewDelegate,UITableViewDataSource>


@end

@implementation FillRecordView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        
        //        self.viewModel = [JZCommentListViewModel new];
        //        [self.viewModel successRefreshBlock:^{
        //            [self refreshUI];
        //            //            NSInteger index = _commnetLevel - 1;
        //            //            [self expandTitleIndex:index];
        //            //            [self expandPieIndex:index];
        //            self.successRequest = 1;
        //
        //            return;
        //        }];
        //        [self.viewModel successLoadMoreBlock:^{
        //            [self refreshUI];
        //            [self.refreshFooter endRefreshing];
        //
        //
        //        }];
        //        [self.viewModel successLoadMoreBlockAndNoData:^{
        //            [self.parementVC showTotasViewWithMes:@"已经加载更多"];
        //            [self.refreshFooter endRefreshing];
        //        }];
    }
    
    return self;
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
