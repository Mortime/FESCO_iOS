//
//  NewReimburseController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewReimburseController.h"
#import "NewReimburseTemplateCell.h"
#import "NewPurchaseRecordCell.h"
#import "NewReimbursePopView.h"
#import "NewReimburseConsumePopView.h"
#import "NewPurchaseRecordController.h"

#import "BankInfoModel.h"
#import "TemplateInfoModel.h"
#import "NewPurchaseRecordModel.h"

#define kBottomH  50

@interface NewReimburseController () <UITableViewDelegate,UITableViewDataSource,NewReimbursePopViewDelegate,NewReimburseConsumePopViewDelegate,NewPurchaseRecordCellDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *placeTitleArray;

@property (nonatomic, strong) NSArray *detailArray;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) NewReimbursePopView *popView;  // 模板

@property (nonatomic, strong) NewReimburseConsumePopView *consumePopView;  // 添加消费


@property (nonatomic, strong) NSMutableArray *mobanArray;  // 模板数字

@property (nonatomic, strong) NSMutableArray *bankArray;   // 银行信息数组

@property (nonatomic, strong) NSMutableArray *purchaseRccordArray;   // 银行信息数组

@property (nonatomic, assign) NSInteger allMoneyNumber;  // 消费总金额

@property (nonatomic, strong) NSString *oneStr;

@property (nonatomic, strong) NSDictionary  *dic;





@end

@implementation NewReimburseController

- (void)viewWillAppear:(BOOL)animated{
    // 加载消费记录
    [_purchaseRccordArray removeAllObjects];
    _allMoneyNumber = 0;
    [NetworkEntity postPurchaseRecordSuccess:^(id responseObject) {
        
        MMLog(@"PurchaseRecord  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            if ([[responseObject objectForKey:@"list"] count]) {
                for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                    NewPurchaseRecordModel *model = [NewPurchaseRecordModel yy_modelWithDictionary:dic];
                    [_purchaseRccordArray addObject:model];
                    _allMoneyNumber = _allMoneyNumber + model.moneyAmount;
                }
            }
            [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];
            [self.tableView reloadData];
        }
    } failure:^(NSError *failure) {
        MMLog(@"PurchaseRecord  =======failure=====%@",failure);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建报销单";
    self.mobanArray = [NSMutableArray array];
    self.bankArray = [NSMutableArray array];
    self.purchaseRccordArray = [NSMutableArray array];
    self.titleArray = @[@"模板",@"标题",@"报销日期",@"收款人",@"备注",@"敏感字段"];
    self.placeTitleArray = @[@"请选择模板",@"请输入标题",@"请选择报销日期",@"请选择收款人",@"(选填)",@"(选填)改信息不会被打印"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    
    
    [self.bottomView addSubview:self.leftButton];
    [self.bottomView addSubview:self.rightButton];
    [self.view addSubview:self.bottomView];
    
    
    [self.view addSubview:self.tableView];
    
        //设置右边
        UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
        [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(myAction)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem= rightItem;
    [self initData];

}
- (void)initData{
    
    [NetworkEntity postEditReimburseBookSuccess:^(id responseObject) {
        MMLog(@"EditReimburseBook  =======responseObject=====%@",responseObject);
        if (responseObject) {
            _dic = responseObject;
            // 模板信息
            NSArray *mobanArray = [responseObject objectForKey:@"applyTypes"];
            for (NSDictionary *dic in mobanArray) {
                TemplateInfoModel *modle = [TemplateInfoModel yy_modelWithDictionary:dic];
                [_mobanArray addObject:modle];
            }
            
            // 银行信息
            NSArray *bankArray = [responseObject objectForKey:@"bankAccounts"];
            for (NSDictionary *dic in bankArray) {
                BankInfoModel *modle = [BankInfoModel yy_modelWithDictionary:dic];
                [_bankArray addObject:modle];
            }

            [self.tableView reloadData];
        }
        
    } failure:^(NSError *failure) {
        MMLog(@"EditReimburseBook  =======failure=====%@",failure);
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
        [toastView show];
    }];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5 ;
    }
    if (section == 2) {
        return _purchaseRccordArray.count;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //  一区头部视图
    if (section == 0) {
        UIView *sectionOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
        sectionOne.backgroundColor = [UIColor clearColor];
        return sectionOne;
    }
    // 二区头部视图
    if (section == 1) {
        UIView *sectionTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
        sectionTwo.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,self.view.width , 45)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.text = @"基本信息";
        
        [sectionTwo addSubview:label];
        return sectionTwo;
    }
    // 三区头部视图
    if (section == 2) {
        UIView *sectionThree = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 45)];
        sectionThree.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0,100 , 45)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.text = @"消费细节";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnW = 70;
        button.frame = CGRectMake(kMMWidth - btnW - 10, 0, btnW, 45);
        button.backgroundColor =[UIColor clearColor] ;
        [button setTitle:@"+添加消费" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        [button addTarget:self action:@selector(popConsumePopView) forControlEvents:UIControlEventTouchUpInside];
        
        [sectionThree addSubview:label];
        [sectionThree addSubview:button];
        return sectionThree;
    }

    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 59;
    }
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 2) {
        static NSString *cellID = @"ID";
       NewPurchaseRecordCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.model = _purchaseRccordArray[indexPath.row];
        cell.indexTag = indexPath.row;
        cell.delegate = self;
        return cell;

    }else{
        static NSString *cellID = @"cellID";
        NewReimburseTemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewReimburseTemplateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        cell.tag = 60000 + indexPath.row;
        [cell dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self blockBackWithTextField:textField tag:indexTag];
        }];
        
        
        // 标题隐藏箭头
        if (indexPath.section == 1) {
            // 标题
            if (indexPath.row == 0) {
                cell.arrowImageView.hidden = YES;
                cell.isExist = YES;
            }
            // 收款人
            if (indexPath.row == 2) {
                //            cell.arrowImageView.hidden = YES;
                //            cell.isExist = YES;
                //            cell.detailStr = [UserInfoModel defaultUserInfo].empName;
                cell.dataArray = _bankArray;
                cell.isShowPickView = YES;
                cell.isExist = YES;
                
            }
            
            // 报销日期
            if (indexPath.row == 1) {
                cell.isShowDataPickView = YES;
                cell.isExist = YES;
            }
            // 备注
            if (indexPath.row == 3) {
                cell.isExist = YES;
            }
            //
            if (indexPath.row == 4) {
                cell.isExist = YES;
            }
        }
        
        
        
        
        if (indexPath.section == 0) {
            cell.titleStr = _titleArray[indexPath.row];
            cell.placeHold = _placeTitleArray[indexPath.row];
            cell.detailStr = _oneStr;
        }
        if (indexPath.section == 1) {
            cell.titleStr = _titleArray[indexPath.row + 1];
            cell.placeHold = _placeTitleArray[indexPath.row + 1];
        }
        return cell;
    }
    
    
    
}
#pragma mark --- Action
- (void)myAction{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.popView.dataArray = self.mobanArray;
        
        [self.view addSubview:self.popView];
    }
}
#pragma mark --  NewReimbursePopViewDelegate  方法
// 点击取消
- (void)newReimbursePopViewDelegate{
    [self.popView removeFromSuperview];
}
// 点击确定
- (void)newReimbursePopViewDelegateWithType:(NSString *)type{
    MMLog(@"type = %@",type);
    _oneStr = type;
     [self.popView removeFromSuperview];
    //一个cell刷新
    [self.tableView reloadData];
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark --  NewPurchaseRecordCellDelegate  方法
- (void)newPurchaseRecordCellDelegateWithTag:(NSInteger)tag{
    NewPurchaseRecordModel *model  = _purchaseRccordArray[tag];
    
    [NetworkEntity postDeleReimburseRecordWithDetailId:model.detailId Success:^(id responseObject) {
        MMLog(@"DeleReimburseRecord  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            // 删除成功
            [_purchaseRccordArray removeObjectAtIndex:tag];
            // 金额减少
            _allMoneyNumber = _allMoneyNumber - model.moneyAmount;
            NSLog(@"_allMoneyNumber = %lu",_allMoneyNumber);
            _leftButton.titleLabel.text = [NSString stringWithFormat:@"¥ %lu",_allMoneyNumber];
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        }
    } failure:^(NSError *failure) {
        MMLog(@"DeleReimburseRecord  =======failure=====%@",failure);
    }];
}
#pragma mark --  NewReimburseConsumePopViewDelegate  方法
- (void)newReimburseConsumePopViewDelegatWithRow:(NSInteger)row{
    if (row == 0) {
        // 新建消费记录
         [self.consumePopView removeFromSuperview];
        NewPurchaseRecordController *puschaseVC = [[NewPurchaseRecordController alloc] init];
        puschaseVC.dic = _dic;
        [self.navigationController pushViewController:puschaseVC animated:YES];
    }
    if (row == 1) {
        // 导入已有消费
    }
    if (row == 2) {
        // 取消
        [self.consumePopView removeFromSuperview];
    }
}
#pragma mark --- Action 
- (void)popConsumePopView{
     [self.view addSubview:self.consumePopView];
}
- (void)blockBackWithTextField:(UITextField *)textField  tag:(NSUInteger)tag{
    MMLog(@"textField.text = %@",textField.text);
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height - kBottomH - 64) style:UITableViewStylePlain];
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
        [_rightButton setTitle:@"提交送审" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return _rightButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NewReimbursePopView *)popView{
    if (_popView == nil) {
        _popView = [[NewReimbursePopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _popView.backgroundColor = [UIColor clearColor];
        _popView.delegate = self;
    }
    return _popView;
}
- (NewReimburseConsumePopView *)consumePopView{
    if (_consumePopView == nil) {
        _consumePopView = [[NewReimburseConsumePopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _consumePopView.backgroundColor = [UIColor clearColor];
        _consumePopView.delegate = self;
    }
    return _consumePopView;
}

@end
