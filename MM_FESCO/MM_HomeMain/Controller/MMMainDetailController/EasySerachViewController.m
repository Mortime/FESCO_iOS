//
//  EasySerachViewController.m
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/5/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import "EasySerachViewController.h"
#import "ZYPinYinSearch.h"
#import "PhoneListTableCell.h"

@interface EasySerachViewController ()<UISearchResultsUpdating>
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@end
@implementation EasySerachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    _searchDataSource = [NSMutableArray new];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索";
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _dataArray.count;
    }else {
        return _searchDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhoneListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[PhoneListTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSDictionary *dic = nil;
    if (!self.searchController.active) {
        dic = _dataArray[indexPath.row];
    }else{
        dic = _searchDataSource[indexPath.row];
    }
    
    cell.nameLabel.text = [dic objectForKey:@"emp_Name"];
    
    cell.mobileLabel.text = [dic objectForKey:@"mobile"];
    
    cell.parantVC  = self.searchController;
    
    NSString *phoneStr = [dic objectForKey:@"phone"];
    if (phoneStr == nil  || [phoneStr isMemberOfClass:[NSNull class]]) {
        phoneStr = @"暂无";
    }
    cell.phoneLabel.text = phoneStr;
    
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"People_placehode"]];
    

    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//     [self dismissViewControllerAnimated:YES completion:nil];
//    if (!self.searchController.active) {
//        self.block(_dataArray[indexPath.row]);
//    }else{
//        self.block(_searchDataSource[indexPath.row]);
//    }
//    self.searchController.active = NO;
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [NSArray new];
    ary = [ZYPinYinSearch searchWithOriginalArray:_dataArray andSearchText:searchController.searchBar.text andSearchByPropertyName:@"emp_Name"];
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:_dataArray];
    }else {
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

@end
