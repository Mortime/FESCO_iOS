//
//  NewPurchaseSubController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseSubController.h"
#import "NewPurchaseBookController.h"
#import "PurchaseRecordModel.h"
#import "PurchaseSubCell.h"

@interface NewPurchaseSubController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewPurchaseSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    PurchaseSubCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[PurchaseSubCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.model = _dataArray[indexPath.row];
    NSDictionary *dic = _dataArray[indexPath.row];
    cell.titleLabel.text = [dic objectForKey:@"type_Name"];
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewPurchaseBookController *bookVC = [[NewPurchaseBookController alloc] init];
    
    bookVC.title  = self.title;
    bookVC.dateType = self.dateType;
    bookVC.needCity = self.needCity;
    
    NSDictionary *dic = _dataArray[indexPath.row];
    bookVC.ID = [[dic objectForKey:@"id"] integerValue];
    bookVC.typePurchaseStr =  [NSString stringWithFormat:@"%@-%@",self.title,[dic objectForKey:@"type_Name"]];
    
    [self.navigationController pushViewController:bookVC animated:YES];
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
