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
#import "NewPurchaseBookController.h"

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
        // 未制单消费
        [_dataArray removeAllObjects];
        [NetworkEntity postEditReimburseBookSuccess:^(id responseObject) {
            MMLog(@"EditReimburseBook  =======responseObject=====%@",responseObject);
            if (responseObject) {
                NSArray *array = [responseObject objectForKey:@"spendTypes"];
                for (NSDictionary *dic in array) {
                    PurchaseRecordModel *modle = [PurchaseRecordModel yy_modelWithDictionary:dic];
                    [_dataArray addObject:modle];
                }
                [_tableView reloadData];

            }
            
        } failure:^(NSError *failure) {
            MMLog(@"EditReimburseBook  =======failure=====%@",failure);
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [toastView show];
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
    subVC.bookType = self.bookType;
    subVC.dataArray = modle.subTypes;
    subVC.dateType = modle.dateType;
    subVC.needCity = modle.needCity;
    subVC.icon = modle.icon;
    
    
    if (modle.subTypes.count) {
        [self.navigationController pushViewController:subVC animated:YES];
    }else{
        NewPurchaseBookController *bookVC = [[NewPurchaseBookController alloc] init];
        
        bookVC.title = modle.typeName;
        bookVC.dateType = modle.dateType;
        bookVC.needCity = modle.needCity;
        bookVC.ID = modle.ID;
        bookVC.bookType = self.bookType;
        bookVC.typePurchaseStr = modle.typeName;
        bookVC.icon = modle.icon; 

        [self.navigationController pushViewController:bookVC animated:YES];
    }
    
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
