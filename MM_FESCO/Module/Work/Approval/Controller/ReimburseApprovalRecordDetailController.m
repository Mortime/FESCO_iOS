//
//  ReimburseApprovalRecordDetailController.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/11.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "ReimburseApprovalRecordDetailController.h"
#import "NewPurchaseSubTitleCell.h"
#import "NewPurchaseSubContentCell.h"
#import "NewPurchaseSubBookCell.h"
#import "PurchaseCityCell.h"

@interface ReimburseApprovalRecordDetailController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) MPUploadImageHelper *curUploadImageHelper;

@end

@implementation ReimburseApprovalRecordDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    
    //初始化
    _curUploadImageHelper=[MPUploadImageHelper MPUploadImageForSend:NO];
    _curUploadImageHelper.imagesArray = self.picStreamArray;
    
    [self.view addSubview:self.tableView];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  _dateType == 2 显示  结束时间 ,  _needCity == 1  显示 消费城市
    if (_dateType == 2 && _needCity == 1 ) {
        return 8;
    }
    if (_dateType != 2 && _needCity != 1 ) {
        return 6;
    }
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((_dateType == 1) ? (indexPath.row == 4):(indexPath.row == 5)) {
        return [MPImageUploadProgressCell cellHeightWithObj:self.curUploadImageHelper];
    }
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   /*
    "apply_Id" = 108;
    "bill_Num" = 1;
    "cust_Id" = "<null>";
    "detail_Id" = 136;
    "detail_Id_Before_Imported" = "<null>";
    "detail_Memo" = VV;
    "emp_Id" = "<null>";
    "expense_Date" = "<null>";
    icon = "fa fa-car fa-lg";
    "money_Amount" = 55;
    "pic_Ids" = "<null>";
    pics =     (
    {
    "detail_Id" = 136;
    id = 138;
    "pic_Desc" = "<null>";
    "pic_Url" = "F://expensePics/15/15/20161222172610IMG_0003.JPG";
    }
    );
    "spend_Begin" = 1482336000000;
    "spend_Begin_Str" = "<null>";
    "spend_City" = "<null>";
    "spend_End" = "<null>";
    "spend_End_Str" = "<null>";
    "spend_Type" = 18;
    "spend_Type_Str" = "\U4ea4\U901a-\U516c\U4ea4";
    trId = "<null>";
    
    */

    
    
    
    
    // 住宿
    if (indexPath.row == 0) {
        static NSString *cellID = @"SubTitleID";
        NewPurchaseSubTitleCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.titleLabel.text = self.title;
        NSArray *iconArray = [self.icon componentsSeparatedByString:@" "];
        FAIcon icon = [NSString fontAwesomeEnumForIconIdentifier:iconArray[1]];
        
        [cell.btn.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:20]];
        [cell.btn setTitle:[NSString fontAwesomeIconStringForEnum:icon] forState:UIControlStateNormal];
        
        [cell.btn setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
        return cell;
        
    }
    // 金额
    if (indexPath.row == 1) {
        static NSString *cellID = @"SubContentID";
        NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textFiled.leftTitle = @"金额";
        cell.textFiled.textFileStr = [NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"money_Amount"] floatValue]];
        cell.textFiled.rightTextFiled.userInteractionEnabled = NO;
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        static NSString *cellID = @"StartTimeID";
        NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (self.dateType == 1) {
            cell.textFiled.leftTitle = @"日期";
            cell.textFiled.rightTextFiled.userInteractionEnabled = NO;
            
        }else{
            cell.textFiled.leftTitle = @"开始日期";
            cell.textFiled.rightTextFiled.userInteractionEnabled = NO;
        }
        cell.textFiled.textFileStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:[_dic objectForKey:@"spend_Begin"]];
        return cell;
    }
    if (_dateType == 2) {
        if (indexPath.row == 3) {
            static NSString *cellID = @"EndTimeID";
            NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
            if (!cell) {
                cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            cell.textFiled.leftTitle = @"结束日期";
            cell.textFiled.textFileStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:[_dic objectForKey:@"spend_End"]];
           cell.textFiled.rightTextFiled.userInteractionEnabled = NO;
            return cell;
        }
        
    }
    
    if ((_dateType == 1) ? (indexPath.row == 3):(indexPath.row == 4)) {
        static NSString *cellID = @"SubBook";
        NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textFiled.leftTitle = @"发票";
        cell.textFiled.textFileStr = [NSString stringWithFormat:@"%lu 张",[[_dic objectForKey:@"bill_Num"] integerValue]];
        cell.textFiled.rightTextFiled.userInteractionEnabled = NO;
        return cell;
    }
    if ((_dateType == 1) ? (indexPath.row == 4):(indexPath.row == 5)) {
        static NSString *cellID = @"UploadCell";
        MPImageUploadProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[MPImageUploadProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.accessoryType    = UITableViewCellAccessoryNone;
        
        cell.curUploadImageHelper=self.curUploadImageHelper;
        
        return cell;
    }
    
    
    if ((_dateType == 1) ? (indexPath.row == 5):(indexPath.row == 6)) {
        static NSString *cellID = @"ID";
        NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textFiled.leftTitle = @"描述";
        NSString *memo = @"暂无";
        if ([_dic objectForKey:@"detail_Memo"] != nil && ![[_dic objectForKey:@"detail_Memo"] isEqual:[NSNull null]]) {
            memo = [_dic objectForKey:@"detail_Memo"];
        }
        cell.textFiled.textFileStr = memo;
        cell.textFiled.rightTextFiled.userInteractionEnabled = NO;
        return cell;
    }
    
    if ((_dateType == 1) ? (indexPath.row == 6):(indexPath.row == 7)) {
        static NSString *cellID = @"CityID";
        PurchaseCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[PurchaseCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
            cell.resultLabel.text = [_dic objectForKey:@"spend_City"];
        
        return cell;
        
    }
    
    
    return nil;
    
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height - 50) style:UITableViewStylePlain];
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
