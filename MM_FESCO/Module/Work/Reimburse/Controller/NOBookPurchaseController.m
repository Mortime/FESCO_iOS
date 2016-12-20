//
//  NOBookPurchaseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/12.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NOBookPurchaseController.h"
#import "NOBookPurchaseCell.h"
#import "NOBookPurchaseModel.h"
#import "NewPurchaseRecordController.h"
#import "NewPurchaseBookController.h"

@interface NOBookPurchaseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *commitButton;


@end

@implementation NOBookPurchaseController


- (void)viewWillAppear:(BOOL)animated{
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"消费记录";
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footView;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.commitButton];
    
    
}
- (void)initData{
    [self.dataArray removeAllObjects];
    [NetworkEntity postPurchaseRecordSuccess:^(id responseObject) {
        MMLog(@"PurchaseRecord  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            NSArray *array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                NOBookPurchaseModel *model = [NOBookPurchaseModel yy_modelWithDictionary:dic];
                [_dataArray addObject:model];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *failure) {
        MMLog(@"PurchaseRecord  =======failure=====%@",failure);
        ToastAlertView *view = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
        [view show];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"NOBookPurchaseID";
        NOBookPurchaseCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NOBookPurchaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
    cell.model = _dataArray[indexPath.row];
        return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewPurchaseBookController *bookVC = [[NewPurchaseBookController alloc] init];
    bookVC.bookType = NOBookPurchaseEdit;
    NOBookPurchaseModel *model = self.dataArray[indexPath.row];
    bookVC.noBookmodel = model;
    if ([model.spendEnd isKindOfClass:[NSNull class]] || !model.spendEnd) {
        // 日期类型
            // 不显示结束日期
        bookVC.dateType =  1;
    }else{
           // 显示结束日期
        bookVC.dateType =  2;
    }
    if ([model.cityName isKindOfClass:[NSNull class]] || !model.spendEnd) {
        // 城市名称
            // 不显示x
        bookVC.needCity = 0;
    }else{
        // 显示
        bookVC.needCity = 1;
    }
    
    // 消费类型
    bookVC.typePurchaseStr = model.spendTypeStr;
    bookVC.title = model.spendTypeStr;
    
    // 测试数组
    NSMutableArray *array = [NSMutableArray array];
    NSURL *URL = [NSURL URLWithString:@"assets-library://asset/asset.JPG?id=B84E8479-475C-4727-A4A4-B77AA9980897&ext=JPG"];
    [array addObject:URL];
    bookVC.urlArray = array;
    
    
    [self.navigationController pushViewController:bookVC animated:YES];
}
#pragma mark --- Action  
- (void)didClick:(UIButton *)sender{
    NewPurchaseRecordController *purchaseRecordVC = [[NewPurchaseRecordController alloc] init];
    purchaseRecordVC.bookType = noBookPurchase;
    [self.navigationController pushViewController:purchaseRecordVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height - 64 - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.frame = CGRectMake(0, self.view.height - 50 - 64, self.view.width,50);
        [_commitButton setTitle:@"在记一笔" forState:UIControlStateNormal];
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [_commitButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _commitButton;
}

@end
