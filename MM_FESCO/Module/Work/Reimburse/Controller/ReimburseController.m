//
//  ReimburseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/4.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseController.h"
#import "ReimburseCell.h"
#import "ReimburseRecordHeaderView.h"
#import "NewReimburseController.h"
#import "ReimburseModel.h"
#import "NewPurchaseRecordModel.h"
#import "ProgressReimburseController.h"
#import "NOBookPurchaseController.h"


#define kHeaderH  130

#define kWight   (kMMWidth / 3)

#define kBottomH  114

@interface ReimburseController () <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong)  NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *reimburseArray;

//  未制单消费  我的借款  差旅行程
@property (nonatomic, strong) UIView *recodeBgView;

@property (nonatomic, strong) ReimburseRecordHeaderView *leftRecordView;

@property (nonatomic, strong) ReimburseRecordHeaderView *centerRecordView;

@property (nonatomic, strong) ReimburseRecordHeaderView *rightRecordView;

// 报销  添加报销单  列表
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *reportChartBtn;

@property (nonatomic, strong) UIButton *addReportBtn;

@property (nonatomic, strong) UIButton *listBtn;

// tablbeFooterView
@property (nonatomic, strong) UIView *tableBottomView;
@property (nonatomic, strong)  UIButton *tabaleBottomBtn;


@property (nonatomic, strong) NSMutableArray *seletButtonArray;

@property (nonatomic, strong) NSMutableArray *netWorkRecordArray;


@end

@implementation ReimburseController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
    // 加载未制单消费记录
//    [self initDataNOBook];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.seletButtonArray = [NSMutableArray array];
    self.reimburseArray = [NSMutableArray array];
    self.netWorkRecordArray = [NSMutableArray array];
    self.title = @"报销";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.dataArray = [NSMutableArray array];
    
//    [self.recodeBgView addSubview:self.leftRecordView];
//    [self.recodeBgView addSubview:self.centerRecordView];
//    [self.recodeBgView addSubview:self.rightRecordView];
//    [self.view addSubview:self.recodeBgView];
    
    [self.bottomView addSubview:self.reportChartBtn];
    [self.bottomView addSubview:self.addReportBtn];
    [self.bottomView addSubview:self.listBtn];
    [self.view addSubview:self.bottomView];
    
    [self.tableBottomView addSubview:self.tabaleBottomBtn];
    self.tableView.tableFooterView = self.tableBottomView;
    [self.view addSubview:self.tableView];
    
    
    
    MMLog(@"[UIScreen mainScreen].bounds.size.height = %f",[UIScreen mainScreen].bounds.size.height);
    
}
- (void)initData{
    WS(ws);
    [_dataArray removeAllObjects];
    [NetworkEntity postReimburseListSuccess:^(id responseObject) {
        
        MMLog(@"ReimburseList  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            // 请求成功
            NSArray *dicArray = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in dicArray) {
                ReimburseModel *model = [ReimburseModel yy_modelWithDictionary:dic];
                [ws.dataArray addObject:model];
            }
            [ws.tableView reloadData];
           
        }
    } failure:^(NSError *failure) {
        MMLog(@"ReimburseList  =======failure=====%@",failure);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    ReimburseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[ReimburseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = _dataArray[indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReimburseModel *model = _dataArray[indexPath.row];
    WS(ws);
    if (model.statusReimburse == 0) {
        // 待提交状态
        [_netWorkRecordArray removeAllObjects];
        [NetworkEntity postEditReimburseBookOfEditWithApplyId:model.applyId Success:^(id responseObject) {
            MMLog(@"EditReimburseBook (编辑时基本信息)  =======responseObject=====%@",responseObject);
            if (responseObject) {
                NSDictionary *dic = [responseObject objectForKey:@"apply"];
                NSArray *array = [dic objectForKey:@"details"];
                for (NSDictionary *dic in array) {
                    EditMessageModel *model = [EditMessageModel yy_modelWithDictionary:dic];
                    [ws.netWorkRecordArray addObject:model];
    
                }
                
                NewReimburseController *newReimburseVC = [[NewReimburseController alloc] init];
                newReimburseVC.rePurchaseBook = editReimburseBook;
                newReimburseVC.reimburseModel = ws.dataArray[indexPath.row];
                newReimburseVC.netWorkRecordArray = ws.netWorkRecordArray;
                newReimburseVC.hidesBottomBarWhenPushed = YES;
                [ws.navigationController pushViewController:newReimburseVC animated:YES];

            }
        } failure:^(NSError *failure) {
            
        }];
    }else{
        ProgressReimburseController *progressVC = [[ProgressReimburseController alloc] init];
        progressVC.model = model;
        progressVC.hidesBottomBarWhenPushed = YES;
        [ws.navigationController pushViewController:progressVC animated:YES];
    }
}
#pragma mark --- Action
- (void)didClickWorkHeaderView:(UIButton *)sender{
    for (UIButton *btn in _seletButtonArray) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    
    if (sender.tag == 500) {
        // 报表
        MMLog(@"点击了报表");
        ToastAlertView *view = [[ToastAlertView alloc] initWithTitle:@"此功能暂无开放,敬请期待!"];
        [view show];
    }
    if (sender.tag == 501) {
        // 报表
        MMLog(@"点击了添加报销单");
        NewReimburseController *newReimburseVC = [[NewReimburseController alloc] init];
        newReimburseVC.rePurchaseBook = newReimburseBook;
        newReimburseVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:newReimburseVC animated:YES];
    }
    if (sender.tag == 502) {
        MMLog(@"未制单消费");
        // 未制单消费
        NOBookPurchaseController *noBookVC = [[NOBookPurchaseController alloc] init];
        noBookVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:noBookVC animated:YES];

    }
}
// 点击手势
- (void)didList:(UIGestureRecognizer *)ges{
    ReimburseRecordHeaderView *view = (ReimburseRecordHeaderView *)ges.view;
    if (view.tag == 900) {
        // 未制单消费
        NOBookPurchaseController *noBookVC = [[NOBookPurchaseController alloc] init];
        [self.navigationController pushViewController:noBookVC animated:YES];
    }
    if (view.tag == 901) {
        // 我的借款
        ToastAlertView *view = [[ToastAlertView alloc] initWithTitle:@"此功能暂无开放,敬请期待!"];
        [view show];

    }
    if (view.tag == 902) {
        // 差旅行程
        ToastAlertView *view = [[ToastAlertView alloc] initWithTitle:@"此功能暂无开放,敬请期待!"];
        [view show];

    }
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kBottomH, self.view.width, self.view.height - kBottomH - 64 - 46) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

//  未制单消费  我的借款  差旅行程
- (UIView *)recodeBgView{
    if (_recodeBgView == nil) {
        _recodeBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderH)];
        _recodeBgView.backgroundColor = [UIColor clearColor];
    }
    return _recodeBgView;
}
- (ReimburseRecordHeaderView *)leftRecordView{
    if (_leftRecordView == nil) {
        _leftRecordView = [[ReimburseRecordHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWight, kHeaderH)];
        _leftRecordView.titleStr = @"未制单消费";
        _leftRecordView.textViewStr = @"0条消费记录\n共0元";
        _leftRecordView.imgStr = @"Reimburse_weidingdanxiaofei";
        _leftRecordView.userInteractionEnabled = YES;
        _leftRecordView.tag = 900;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didList:)];
        [_leftRecordView addGestureRecognizer:ges];
    }
    return _leftRecordView;
}
- (ReimburseRecordHeaderView *)centerRecordView{
    if (_centerRecordView == nil) {
        _centerRecordView = [[ReimburseRecordHeaderView alloc] initWithFrame:CGRectMake(kWight, 0, kWight, kHeaderH)];
        _centerRecordView.titleStr = @"我的借款";
        _centerRecordView.textViewStr = @"剩余 0元";
        _centerRecordView.imgStr = @"Reimburse_wodejiekuang";
        _centerRecordView.tag = 901;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didList:)];
        [_centerRecordView addGestureRecognizer:ges];
    }
    return _centerRecordView;
}
- (ReimburseRecordHeaderView *)rightRecordView{
    if (_rightRecordView == nil) {
        _rightRecordView = [[ReimburseRecordHeaderView alloc] initWithFrame:CGRectMake(kWight * 2, 0, kWight, kHeaderH)];
        _rightRecordView.titleStr = @"差旅行程";
        _rightRecordView.textViewStr = @"最近行程: 无";
        _rightRecordView.imgStr = @"Reimburse_wodexingcheng";
        _rightRecordView.tag = 902;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didList:)];
        [_rightRecordView addGestureRecognizer:ges];
    }
    return _rightRecordView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
// 报销  添加报销单  列表
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kBottomH)];
        _bottomView.backgroundColor = RGB_Color(240, 239, 245);
        
    }
    return _bottomView;
}
- (UIButton *)reportChartBtn{
    if (_reportChartBtn == nil) {
        _reportChartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reportChartBtn.frame = CGRectMake(0, 0, kWight, kBottomH);
        _reportChartBtn.backgroundColor = [UIColor clearColor];
        [_reportChartBtn setTitle:@"报表" forState:UIControlStateNormal];
        [_reportChartBtn setImage:[UIImage imageNamed:@"Reimburse_baobiao_Normal"] forState:UIControlStateNormal];
        [_reportChartBtn setImage:[UIImage imageNamed:@"Reimburse_baobiao_Select"] forState:UIControlStateSelected];
        _reportChartBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_reportChartBtn setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        [_reportChartBtn setImageEdgeInsets:UIEdgeInsetsMake(15, (kWight - 48)/2, 51, (kWight - 48)/2)];
        if (MMIphone6) {
           [_reportChartBtn setTitleEdgeInsets:UIEdgeInsetsMake(83, -20, 31, (kWight - 48)/2)];
        }
        if (MMIphone6Plus) {
            [_reportChartBtn setTitleEdgeInsets:UIEdgeInsetsMake(83, -10, 31, (kWight - 48)/2)];
        }
        
        _reportChartBtn.tag = 500;
        [self.seletButtonArray addObject:_reportChartBtn];
       [_reportChartBtn addTarget:self action:@selector(didClickWorkHeaderView:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _reportChartBtn;
}
- (UIButton *)addReportBtn{
    if (_addReportBtn == nil) {
        _addReportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addReportBtn.frame = CGRectMake(kWight, 0, kWight, kBottomH);
        _addReportBtn.backgroundColor = [UIColor clearColor];
        [_addReportBtn setTitle:@"添加报销单" forState:UIControlStateNormal];
        [_addReportBtn setImage:[UIImage imageNamed:@"Reimburse_Tianjiabaoxiaodan_Normal"] forState:UIControlStateNormal];
        [_addReportBtn setImage:[UIImage imageNamed:@"Reimburse_Tianjiabaoxiaodan_Select"] forState:UIControlStateSelected];
        _addReportBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addReportBtn setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        [_addReportBtn setImageEdgeInsets:UIEdgeInsetsMake(15, (kWight - 48)/2, 51, (kWight - 48)/2)];
        [_addReportBtn setTitleEdgeInsets:UIEdgeInsetsMake(83, -40, 31, 0)];
        
        
        
        _addReportBtn.tag = 501;
        [self.seletButtonArray addObject:_addReportBtn];
        [_addReportBtn addTarget:self action:@selector(didClickWorkHeaderView:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addReportBtn;
}
- (UIButton *)listBtn{
    if (_listBtn == nil) {
        _listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _listBtn.frame = CGRectMake(kWight * 2, 0, kWight, kBottomH);
        _listBtn.backgroundColor = [UIColor clearColor];
        [_listBtn setTitle:@"未制单消费" forState:UIControlStateNormal];
        [_listBtn setImage:[UIImage imageNamed:@"Reimburse_weidingdanxiaofei_Normal"] forState:UIControlStateNormal];
        [_listBtn setImage:[UIImage imageNamed:@"Reimburse_weidingdanxiaofei_Select"] forState:UIControlStateSelected];
        _listBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_listBtn setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        [_listBtn setImageEdgeInsets:UIEdgeInsetsMake(15, (kWight - 48)/2, 51, (kWight - 48)/2)];
        [_listBtn setTitleEdgeInsets:UIEdgeInsetsMake(83, -40, 31, 0)];
        
        _listBtn.tag = 502;
        [self.seletButtonArray addObject:_listBtn];
        [_listBtn addTarget:self action:@selector(didClickWorkHeaderView:) forControlEvents:UIControlEventTouchUpInside];


        
    }
    return _listBtn;
}
// tablbeFooterView
- (UIView *)tableBottomView{
    if (_tableBottomView == nil) {
        _tableBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        _tableBottomView.backgroundColor = [UIColor clearColor];
    }
    return _tableBottomView;
}
- (UIButton *)tabaleBottomBtn{
    if (_tabaleBottomBtn == nil) {
        _tabaleBottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tabaleBottomBtn.frame = CGRectMake(0, 10, self.view.width, 30);
        _tabaleBottomBtn.backgroundColor = RGB_Color(219, 218, 223);
        [_tabaleBottomBtn setTitle:@"查看已完成报销单" forState:UIControlStateNormal];
        _tabaleBottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_tabaleBottomBtn setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        
    }
    return _tabaleBottomBtn;
}

@end
