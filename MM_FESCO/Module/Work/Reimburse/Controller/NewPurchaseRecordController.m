//
//  NewPurchaseRecordController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseRecordController.h"
#import "PurchaseRecordModel.h"
#import "PurchaseRecordCell.h"
#import "NewPurchaseSubController.h"

@interface NewPurchaseRecordController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation NewPurchaseRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建消费记录";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    self.dataArray = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self initData];
}
- (void)initData{
    
    [NetworkEntity postEditReimburseBookSuccess:^(id responseObject) {
                MMLog(@"EditReimburseBook  =======responseObject=====%@",responseObject);
        if (responseObject) {
            NSArray *array = [responseObject objectForKey:@"spendTypes"];
            for (NSDictionary *dic in array) {
                PurchaseRecordModel *modle = [PurchaseRecordModel yy_modelWithDictionary:dic];
                [_dataArray addObject:modle];
            }
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *failure) {
                MMLog(@"EditReimburseBook  =======failure=====%@",failure);
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    PurchaseRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[PurchaseRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseRecordModel *modle = _dataArray[indexPath.row];
    NewPurchaseSubController *subVC = [[NewPurchaseSubController alloc] init];
    subVC.title = modle.typeName;
    subVC.dataArray = modle.subTypes;
    [self.navigationController pushViewController:subVC animated:YES];
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
