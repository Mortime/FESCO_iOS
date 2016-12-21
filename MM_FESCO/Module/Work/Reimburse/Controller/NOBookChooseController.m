//
//  NOBookChooseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NOBookChooseController.h"
#import "NOBookChooseCell.h"
#import "NOBookChooseModel.h"

#define kBottomH  50


@interface NOBookChooseController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *allChooseButton;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation NOBookChooseController


- (void)viewWillAppear:(BOOL)animated{
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"选择未制单消费记录";
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    footView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footView;
    [self.view addSubview:self.tableView];
    
    [self.bottomView addSubview:self.leftButton];
    [self.bottomView addSubview:self.rightButton];
    [self.view addSubview:self.bottomView];
    
    //设置右边
    _allChooseButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    _allChooseButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_allChooseButton setTitle:@"全选" forState:UIControlStateNormal];
    [_allChooseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_allChooseButton addTarget:self action:@selector(didChooseAll:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:_allChooseButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(didBack:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;

    
    
}
- (void)initData{
    [self.dataArray removeAllObjects];
    [NetworkEntity postPurchaseRecordSuccess:^(id responseObject) {
        MMLog(@"PurchaseRecord  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            NSArray *array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                NSMutableDictionary *mightDic = dic.mutableCopy;
                [mightDic setObject:@0 forKey:@"isChoose"];
                
                NOBookChooseModel *model = [NOBookChooseModel yy_modelWithDictionary:mightDic];
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
    
    static NSString *cellID = @"NOBookChooseID";
    NOBookChooseCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[NOBookChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NOBookChooseModel *model = _dataArray[indexPath.row];
    model.isChoose = !model.isChoose;
    [_tableView reloadData];
}
#pragma mark --- Action
- (void)didClick:(UIButton *)sender{
   
}
// 全选
- (void)didChooseAll:(UIButton *)sender{
    if (!sender.selected) {
        for (NOBookChooseModel *model in _dataArray) {
            model.isChoose = YES;
            [_allChooseButton setTitle:@"全不选" forState:UIControlStateNormal];
        }
    }else{
        for (NOBookChooseModel *model in _dataArray) {
            model.isChoose = NO;
            [_allChooseButton setTitle:@"全选" forState:UIControlStateNormal];
        }
    }
    sender.selected = !sender.selected;
    
    [_tableView reloadData];
}
// 返回
- (void)didBack:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomH - 64, kMMWidth, kBottomH)];
        _bottomView.backgroundColor = [UIColor clearColor];
        
    }
    return _bottomView;
}
- (UIButton *)leftButton{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, kMMWidth/2, kBottomH);
        _leftButton.backgroundColor = [UIColor whiteColor];
        [_leftButton setTitle:@"¥ 0.00" forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftButton setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        
    }
    return _leftButton;
}
- (UIButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(kMMWidth/2, 0, kMMWidth/2, kBottomH);
        _rightButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_rightButton setTitle:@"添加" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _rightButton;
}


@end
