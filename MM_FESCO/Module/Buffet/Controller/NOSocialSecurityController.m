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

@interface NOSocialSecurityController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic,strong) SocialSecurityHearerView *headerView;


@end

@implementation NOSocialSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"员工社保信息自助";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"socialSecurityID";
        SocialSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[SocialSecurityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
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
@end
