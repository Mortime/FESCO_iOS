//
//  NOSocialSecurityController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NOSocialSecurityController.h"
#import "SocialSecurityCell.h"
#import "SocialSecurityHearerView.h"
#import "SocialSecurityCardIDView.h"
#import "SocialSecurityChooseDataController.h"
#import "DVVImagePickerControllerManager.h"
#import "PinYinForObjc.h"

#define kFooterCardH  140

@interface NOSocialSecurityController ()<UITableViewDataSource,UITableViewDelegate,SocialSecurityHearerViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic,strong) SocialSecurityHearerView *headerView;

@property (nonatomic,strong) UIView *footerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) SocialSecurityCardIDView *oneCardIDView;

@property (nonatomic,strong) SocialSecurityCardIDView *twoCardIDView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *placeArray;

@property (nonatomic, strong) NSArray *contentArray;


@property (nonatomic, strong) NSMutableArray *nationArray;


@end

@implementation NOSocialSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.nationArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"员工社保信息自助";
    self.titleArray = @[@"出生日期",@"身份证号",@"国籍",@"工作居住证号",@"参加工作时间",@"户口性质",@"居住地址"];
    self.placeArray = @[@"请选择出生日期",@"请输入身份证号",@"请选择国籍",@"请输入工作居住证号",@"请输入参加工作时间",@"请选择户口性质",@"请输入居住地址"];
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.tableView.tableHeaderView = self.headerView;
    
    [self.footerView addSubview:self.titleLabel];
    [self.footerView addSubview:self.oneCardIDView];
    [self.footerView addSubview:self.twoCardIDView];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.tableView];
    [self initData];
}
- (void)initData{
    [NetworkEntity postNationerAndCountrySuccess:^(id responseObject) {
        MMLog(@"NationerAndCountry ========= responseObject ============%@",responseObject);
        
        NSDictionary *dataArray = [responseObject objectForKey:@"dictInfo"];
        NSString *dic = [dataArray objectForKey:@"1"];

//        int i=0;
//        for (int i=0;i < 8 ; i++) {
//            NSDictionary *dic = dataArray[i];
//            NSString *name = [dic objectForKey:[NSString stringWithFormat:@"%d",i+1]];
//            // 汉字转换为拼音,然后取首字母
//         NSString *header =  [PinYinForObjc chineseConvertToPinYinHead:name];
//            if ([header isEqualToString:@"a"]) {
//                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name,[NSString stringWithFormat:@"%d",i], nil];
//                [_nationArray addObject:dic];
//            }
//            
//        }
//        
        NSLog(@"nation === %@",dic);
        
        
    } failure:^(NSError *failure) {
        MMLog(@"NationerAndCountry ========= responseObject ============%@",failure);
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 3;
    }
    if (1 == section) {
        return 4;
    }
    
    return 3;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        static NSString *cellID = @"socialSecurityID";
        SocialSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[SocialSecurityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
    if (indexPath.section == 0) {
        cell.socialTextFiledView.leftTitle = self.titleArray[indexPath.row];
        cell.socialTextFiledView.placeHold = self.placeArray[indexPath.row];
        
    }
    if (indexPath.section == 1) {
        cell.socialTextFiledView.leftTitle = self.titleArray[indexPath.row + 3];
        cell.socialTextFiledView.placeHold = self.placeArray[indexPath.row + 3];
        
    }

    
    return cell;
    
}
#pragma mark -- SocialSecurityHearerViewDelegate
- (void)socialSecurityHearerViewDelegateWithTag:(NSInteger)tag{
    if (tag == 12301) {
        // 点击选择民族
        MMLog(@"点击选择民族");
        SocialSecurityChooseDataController *chooseVC = [[SocialSecurityChooseDataController alloc] init];
        NSArray *array = @[@"汉族",@"满族",@"回族",@"藏族",@"哈尼族"];
        chooseVC.dataSource = array;
        [self.navigationController pushViewController:chooseVC animated:YES];
        
    }
}
-(void)socialSecurityHearerViewDelegateUpLoadImage{
    [DVVImagePickerControllerManager showImagePickerControllerFrom:self delegate:self];
}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kHttpsCerKey ofType:@"cer"];
    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    [securityPolicy setPinnedCertificates:certSet];
    manager.securityPolicy  = securityPolicy;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/uploadInsPic.json"];
    //2.上传文件
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"userOneBigPhoto.png",@"uploadFile",[UserInfoModel defaultUserInfo].empId,@"emp_Id",[UserInfoModel defaultUserInfo].custId,@"cust_Id",@"1",@"pic_Type",nil];
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        //        NSData* imageData = UIImagePNGRepresentation(photoImage);
        NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* totalPath = [documentPath stringByAppendingPathComponent:@"userOneBigPhotoInfo"];
        
        //保存到 document
        [photeoData writeToFile:totalPath atomically:NO];
        
        MMLog(@"totalPath = %@",totalPath);
        
        //保存到 NSUserDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:totalPath forKey:@"userOneBigPhotoInfo"];
        
        
        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:totalPath];
        
        NSData *photeoData11 = UIImageJPEGRepresentation(selfPhoto, 0.5);
        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:photeoData11 forKey:kUsreIcon];
        
        
        //上传文件参数
        [formData appendPartWithFileData:photeoData11 name:@"uploadFile" fileName:@"userOneBigPhoto.png" mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印上传进度
        CGFloat progress = 100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
        MMLog(@"==============oooooo%.2lf%%", progress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        MMLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        MMLog(@"请求失败：%@",error);
        
    }];
    
    self.headerView.iconView.image = photoImage;
    
}

#pragma mark --- Action 
- (void)didCancelButton:(UIButton *)sender{
    // 保存
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma  mark ----- Lazy 加载
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64 - 50) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}

- (SocialSecurityHearerView *)headerView{
    if (_headerView == nil) {
        _headerView = [[SocialSecurityHearerView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44 * 3 + 10)];
        _headerView.backgroundColor = [UIColor clearColor];
        _headerView.delegate = self;
    }
    return _headerView;
}
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(0, self.view.height - 50 - 64,self.view.width, 50);
        [_cancelButton setTitle:@"保存" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        
    }
    return _cancelButton;
}
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.height,kFooterCardH * 2 + 10 + 40 + 10)];
        _footerView.backgroundColor = [UIColor clearColor];

    }
    return _footerView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.view.width, 15)];
        _titleLabel.text = @"上传身份证";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (SocialSecurityCardIDView *)oneCardIDView{
    if (_oneCardIDView == nil) {
        _oneCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, kFooterCardH)];
        _oneCardIDView.backgroundColor = [UIColor whiteColor];
        _oneCardIDView.imgStr = @"Buffer_CardIDBg";
    }
    return _oneCardIDView;
}
- (SocialSecurityCardIDView *)twoCardIDView{
    if (_twoCardIDView == nil) {
        _twoCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneCardIDView.frame) + 10, self.view.width, kFooterCardH)];
        _twoCardIDView.backgroundColor = [UIColor whiteColor];
        _twoCardIDView.imgStr = @"Buffer_CardIDBg_F";
    }
    return _twoCardIDView;
}

@end
