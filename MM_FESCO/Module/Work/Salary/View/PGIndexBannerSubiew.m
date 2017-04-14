//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"
#import "SalaryBarPopCell.h"

@interface PGIndexBannerSubiew ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *keyArray;
@property (nonatomic, strong) NSMutableArray *valutArray;


@end
@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.keyArray = [NSMutableArray array];
        self.valutArray = [NSMutableArray array];
        [self addSubview:self.mainView];
        [self addSubview:self.coverView];
    }
    
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
return _keyArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    SalaryBarPopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[SalaryBarPopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.salaryTypeStr = _keyArray[indexPath.row];
    cell.moneyStr =[NSString stringWithFormat:@"¥ %@",_valutArray[indexPath.row]];
    return cell;
    
}

- (UITableView *)mainView {
    
    if (_mainView == nil) {
        _mainView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _mainView.backgroundColor = [UIColor clearColor];
        _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainView.dataSource = self;
        _mainView.delegate = self;
        
        
    }
    return _mainView;
}


- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        _coverView.backgroundColor = [UIColor clearColor];
    }
    return _coverView;
}
- (void)setDic:(NSDictionary *)dic{
    NSArray *keyArray = [dic allKeys];
    for (NSString *key in keyArray) {
        if (![key isEqualToString:@"EMP_ID"]&&![key isEqualToString:@"EMP_NAME"]&&![key isEqualToString:@"ID"]&&![key isEqualToString:@"MONTH"]) {
            if (![NSString isNUllWithText:[dic objectForKey:key]]) {
                [_keyArray addObject:key];
                [_valutArray addObject:[NSString stringWithFormat:@"%.2f",[[dic objectForKey:key] floatValue]]];
            }
        }
        
    }
   
    [_mainView reloadData];
}
@end
