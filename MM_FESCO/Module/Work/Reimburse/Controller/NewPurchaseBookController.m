//
//  NewPurchaseBookController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseBookController.h"
#import "NewPurchaseSubTitleCell.h"
#import "NewPurchaseSubContentCell.h"
#import "NewPurchaseSubBookCell.h"


@interface NewPurchaseBookController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewPurchaseBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        return 78;
    }
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellID = @"SubTitleID";
        NewPurchaseSubTitleCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;

    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        static NSString *cellID = @"SubContentID";
         NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (indexPath.row == 1) {
            cell.textFiled.leftTitle = @"金额";
            cell.textFiled.placeHold = @"¥ 0.00";
            cell.textFiled.isExist = YES;
        }
        if (indexPath.row == 2) {
            cell.textFiled.leftTitle = @"日期";
            cell.textFiled.placeHold = @"请选择日期";
            cell.textFiled.isShowDataPickView = YES;
            cell.textFiled.timeType = @"yyyy-mm-dd";
        }

        
        
        return cell;
    }
    
    if (indexPath.row == 3) {
        static NSString *cellID = @"SubBook";
        NewPurchaseSubBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
                
        return cell;
    }

    
    
    return nil;
    
    
    
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
