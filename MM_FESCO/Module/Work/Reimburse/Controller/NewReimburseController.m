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
#import "GroupInfoModel.h"

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

@property (nonatomic, strong) NewReimbursePopView *popViewApplyMan; // 审批人

@property (nonatomic, strong) NewReimburseConsumePopView *consumePopView;  // 添加消费


@property (nonatomic, strong) NSMutableArray *mobanArray;  // 模板数字

@property (nonatomic, strong) NSMutableArray *bankArray;   // 银行信息数组

@property (nonatomic, strong) NSMutableArray *groupArray;  // 部门数组

@property (nonatomic, strong) NSMutableArray *editPurchaseRccordArray;   // 消费记录数组  这个消费记录数组 为编辑时数组
@property (nonatomic, strong) NSMutableArray *newsPurchaseRccordArray; // 消费记录数组  这个消费记录数组 为新建时数组

@property (nonatomic, assign) NSInteger allMoneyNumber;  // 消费总金额

@property (nonatomic, strong) NSString *oneStr;  // 模板类型
@property (nonatomic, assign) NSInteger typeCode; // 模板类型id
@property (nonatomic, strong) NSString *titleStr; // 标题
@property (nonatomic, strong) NSString *dateStr; // 报销日期
@property (nonatomic, assign) NSInteger groupID; // 报销组id
@property (nonatomic, strong) NSString *groupStr; // 报销组名称
@property (nonatomic, strong) NSString *peopleStr; // 收款人
@property (nonatomic, assign) NSInteger peopleNumber; // 收款账号
@property (nonatomic, strong) NSString *momeStr;  // 备注
@property (nonatomic, strong) NSString *remomeStr; // 敏感字段

@property (nonatomic, assign) NSInteger manApplyID; // 审批人

@property (nonatomic, assign) NSInteger detailid; // 当编辑报销单时,



@property (nonatomic, strong) NSDictionary  *dic;


@property (nonatomic,strong) NSMutableArray *textTitleArray;  // 当从已经保存的消费记录进入界面时 ,显示已经保存的内容

@property (nonatomic,strong) NSMutableArray *netWorkRecordArray; //  用于存放保存之后的消费记录模型



@end

@implementation NewReimburseController

- (void)viewWillAppear:(BOOL)animated{
    // 加载消费记录
    if (_rePurchaseBook == editReimburseBook) {
        // 当编辑报销单时
        [_netWorkRecordArray removeAllObjects];
        _allMoneyNumber = 0;
        // 1 .加载消费记录(从已经保存的报销单加载消费记录)
        NSArray *array = _reimburseModel.details;
        for (NSDictionary *dic in array) {
            NewPurchaseRecordModel *model = [NewPurchaseRecordModel yy_modelWithDictionary:dic];
            [_netWorkRecordArray addObject:model];
            _allMoneyNumber = _allMoneyNumber + model.moneyAmount;
        }
         [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];
        [_tableView reloadData];
        
    }else{
        //    
        [_editPurchaseRccordArray removeAllObjects];
        _allMoneyNumber = 0;
        //    [NetworkEntity postPurchaseRecordSuccess:^(id responseObject) {
        //
        //        MMLog(@"PurchaseRecord  =======responseObject=====%@",responseObject);
        //        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
        //            if ([[responseObject objectForKey:@"list"] count]) {
        //                for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
        //                    NewPurchaseRecordModel *model = [NewPurchaseRecordModel yy_modelWithDictionary:dic];
        //                    [_editPurchaseRccordArray addObject:model];
        //                    _allMoneyNumber = _allMoneyNumber + model.moneyAmount;
        //                }
        //            }
        //            [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];
        //            [self.tableView reloadData];
        //        }
        //    } failure:^(NSError *failure) {
        //        MMLog(@"PurchaseRecord  =======failure=====%@",failure);
        //    }];
        
        NSArray *array = [MMDataBase allTableDataListWithTableName:t_purchaseRecord];
        for (NSArray *ar in array) {
            [_editPurchaseRccordArray addObject:ar];
            _allMoneyNumber = _allMoneyNumber + [ar[0] integerValue];
            
        }
        [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];
        [self.tableView reloadData];
        
        
        MMLog(@"str === %@",array);

    }
    
    }


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建报销单";
    self.mobanArray = [NSMutableArray array];
    self.bankArray = [NSMutableArray array];
    self.editPurchaseRccordArray = [NSMutableArray array];
    self.newsPurchaseRccordArray = [NSMutableArray array];
    self.groupArray = [NSMutableArray array];
    self.netWorkRecordArray = [NSMutableArray array];
    
    if (_rePurchaseBook == editReimburseBook) {
        NSString *applyDate = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:_reimburseModel.applyDate];
        NSString *people = [NSString stringWithTitle:_reimburseModel.accountName content:_reimburseModel.accountId];
        self.textTitleArray = @[_reimburseModel.typeStr,_reimburseModel.title,applyDate,@" ",people,_reimburseModel.memo].mutableCopy;
    }
   
    
    self.titleArray = @[@"模板",@"标题",@"报销日期",@"报销部门",@"收款人",@"备注"];
    self.placeTitleArray = @[@"请选择模板",@"请输入标题",@"请选择报销日期",@"请选择报销部门",@"请选择收款人",@"(选填)"];
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
            // 组信息
            NSArray *groupArray = [responseObject objectForKey:@"groups"];
            for (NSDictionary *dic in groupArray) {
                GroupInfoModel *modle = [GroupInfoModel yy_modelWithDictionary:dic];
                [_groupArray addObject:modle];
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
        if (_rePurchaseBook == editReimburseBook) {
            return _netWorkRecordArray.count;
        }else{
            return _editPurchaseRccordArray.count;
        }
        
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
        if (_rePurchaseBook == editReimburseBook) {
            cell.model = _netWorkRecordArray[indexPath.row];
            cell.indexTag = indexPath.row;
            cell.delegate = self;
        }else{
            cell.dataArray = _editPurchaseRccordArray[indexPath.row];
            cell.indexTag = indexPath.row;
            cell.delegate = self;
        }
        
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
            // 报销日期
            if (indexPath.row == 1) {
                cell.isShowDataPickView = YES;
                cell.isExist = YES;
            }
            // 报销部门
            if (indexPath.row == 2) {
                cell.dataArray = _groupArray;
                cell.isShowPickView = YES;
                cell.isExist = YES;
                cell.isGroup = YES;
                
            }

            // 收款人
            if (indexPath.row == 3) {
                cell.dataArray = _bankArray;
                cell.isShowPickView = YES;
                cell.isExist = YES;
                
            }
            
            // 备注
            if (indexPath.row == 4) {
                cell.isExist = YES;
            }
            //
            if (indexPath.row == 5) {
                cell.isExist = YES;
            }
        }
        
        
        
        
        if (indexPath.section == 0) {
            cell.titleStr = _titleArray[indexPath.row];
            cell.placeHold = _placeTitleArray[indexPath.row];
            
            if (_rePurchaseBook == editReimburseBook ) {
                cell.detailStr = _textTitleArray[indexPath.row];
            }else{
                cell.detailStr = _oneStr;
            }
        }
        if (indexPath.section == 1) {
            cell.titleStr = _titleArray[indexPath.row + 1];
            cell.placeHold = _placeTitleArray[indexPath.row + 1];
            if (_rePurchaseBook == editReimburseBook ) {
                cell.detailStr = _textTitleArray[indexPath.row + 1];
            }
        }
        return cell;
    }
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        self.popView.dataArray = self.mobanArray;
        
        [self.view addSubview:self.popView];
    }
}
#pragma mark --- Action
// 点击保存时
- (void)myAction{
   
    [self editPurchaseDataInModel];
    if (!_oneStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报报销类型"];
        [toastView show];
        return;
        
    }
    if (!_titleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报标题"];
        [toastView show];
        return;
        
    }
    
    if (!_dateStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报报销日期"];
        [toastView show];
        return;
        
    }
    
    if (!_groupStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报报销部门"];
        [toastView show];
        return;
        
    }
    if (!_peopleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报收款人"];
        [toastView show];
        return;
        
    }

        [NetworkEntity postPreserveReimburseApplyWithMemo:_momeStr title:_titleStr type:_typeCode applyDate:_dateStr groupId:_groupID accountId:_peopleNumber purchaseRecordModelArray:_editPurchaseRccordArray rePurchaseBookType:_rePurchaseBook detailid:_detailid Success:^(id responseObject) {
            MMLog(@"PreserveReimburseApply  =======responseObject=====%@",responseObject);
            if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                // 保存成功
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
                [toastView show];
                [MMDataBase deleteAll];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *failure) {
            MMLog(@"PreserveReimburseApply  =======failure=====%@",failure);
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [toastView show];
        }];
    
}
// 点击提交时
- (void)commit{
//    rePurchaseBookType:(NSInteger)rePurchaseBookType detailid:(NSInteger)detailid
    [NetworkEntity postCommitReimburseApplyWithMemo:_momeStr title:_titleStr type:_typeCode applyDate:_dateStr groupId:_groupID accountId:_peopleNumber purchaseRecordModelArray:_editPurchaseRccordArray applyMan:_manApplyID rePurchaseBookType:_rePurchaseBook detailid:_detailid Success:^(id responseObject) {
            MMLog(@"CommitReimburseApply  =======responseObject=====%@",responseObject);
            if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                // 提交成功
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"提交成功"];
                [toastView show];
                [self.popViewApplyMan removeFromSuperview];
                [MMDataBase deleteAll];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"提交失败"];
                [toastView show];

            }
            
        } failure:^(NSError *failure) {
            MMLog(@"CommitReimburseApply  =======failure=====%@",failure);
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [toastView show];
        }];

    }
// 添加消费记录视图
- (void)popConsumePopView{
    [self.view addSubview:self.consumePopView];
}
// 提交送审
- (void)postCommitApply{
    
    [self editPurchaseDataInModel];
    if (!_oneStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报报销类型"];
        [toastView show];
        return;
        
    }
    if (!_titleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报标题"];
        [toastView show];
        return;
        
    }
    
    if (!_dateStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报报销日期"];
        [toastView show];
        return;
        
    }
    
    if (!_groupStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报报销部门"];
        [toastView show];
        return;
        
    }
    if (!_peopleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报收款人"];
        [toastView show];
        return;
        
    }

    self.popViewApplyMan.dataArray = self.groupArray;
    
    [self.view addSubview:self.popViewApplyMan];
}
#pragma mark -- Delegate方法

/*  NewReimbursePopViewDelegate */
// 点击取消
- (void)newReimbursePopViewDelegateWithIndexTag:(NSInteger)indexTag{
    if (indexTag == 187) {
        // 模板视图
        [self.popView removeFromSuperview];


    }
    if (indexTag == 188) {
        // 选择审批人
        [self.popViewApplyMan removeFromSuperview];
    }
}
// 点击确定
- (void)newReimbursePopViewDelegateWithType:(NSString *)type typeCode:(NSInteger)typeCode indexTag:(NSInteger)indexTag{
    if (indexTag == 187) {
        // 模板视图
        MMLog(@"type = %@",type);
        _oneStr = type;
        [_textTitleArray replaceObjectAtIndex:0 withObject:_oneStr];
        _typeCode = typeCode;
        [self.popView removeFromSuperview];
        //一个cell刷新
        [self.tableView reloadData];
    }
    if (indexTag == 188) {
         // 选择审批人
         MMLog(@"type = %@",type);
        _manApplyID = typeCode;
        [self commit];
    }
    

}

/*  NewPurchaseRecordCellDelegate  方法  删除添加的消费记录 */
- (void)newPurchaseRecordCellDelegateWithTag:(NSInteger)tag{
    NSArray *array  = _editPurchaseRccordArray[tag];
    
    // 删除成功
    [_editPurchaseRccordArray removeObjectAtIndex:tag];
    // 金额减少
    _allMoneyNumber = _allMoneyNumber - [array[0] integerValue];
    NSLog(@"_allMoneyNumber = %lu",_allMoneyNumber);
    _leftButton.titleLabel.text = [NSString stringWithFormat:@"¥ %lu",_allMoneyNumber];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
//    [NetworkEntity postDeleReimburseRecordWithDetailId:model.detailId Success:^(id responseObject) {
//        MMLog(@"DeleReimburseRecord  =======responseObject=====%@",responseObject);
//        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
//            // 删除成功
//            [_editPurchaseRccordArray removeObjectAtIndex:tag];
//            // 金额减少
//            _allMoneyNumber = _allMoneyNumber - model.moneyAmount;
//            NSLog(@"_allMoneyNumber = %lu",_allMoneyNumber);
//            _leftButton.titleLabel.text = [NSString stringWithFormat:@"¥ %lu",_allMoneyNumber];
//            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
//        }
//    } failure:^(NSError *failure) {
//        MMLog(@"DeleReimburseRecord  =======failure=====%@",failure);
//    }];
}
 /*  NewReimburseConsumePopViewDelegate  方法 */
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

#pragma mark -------- Blcok 回调
- (void)blockBackWithTextField:(UITextField *)textField  tag:(NSUInteger)tag{
    MMLog(@"textField.text = %@",textField.text);
    if (tag == 60000) {
        // 标题
        _titleStr = textField.text;
        [_textTitleArray replaceObjectAtIndex:1 withObject:_titleStr];
    }
    if (tag == 60001) {
        // 报销日期
        _dateStr = textField.text;
        [_textTitleArray replaceObjectAtIndex:2 withObject:_dateStr];
    }
    if (tag == 60002) {
        // 报销部门
        for (GroupInfoModel *model in _groupArray) {
            if ([model.groupName isEqualToString:textField.text]) {
                _groupID = model.ID;
                _groupStr = textField.text;
            }
        }
        [_textTitleArray replaceObjectAtIndex:3 withObject:textField.text];
    }
    if (tag == 60003) {
        // 收款人
        
        for (BankInfoModel *model in _bankArray) {
            NSString *str = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
            if ([str isEqualToString:textField.text]) {
                _peopleStr = model.bankPayName;
                _peopleNumber  = model.bankNumber;
            }
        }
        [_textTitleArray replaceObjectAtIndex:4 withObject:textField.text];
    }
    if (tag == 60004) {
        // 备注
        _momeStr = textField.text;
        [_textTitleArray replaceObjectAtIndex:5 withObject:_momeStr];
    }
    
    
}
#pragma maek ----- 公共方法
// 当编辑报销单时,用户没有编辑信息,用从Model读取数据
- (void)editPurchaseDataInModel{
    _detailid = 0 ;
    if (_rePurchaseBook == editReimburseBook) {
        
        // 当编辑报销单时, 如果用户不点击对应项, 这是block回调就不会调用,所以当点击时要从Model 中取数据
        if (!_oneStr) {
            _oneStr = _reimburseModel.typeStr;
            for (TemplateInfoModel *model in _mobanArray) {
                if ([model.typeName isEqualToString:_oneStr]) {
                    _typeCode = model.typeCode;
                }
            }
        }
        if (!_titleStr) {
            _titleStr = _reimburseModel.title;
        }
        if (!_dateStr) {
            _dateStr = _reimburseModel.editTime;
        }
        if (!_groupStr) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销部门"];
            [toastView show];
            return;
            
        }
        if (!_peopleStr) {
            
            
            NSString *str1 = [NSString stringWithTitle:_reimburseModel.accountName content:_reimburseModel.accountId];
            for (BankInfoModel *model in _bankArray) {
                NSString *str = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
                if ([str isEqualToString:str1]) {
                    _peopleStr = model.bankPayName;
                    _peopleNumber  = model.bankNumber;
                }
            }
        }
        if (!_momeStr) {
            _momeStr = _reimburseModel.memo;
        }
        _detailid = _reimburseModel.applyId;
    }
    
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
        [_rightButton addTarget:self action:@selector(postCommitApply) forControlEvents:UIControlEventTouchUpInside];
        
        
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
        _popView.tag = 187;
        _popView.delegate = self;
    }
    return _popView;
}
- (NewReimbursePopView *)popViewApplyMan{
    if (_popViewApplyMan == nil) {
        _popViewApplyMan = [[NewReimbursePopView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) type:shenpiren];
        _popViewApplyMan.titleLabel.text = @"选择审批人";
        _popViewApplyMan.tag = 188;
        _popViewApplyMan.backgroundColor = [UIColor clearColor];
        _popViewApplyMan.delegate = self;
    }
    return _popViewApplyMan;
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
