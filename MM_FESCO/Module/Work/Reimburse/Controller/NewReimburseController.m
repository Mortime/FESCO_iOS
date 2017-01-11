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
#import "ReimburseApplyManModel.h"
#import "EditMessageModel.h"
#import "BLPFAlertView.h"
#import "NOBookChooseController.h"
#import "NOBookChooseModel.h"
#import "NewPurchaseBookController.h"

#define kBottomH  50

@interface NewReimburseController () <UITableViewDelegate,UITableViewDataSource,NewReimbursePopViewDelegate,NewReimburseConsumePopViewDelegate,NewPurchaseRecordCellDelegate,NOBookChooseControllerDelegate,NewPurchaseBookControllerDelegate>


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

@property (nonatomic, strong) NSMutableArray *applyManArray;  // 部门数组

@property (nonatomic, strong) NSMutableArray *editPurchaseRccordArray;   // 消费记录数组  这个消费记录数组 为编辑时数组

@property (nonatomic, assign) NSInteger allMoneyNumber;  // 消费总金额

@property (nonatomic, strong) NSString *oneStr;  // 模板类型
@property (nonatomic, assign) NSInteger typeCode; // 模板类型id
@property (nonatomic, strong) NSString *titleStr; // 标题
@property (nonatomic, strong) NSString *dateStr; // 报销日期
@property (nonatomic, assign) NSInteger groupID; // 报销组id
@property (nonatomic, strong) NSString *groupStr; // 报销组名称
@property (nonatomic, strong) NSString *peopleStr; // 收款人
@property (nonatomic, assign) NSInteger peopleNumber; // 收款账号
@property (nonatomic, assign) NSInteger peopleID; // 收款人账号ID
@property (nonatomic, strong) NSString *momeStr;  // 备注
@property (nonatomic, strong) NSString *remomeStr; // 敏感字段

@property (nonatomic, assign) NSInteger manApplyID; // 审批人

@property (nonatomic, assign) NSInteger detailid; // 当编辑报销单时,



@property (nonatomic, strong) NSDictionary  *dic;


@property (nonatomic,strong) NSMutableArray *textTitleArray;  // 当从已经保存的消费记录进入界面时 ,显示已经保存的内容


@property (nonatomic, strong) NSMutableArray *noBookRecordArray; // 选择的未制单消费数组

@property (nonatomic,strong) NSString *picID; // 图片ID

@end

@implementation NewReimburseController

- (void)viewWillAppear:(BOOL)animated{
    // 加载消费记录
    if (_rePurchaseBook == editReimburseBook) {
        // 当编辑报销单时
        _allMoneyNumber = 0;
        // 1 .加载消费记录(从已经保存的报销单加载消费记录)
        
        for (EditMessageModel *model in _netWorkRecordArray) {
            _allMoneyNumber = _allMoneyNumber + model.moneyAmount;
        }
        [_editPurchaseRccordArray removeAllObjects];
        NSMutableArray *mutarray = [[NSUserDefaults standardUserDefaults] objectForKey:kReimburseRecordList];
        
        for (NSDictionary *dic in mutarray) {
            [_editPurchaseRccordArray addObject:dic];
            _allMoneyNumber = _allMoneyNumber + [[dic objectForKey:@"moneyAmount"] integerValue];
            
        }
        [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];

        
    }else if (_rePurchaseBook == newReimburseBook){
        //  新建消费记录
        [_editPurchaseRccordArray removeAllObjects];
        _allMoneyNumber = 0;
        NSMutableArray *mutarray = [[NSUserDefaults standardUserDefaults] objectForKey:kReimburseRecordList];
        
        for (NSDictionary *dic in mutarray) {
            [_editPurchaseRccordArray addObject:dic];
            _allMoneyNumber = _allMoneyNumber + [[dic objectForKey:@"moneyAmount"] integerValue];
            
        }
        [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];
        

    }
    
    // 未制单消费数组
    NSArray *noBookArray = [[NSUserDefaults standardUserDefaults] objectForKey:kNOBookRecordList];
    if (noBookArray.count) {
        for (NOBookChooseModel *model in noBookArray) {
            _allMoneyNumber = _allMoneyNumber + model.moneyAmount;
        }
        [_leftButton setTitle:[NSString stringWithFormat:@"¥ %lu",_allMoneyNumber] forState:UIControlStateNormal];
        
        
    }
    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"新建报销单";
    self.mobanArray = [NSMutableArray array];
    self.bankArray = [NSMutableArray array];
    self.editPurchaseRccordArray = [NSMutableArray array];
    self.groupArray = [NSMutableArray array];
    self.applyManArray = [NSMutableArray array];
    
    if (_rePurchaseBook == editReimburseBook) {
        // 日期
        NSString *applyDate = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:_reimburseModel.applyDate];
        
        // 报销部门
        NSString *groupName = @"";
        for (GroupInfoModel *model in _groupArray) {
            if (_reimburseModel.groupId == model.ID) {
                groupName = model.groupName;
            }
        }
        // 收款人
        NSString *people = @"";
        for (BankInfoModel *model in _bankArray) {
            if (_reimburseModel.accountId == model.empBankId) {
            people = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
            }
        }
        if ([_reimburseModel.typeStr isKindOfClass:[NSNull class]] || !_reimburseModel.typeStr) {
            _reimburseModel.typeStr = @"";
        }
        if ([_reimburseModel.memo isKindOfClass:[NSNull class]] || !_reimburseModel.memo) {
            _reimburseModel.memo = @"";
        }
        if ([_reimburseModel.title isKindOfClass:[NSNull class]] || !_reimburseModel.title ) {
            _reimburseModel.title = @"";
        }
//        self.textTitleArray = @[_reimburseModel.typeStr,_reimburseModel.title,applyDate,groupName,people,_reimburseModel.memo].mutableCopy;
        self.textTitleArray= [NSMutableArray arrayWithObjects:_reimburseModel.typeStr,_reimburseModel.title,applyDate,groupName,people,_reimburseModel.memo, nil];
    }
   
    
    self.titleArray = @[@"模板",@"标题",@"报销日期",@"报销部门",@"收款人",@"备注"];
    self.placeTitleArray = @[@"请选择模板",@"请输入标题",@"请选择报销日期",@"请选择报销部门",@"请选择收款人",@"(选填)"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    
    
    [self.bottomView addSubview:self.leftButton];
    [self.bottomView addSubview:self.rightButton];
    [self.view addSubview:self.bottomView];
    
    
    [self.view addSubview:self.tableView];
    
    
    //设置左边
    self.navigationItem.leftBarButtonItem = nil;
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,25,25)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"side"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backView)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    if (_rePurchaseBook == editReimburseBook) {
        // 显示删除按钮
        //保存
        UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,15,15)];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"NewReimburseController_Save"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(myAction)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        
        //删除
        UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(0,0,15,15)];
       [rightButton1 setBackgroundImage:[UIImage imageNamed:@"NewReimburseController_Dele"] forState:UIControlStateNormal];
        [rightButton1 addTarget:self action:@selector(delReimburseBook)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
        
        
        self.navigationItem.rightBarButtonItems= @[rightItem,rightItem1];
        
    }else{
        //设置右边
        UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [rightButton setTitle:@"保存" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(myAction)forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem= rightItem;
 
    }
    
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
            // 审批人
            NSArray *applyManArray = [responseObject objectForKey:@"approvalManList"];
            for (NSDictionary *dic in applyManArray) {
                ReimburseApplyManModel *modle = [ReimburseApplyManModel yy_modelWithDictionary:dic];
                [_applyManArray addObject:modle];
            }
            
            
            // 当编辑报销单时,因为其他数据是直接从_reimburseModel 获取的,所以不需要刷新;
            
            if (_rePurchaseBook == editReimburseBook) {
                
                // 报销部门
                NSString *groupName = @"";
                for (GroupInfoModel *model in _groupArray) {
                    if (_reimburseModel.groupId == model.ID) {
                        groupName = model.groupName;
                    }
                }
                [_textTitleArray replaceObjectAtIndex:3 withObject:groupName];
                
                NSString *people = @"";
                for (BankInfoModel *model in _bankArray) {
                    if (_reimburseModel.accountId == model.empBankId) {
                        people = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
                    }
                }
                [_textTitleArray replaceObjectAtIndex:4 withObject:people];
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
    if (section == 4) {
        return 10;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 5 ;
    }
    if (section == 2) {
        return _netWorkRecordArray.count;
    }
    
    if (section == 3) {
        return _editPurchaseRccordArray.count;
    }
    if (section == 4) {
        return _noBookRecordArray.count;
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
    if (section == 1 || section == 2) {
        return 45;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        return 59;
    }
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4) {
        static NSString *cellID = @"ID";
       NewPurchaseRecordCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (indexPath.section == 2) {
            cell.model = _netWorkRecordArray[indexPath.row];
            cell.indexTag = indexPath.row;
            cell.sectionTag = indexPath.section;
            cell.delegate = self;
        }else if(indexPath.section == 3){
            cell.dic = _editPurchaseRccordArray[indexPath.row];
            cell.indexTag = indexPath.row;
            cell.sectionTag = indexPath.section;
            cell.delegate = self;
        }else{
            cell.chooseModel = _noBookRecordArray[indexPath.row];
            cell.indexTag = indexPath.row;
            cell.sectionTag = indexPath.section;
            cell.delegate = self;
//            cell.deleBtn.hidden = YES;
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
    if (indexPath.section == 2) {
        // 编辑网络
        
        NewPurchaseBookController *bookVC = [[NewPurchaseBookController alloc] init];
        bookVC.bookType = PurchaseEdit;
        EditMessageModel *model = _netWorkRecordArray[indexPath.row];
        if ([model.spendEnd isKindOfClass:[NSNull class]] || !model.spendEnd) {
            // 日期类型
            // 不显示结束日期
            bookVC.dateType =  1;
        }else{
            // 显示结束日期
            bookVC.dateType =  2;
            bookVC.endTime = model.spendEnd;
        }
        if ([model.cityName isKindOfClass:[NSNull class]] || !model.cityName) {
            // 城市名称
            // 不显示x
            bookVC.needCity = 0;
        }else{
            // 显示
            bookVC.needCity = 1;
        }
        
        // 消费类型
        bookVC.typePurchaseStr = model.spendType;
        bookVC.title = model.spendType;
        bookVC.startTime = model.spendBegin;
        bookVC.moneyNumber = [NSString stringWithFormat:@"%lu",model.moneyAmount];
        bookVC.billNumber = [NSString stringWithFormat:@"%lu",model.billNum];
        bookVC.memo = model.detailMemo;
        bookVC.indexTag = indexPath.row;
        bookVC.sectionTag = indexPath.section;
        bookVC.networkArrayEdit = _netWorkRecordArray;
        bookVC.delegate = self;
        
        //    // 测试数组
        NSMutableArray *array = [NSMutableArray array];
        //    NSURL *URL = [NSURL URLWithString:@"assets-library://asset/asset.JPG?id=B84E8479-475C-4727-A4A4-B77AA9980897&ext=JPG"];
        //    [array addObject:URL];
        bookVC.urlArray = array;
        
        [self.navigationController pushViewController:bookVC animated:YES];
        
    }
    if (indexPath.section == 3) {
        // 本地新增
        NewPurchaseBookController *bookVC = [[NewPurchaseBookController alloc] init];
        bookVC.bookType = PurchaseEdit;
        NSDictionary *dic = _editPurchaseRccordArray[indexPath.row];
        
        /*
         
         NSDictionary *dic = @{@"moneyAmount":_moneyNumber,
         @"spendBegin":_startTime,
         @"spendEnd":_endTime,
         @"billNum":_billNumber,
         @"picUrl":_picUrl,
         @"detailMemo":_memo,
         @"spendCity":_cityName,
         @"ID":[NSString stringWithFormat:@"%lu",_ID],
         @"typePurchaseStr":_typePurchaseStr
         };

         
         */
        
        
        
        if ([[dic objectForKey:@"spendEnd"] isKindOfClass:[NSNull class]] || ![dic objectForKey:@"spendEnd"]) {
            // 日期类型
            // 不显示结束日期
            bookVC.dateType =  1;
        }else{
            // 显示结束日期
            bookVC.dateType =  2;
            bookVC.endTime = [dic objectForKey:@"spendEnd"];
        }
        if ([[dic objectForKey:@"spendCity"] isKindOfClass:[NSNull class]] || ![dic objectForKey:@"spendCity"]) {
            // 城市名称
            // 不显示x
            bookVC.needCity = 0;
        }else{
            // 显示
            bookVC.needCity = 1;
        }
        
        // 消费类型
        bookVC.typePurchaseStr = [dic objectForKey:@"typePurchaseStr"];
        bookVC.title = [dic objectForKey:@"typePurchaseStr"];
        bookVC.startTime = [dic objectForKey:@"spendBegin"];
        bookVC.moneyNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"moneyAmount"]];
        bookVC.billNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"billNum"]];
        bookVC.memo = [dic objectForKey:@"detailMemo"];
        bookVC.indexTag = indexPath.row;
        bookVC.sectionTag = indexPath.section;
        bookVC.networkArrayEdit = _editPurchaseRccordArray;
        bookVC.delegate = self;
        
        //    // 测试数组
        NSMutableArray *array = [NSMutableArray array];
        //    NSURL *URL = [NSURL URLWithString:@"assets-library://asset/asset.JPG?id=B84E8479-475C-4727-A4A4-B77AA9980897&ext=JPG"];
        //    [array addObject:URL];
        bookVC.urlArray = array;
        
        [self.navigationController pushViewController:bookVC animated:YES];
    }
    if (indexPath.section == 4) {
        // 未制单消费
        NewPurchaseBookController *bookVC = [[NewPurchaseBookController alloc] init];
        bookVC.bookType = PurchaseEdit;
        NOBookChooseModel *model = _noBookRecordArray[indexPath.row];
        if ([model.spendEnd isKindOfClass:[NSNull class]] || !model.spendEnd) {
            // 日期类型
            // 不显示结束日期
            bookVC.dateType =  1;
        }else{
            // 显示结束日期
            bookVC.dateType =  2;
            bookVC.endTime = model.spendEnd;
        }
        if ([model.cityName isKindOfClass:[NSNull class]] || !model.cityName) {
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
        bookVC.startTime = model.spendBegin;
        bookVC.moneyNumber = [NSString stringWithFormat:@"%lu",model.moneyAmount];
        bookVC.billNumber = [NSString stringWithFormat:@"%lu",model.billNum];
        bookVC.memo = model.detailMemo;
        bookVC.indexTag = indexPath.row;
        bookVC.sectionTag = indexPath.section;
        bookVC.networkArrayEdit = _netWorkRecordArray;
        bookVC.delegate = self;
        
        //    // 测试数组
        NSMutableArray *array = [NSMutableArray array];
        //    NSURL *URL = [NSURL URLWithString:@"assets-library://asset/asset.JPG?id=B84E8479-475C-4727-A4A4-B77AA9980897&ext=JPG"];
        //    [array addObject:URL];
        bookVC.urlArray = array;
        
        [self.navigationController pushViewController:bookVC animated:YES];

    }
    
}
- (void)newPurchaseBookControllerDelegateWith:(NSMutableArray *)array sectionTag:(NSInteger)sectionTag{
    if (sectionTag == 2) {
        _netWorkRecordArray = array;
    }
    if (sectionTag == 4) {
        _noBookRecordArray = array;
    }
    
}
#pragma mark --- Action
- (void)backView{
    MMLog(@"点击了返回");
    if (_rePurchaseBook == newReimburseBook) {
        // 弹出提示框
        [BLPFAlertView showAlertWithTitle:@"提示" message:@"报销单尚未保存,是否返回?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"返回"] completion:^(NSUInteger selectedOtherButtonIndex) {
            MMLog(@"index = %lu",selectedOtherButtonIndex+1);
            NSUInteger indexAlert = selectedOtherButtonIndex + 1;
            if (indexAlert == 1) {
                // 正常返回
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:kReimburseRecordList];

                [self.navigationController popViewControllerAnimated:YES];
                
            }else {
                return ;
            }
            
        }];

    }else if (_rePurchaseBook == editReimburseBook){
        // 正常返回
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:kReimburseRecordList];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
// 点击删除
- (void)delReimburseBook{
    
    // 弹出提示框
    [BLPFAlertView showAlertWithTitle:@"提示" message:@"您要删除改报销单吗?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"删除"] completion:^(NSUInteger selectedOtherButtonIndex) {
        MMLog(@"index = %lu",selectedOtherButtonIndex+1);
        NSUInteger indexAlert = selectedOtherButtonIndex + 1;
        if (indexAlert == 1) {
            // 删除报销单
            [NetworkEntity postDelePurchaseBookWithApplyId:_reimburseModel.applyId Success:^(id responseObject) {
                
                MMLog(@"DelePurchaseBook  =======responseObject=====%@",responseObject);
                if ([[responseObject objectForKey:@"errcode"] intValue] == 0) {
                    ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"删除成功"];
                    [alertView show];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"删除失败"];
                    [alertView show];
                }
                
            } failure:^(NSError *failure) {
                
                MMLog(@"DelePurchaseBook  =======failure=====%@",failure);
                ToastAlertView *alertView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                [alertView show];
            }];

            
            
        }else {
            return ;
        }
        
    }];
}

// 点击保存时
- (void)myAction{
   
    [self editPurchaseDataInModel];
    if (!_oneStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销类型"];
        [toastView show];
        return;
        
    }
    if (!_titleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报标题"];
        [toastView show];
        return;
        
    }
    
    if (!_dateStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销日期"];
        [toastView show];
        return;
        
    }
    
    if (!_groupStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销部门"];
        [toastView show];
        return;
        
    }
    if (!_peopleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择收款人"];
        [toastView show];
        return;
        
    }
    
    [NetworkEntity postPreserveReimburseApplyWithMemo:_momeStr title:_titleStr type:_typeCode applyDate:_dateStr groupId:_groupID accountId:_peopleID purchaseRecordModelArray:_editPurchaseRccordArray networkModelArray:_netWorkRecordArray noBookAddArray:_noBookRecordArray rePurchaseBookType:_rePurchaseBook detailid:_detailid applyID:_detailid Success:^(id responseObject) {
        
        MMLog(@"PreserveReimburseApply  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
            // 保存成功
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
            [toastView show];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:kReimburseRecordList];

            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存失败"];
            [toastView show];
            
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
    [NetworkEntity postCommitReimburseApplyWithMemo:_momeStr title:_titleStr type:_typeCode applyDate:_dateStr groupId:_groupID accountId:_peopleID purchaseRecordModelArray:_editPurchaseRccordArray networkModelArray:_netWorkRecordArray noBookAddArray:_noBookRecordArray applyMan:_manApplyID rePurchaseBookType:_rePurchaseBook detailid:0 applyID:_detailid Success:^(id responseObject) {
            MMLog(@"CommitReimburseApply  =======responseObject=====%@",responseObject);
            if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                // 提交成功
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"提交成功"];
                [toastView show];
                [self.popViewApplyMan removeFromSuperview];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:kReimburseRecordList];

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
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销模板"];
        [toastView show];
        return;
        
    }
    if (!_titleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报标题"];
        [toastView show];
        return;
        
    }
    
    if (!_dateStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销日期"];
        [toastView show];
        return;
        
    }
    
    if (!_groupStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报销部门"];
        [toastView show];
        return;
        
    }
    if (!_peopleStr) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择报收款人"];
        [toastView show];
        return;
        
    }
    
    if (_rePurchaseBook == newReimburseBook) {
        if (_editPurchaseRccordArray.count == 0 &&  _noBookRecordArray.count == 0) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请添加消费记录"];
            [toastView show];
            return;
        }
    }

    self.popViewApplyMan.dataArray = self.applyManArray;
    
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
- (void)newPurchaseRecordCellDelegateWithTag:(NSInteger)tag sectionTag:(NSInteger)sectionTag{
    if (sectionTag == 2) {
        // 网络
        EditMessageModel *model = _netWorkRecordArray[tag];
        // 删除成功
        [_netWorkRecordArray removeObjectAtIndex:tag];
        // 金额减少
        _allMoneyNumber = _allMoneyNumber - model.moneyAmount;
        NSLog(@"_allMoneyNumber = %lu",_allMoneyNumber);
        _leftButton.titleLabel.text = [NSString stringWithFormat:@"¥ %lu",_allMoneyNumber];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    if (sectionTag == 3) {
        // 编辑
        NSDictionary *dic = _editPurchaseRccordArray[tag];
        // 删除成功
        [_editPurchaseRccordArray removeObjectAtIndex:tag];
        // 金额减少
        _allMoneyNumber = _allMoneyNumber - [[dic objectForKey:@"moneyAmount"] integerValue];
        NSLog(@"_allMoneyNumber = %lu",_allMoneyNumber);
        _leftButton.titleLabel.text = [NSString stringWithFormat:@"¥ %lu",_allMoneyNumber];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
    if (sectionTag == 4) {
        // 未制单
        NOBookChooseModel *model = _noBookRecordArray[tag];
        // 删除成功
        [_noBookRecordArray removeObjectAtIndex:tag];
        // 金额减少
        _allMoneyNumber = _allMoneyNumber - model.moneyAmount;
        NSLog(@"_allMoneyNumber = %lu",_allMoneyNumber);
        _leftButton.titleLabel.text = [NSString stringWithFormat:@"¥ %lu",_allMoneyNumber];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }

    
    


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
         [self.consumePopView removeFromSuperview];
        NOBookChooseController *choooseVC = [[NOBookChooseController alloc] init];
        choooseVC.delegate = self;
        HMNagationController *naviVC = [[HMNagationController alloc] initWithRootViewController:choooseVC];
        [self.navigationController presentViewController:naviVC animated:YES completion:nil];
    }
    if (row == 2) {
        // 取消
        [self.consumePopView removeFromSuperview];
    }
}
/*  NOBookChooseControllerDelegate */
- (void)NOBookChooseControllerDelegateWithData:(NSMutableArray *)arrayData{
    _noBookRecordArray = arrayData;
    MMLog(@"NOBookChooseControllerDelegate %lu",arrayData.count);
    [_tableView reloadData];
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
                _peopleID = model.empBankId;
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
            for (GroupInfoModel *model in _groupArray) {
                if (_reimburseModel.groupId == model.ID) {
                    _groupStr = model.groupName;
                    _groupID = model.ID;
                }
            }

        }
        if (!_peopleStr) {
            for (BankInfoModel *model in _bankArray) {
                if (model.empBankId == _reimburseModel.accountId) {
                    NSString *str = [NSString stringWithTitle:model.bankPayName content:model.bankNumber];
                        _peopleStr = str;
                        _peopleNumber  = model.bankNumber;
                        _peopleID = model.empBankId;
                    }

                }
            }
        if (!_momeStr) {
            _momeStr = _reimburseModel.memo;
        }
        _detailid = _reimburseModel.applyId;  // 申请ID 
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
