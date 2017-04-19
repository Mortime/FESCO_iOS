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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;


@end
@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.keyArray = [NSMutableArray array];
        self.valutArray = [NSMutableArray array];
        // headerView
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        headerView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(headerView.frame), CGRectGetHeight(headerView.frame) - 1)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor =[UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        [headerView addSubview:_titleLabel];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame), self.width - 20, 1)];
        lineView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:lineView];
        self.mainView.tableHeaderView = headerView;
        // footerView
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 60)];
        footerView.backgroundColor = [UIColor whiteColor];
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(footerView.frame), CGRectGetHeight(footerView.frame))];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.backgroundColor =[UIColor clearColor];
        _moneyLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        [footerView addSubview:_moneyLabel];
        self.mainView.tableFooterView = footerView;
        
        [self addSubview:self.mainView];
        [self addSubview:self.coverView];
    }
    
    return self;
}
- (void)layoutSubviews{
 _titleLabel.text = [NSString stringWithFormat:@"%@明细展示数据项",_title];
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
    CGFloat money = 0;
    for (NSString *key in keyArray) {
        if (![key isEqualToString:@"EMP_ID"]&&![key isEqualToString:@"EMP_NAME"]&&![key isEqualToString:@"ID"]&&![key isEqualToString:@"MONTH"]) {
            if (![NSString isNUllWithText:[dic objectForKey:key]]) {
                [_keyArray addObject:key];
                [_valutArray addObject:[NSString stringWithFormat:@"%.2f",[[dic objectForKey:key] floatValue]]];
                money = money + [[dic objectForKey:key] floatValue];
            }
        }
        
    }
    _moneyLabel.text = [NSString stringWithFormat:@"税后实发    ¥%.2f",money];
   
    [_mainView reloadData];
}

@end
