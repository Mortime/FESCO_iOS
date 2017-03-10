//
//  PersonalMessageController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageController.h"
#import "PersonalMessageDetailCell.h"
#import "NSString+MD5.h"
#import "PersonalMessageHeaderView.h"
#import "PersonalMessageModel.h"
#import "ModifyPasswordViewController.h"

#define kBottomButtonW    ((kMMWidth) / 2)

#define kHeaderHH  200

@interface PersonalMessageController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) NSArray *imgArray;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIButton *preservationButton;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) PersonalMessageModel * personalMessageModel;

@property (nonatomic, strong) PersonalMessageHeaderView *headerView;





@end

@implementation PersonalMessageController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"个人信息";
    
    self.imgArray  = @[@"PersonalMes_Landline",@"PersonalMes_Mobile",@"PersonalMes_weixin",@"PersonalMes_Mail",@"PersonalMes_Address",@"PersonalMes_MailCode"];
    
    self.dataArray  = @[@"请输入座机",@"请输入联系电话",@"请输入微信号",@"请输入邮箱",@"请输入居住地址",@"请输入邮编"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.headerView = [[PersonalMessageHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderHH)];
    _headerView.paramentVC = self;
    
        UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:kUsreIcon]];
    if (image) {
        self.headerView.imageView.image = image;
    }
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    lineView.backgroundColor =  MM_MAIN_LINE_COLOR;

    [self.view addSubview:_headerView];
    
    
    UIView *footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 50 - 64, self.view.width, 50)];
    footerView.backgroundColor = [UIColor clearColor];
    footerView.userInteractionEnabled  = YES;
    [footerView addSubview:self.preservationButton];
    [footerView addSubview:self.cancelButton];
    
    [self.view addSubview:footerView];
    [self.view addSubview:self.tableView];
    
    [self initData];
    
}

- (void)initData{
    
    
    NSDictionary *sign = @{@"cust_Id":[UserInfoModel defaultUserInfo].custId,
                           @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                           @"methodname":@"emp/loadEmpInfo.json"};
    NSString *md5Str  = [NSString sortKeyWith:sign];
    MMLog(@"md5Str = %@",md5Str);
    
    [NetworkEntity postPersonMessageWithCustId:[UserInfoModel defaultUserInfo].custId emptId:[UserInfoModel defaultUserInfo].empId tokenkeyID:[UserInfoModel defaultUserInfo].token sign:md5Str success:^(id responseObject) {
        MMLog(@"=============   PersonlMessagecong responseObject =  %@",responseObject);
        _personalMessageModel = [PersonalMessageModel yy_modelWithDictionary:responseObject];
        
        _headerView.nameLabel.text = _personalMessageModel.empName;
        if (_personalMessageModel.gender == 1) {
        [self storeData:@"男" forKey:kSex];
        }else if (_personalMessageModel.gender == 2){
        [self storeData:@"女" forKey:kSex];
        }else{
//            _headerView.sexTextFiled.text = @"暂无";
        }
        
        // 保存姓名和性别
        [self storeData:_personalMessageModel.empName forKey:kName];
//        [self storeData:_headerView.sexTextFiled.text forKey:kSex];
    
        [self.tableView reloadData];
        
    } failure:^(NSError *failure) {
        MMLog(@"=============   PersonlMessagecong failure =  %@",failure);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *mainCellID = @"messageCellID";
    
    PersonalMessageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
    
    if (!cell) {
        cell = [[PersonalMessageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainCellID];
    }
    cell.imgStr = self.imgArray[indexPath.row];
    cell.dataStr = self.dataArray[indexPath.row];
    cell.index = indexPath.row;
    cell.detailFiled.tag = 100 + indexPath.row;
    cell.personalMessageModel = self.personalMessageModel;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)messageEdit:(UITextField *)textFiled{
    // 当姓名和性别更改时再次保存
    if (textFiled.tag == 200) {
        // 姓名
        [self storeData:textFiled.text forKey:kName];
        
    }
    if (textFiled.tag == 201) {
        // 性别
        [self storeData:textFiled.text forKey:kSex];

    }
    MMLog(@"MM _ ---  name ------ sex   %@", textFiled.text);
}
#pragma mark --- Action Targaet
// 保存修改
- (void)didPreservationButton:(UIButton *)btn{
    [NetworkEntity postSubmitPersonMessageWithEmpId:[UserInfoModel defaultUserInfo].empId empName:[self dataForKey:kName] gender:[self dataForKey:kSex] mobile:[self dataForKey:kMobile] phone:[self dataForKey:kPhone] weixinid:[self dataForKey:kWeixin] email:[self dataForKey:kMail] address:[self dataForKey:kAddress] zipcode:[self dataForKey:kZipCode] success:^(id responseObject) {
        MMLog(@"submitpersonMessage =====   ======= %@",responseObject);
        
        if ([[responseObject objectForKey:@"errcode"]integerValue] == 0) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"修改成功"];
            [toastView show];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"修改失败"];
            [toastView show];

        }
       

    } failure:^(NSError *failure) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
        [toastView show];
       
    }];
    
    
    
    
}
// 修改密码
- (void)didCancelButton:(UIButton *)btn{
    ModifyPasswordViewController *modelfyVC =[[ModifyPasswordViewController alloc] init];
    [self.navigationController pushViewController:modelfyVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeaderHH, self.view.width, self.view.height - 50 - 64 - kHeaderHH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}


- (UIButton *)preservationButton{
    if (_preservationButton == nil) {
        _preservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preservationButton.frame = CGRectMake(0, 0, kBottomButtonW, 50);
        [_preservationButton setTitle:@"保存修改" forState:UIControlStateNormal];
        [_preservationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_preservationButton addTarget:self action:@selector(didPreservationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_preservationButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
        
    }
    return _preservationButton;
}
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(CGRectGetMaxX(self.preservationButton.frame), 0, kBottomButtonW, 50);
        [_cancelButton setTitle:@"修改密码" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        _cancelButton.alpha = 0.9;
    }
    return _cancelButton;
}
#pragma mark ----  NSUserDefaults

- (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}

- (id)dataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * data = [defaults objectForKey:key];
    return data;
}
@end
