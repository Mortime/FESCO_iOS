//
//  SocialSecurityController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SocialSecurityController.h"
#import "SocialSecurityCardIDView.h"
#import "SocialSecurityCell.h"
#import "DVVImagePickerControllerManager.h"

#define kFooterCardH  140

@interface SocialSecurityController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic,strong) UIView *footerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic,strong) SocialSecurityCardIDView *oneCardIDView;

@property (nonatomic,strong) SocialSecurityCardIDView *twoCardIDView;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, assign) BOOL isSaveData; // 是否保存过, 默认NO

@property (nonatomic, assign) BOOL isEdit; // 是否可以编辑输入, 默认NO

@property (nonatomic, strong) NSString *cardID; // 身份证号

@property (nonatomic, strong) NSString *name; // 姓名

@property (nonatomic, assign) BOOL cardPositiveSuccess; // 身份证正面上传
@property (nonatomic, assign) BOOL cardReverseSuccess; // 身份证反面上传

@property (nonatomic, assign) upPictureType picType;

@property (nonatomic, strong) NSDictionary *paramDic; // 数据字典用于判断是否可以编辑


@end

@implementation SocialSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"员工社保信息自助";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    [self.footerView addSubview:self.titleLabel];
    [self.footerView addSubview:self.oneCardIDView];
    [self.footerView addSubview:self.twoCardIDView];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.tableView];
    // 初始化
    _cardPositiveSuccess= NO;
    _cardReverseSuccess = NO;
    _isSaveData = NO;
    _isEdit = NO;
    [self getInfoData];
}
- (void)getInfoData{
    [NetworkEntity postGetButtetInfoSuccess:^(id responseObject) {
        MMLog(@"GetButtetInfo =======responseObject=====%@",responseObject);
        _paramDic = nil;
        NSDictionary *param = [responseObject objectForKey:@"empIns"];
        
        if (param == nil || [param isEqual:[NSNull null]]) {
           // 不作处理
        }else if([[responseObject objectForKey:@"errcode"] integerValue] == 0){
            // 此时只有图片保存成功,不为空的值进行赋值,其他仍可以编辑
//            _paramDic = param;
//            _isEdit = YES;
            
            // 图片赋值
            if ([responseObject objectForKey:@"idcard1"]) {
                NSData *data = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard1"] options:0];
                _oneCardIDView.cardIDImageView.image = [UIImage imageWithData:data];
                _cardPositiveSuccess = YES;
                _oneCardIDView.userInteractionEnabled = NO;
  
            }
            if ([responseObject objectForKey:@"idcard2"]) {
                NSData *data2 = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard2"] options:0];
                _twoCardIDView.cardIDImageView.image = [UIImage imageWithData:data2];
                _cardReverseSuccess = YES;
                _twoCardIDView.userInteractionEnabled = NO;
            }
            
            [_tableView reloadData];

            
        }else {
            
            _isSaveData= YES;
            _cancelButton.backgroundColor = [UIColor grayColor];
            _cancelButton.userInteractionEnabled = NO;
            
            _cardID = [param objectForKey:@"yiliao_Iden_Card"];
            _name = [param objectForKey:@"yiliao_Name"];
            
            if (_isSaveData) {
                _oneCardIDView.userInteractionEnabled = NO;
                _twoCardIDView.userInteractionEnabled = NO;
                
                // 图片赋值
                NSData *data = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard1"] options:0];
                _oneCardIDView.cardIDImageView.image = [UIImage imageWithData:data];
                
                NSData *data2 = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard2"] options:0];
                _twoCardIDView.cardIDImageView.image = [UIImage imageWithData:data2];
                
            }
            
            [_tableView reloadData];
        }
    } failure:^(NSError *failure) {
        MMLog(@"GetButtetInfo =======failure=====%@",failure);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        static NSString *cellID = @"socialSecurity";
        SocialSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[SocialSecurityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.socialTextFiledView.textFileStr = [[UserInfoModel defaultUserInfo] empName];
        }
        cell.socialTextFiledView.isExist = YES;
        
        [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            MMLog(@"姓名 = %@ indexTag = %lu",textField.text,indexTag);
            _name = textField.text;
        }];
        if (_isSaveData) {
            cell.socialTextFiledView.rightTextFiled.text = _name;
            cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
        }
//        if (_isEdit) {
//            if (![self isNUllWithText:[_paramDic objectForKey:@"yiliao_Name"]]) {
//                _cardID = [_paramDic objectForKey:@"yiliao_Name"];
//                cell.socialTextFiledView.rightTextFiled.text = _cardID;
//                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
//            }
//        }

        cell.socialTextFiledView.leftTitle = @"姓名";
        cell.socialTextFiledView.placeHold = @"请输入姓名";
        
        
        return cell;

    }else{
        static NSString *cellID = @"socialSecurityID";
        SocialSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[SocialSecurityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            cell.socialTextFiledView.lineView.hidden = YES;
        }
        cell.socialTextFiledView.isExist = YES;
        [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            MMLog(@"身份证号 = %@ indexTag = %lu",textField.text,indexTag);
            _cardID = textField.text;
        }];
        if (_isSaveData) {
            cell.socialTextFiledView.rightTextFiled.text = _cardID;
            cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
        }
//        if (_isEdit) {
//            if (![self isNUllWithText:[_paramDic objectForKey:@"yiliao_Iden_Card"]]) {
//                _cardID = [_paramDic objectForKey:@"yiliao_Iden_Card"];
//                cell.socialTextFiledView.rightTextFiled.text = _cardID;
//                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
//            }
//        }
        cell.socialTextFiledView.leftTitle = @"身份证号";
        cell.socialTextFiledView.placeHold = @"请输入身份证号";
        
        return cell;

    }
    
    
}
#pragma mark --- Action
- (void)didCancelButton:(UIButton *)sender{
    // 保存
    if (!_cardPositiveSuccess) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请上传身份正面"];
        [toastView show];
        return;
    }
    if (!_cardReverseSuccess) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请上传身份反面"];
        [toastView show];
        return;
    }
    if (!_name) {
        _name = [UserInfoModel defaultUserInfo].empName;
    }
    if (!_cardID) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入身份证号"];
        [toastView show];
        return;
    }
    if ([_cardID length] != 15) {
        if ([_cardID length] != 18) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入正确的身份证号"];
            [toastView show];
            return;
            
        }
        
    }
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息一旦保存,就无法修改,是否保存?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 取消
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定
        
        [NetworkEntity postSaveBuffetInfoWithEmpName:_name gender:@"" nation:@"" birthday:@"" card:_cardID nationality:@"" workCode:@"" workDate:@"" hukouType:@"" address:@"" Success:^(id responseObject) {
            MMLog(@"SaveBuffetInfo =======responseObject=====%@",responseObject);
            if (responseObject) {
                if ( [[responseObject objectForKey:@"message"]isEqualToString:@"success"]) {
                    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
                    [toastView show];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:[responseObject objectForKey:@"message"]];
                    [toastView show];
                }
            }else {ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存失败"];
                [toastView show];
            }
        } failure:^(NSError *failure) {
            MMLog(@"SaveBuffetInfo =======failure=====%@",failure);
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [toastView show];
        }];
        
        
    }]];
    
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark --- 上传身份证
- (void)upCard:(UITapGestureRecognizer *)ges{
    SocialSecurityCardIDView *view = (SocialSecurityCardIDView *)ges.view;
    if (view.tag == 700000) {
        // 身份证正面
        MMLog(@"上传身份证正面");
        
        _picType = cardPositive;
    }
    if (view.tag == 700001) {
        // 身份证反面
        MMLog(@"上传身份证反面");
        _picType = cardReverse;
    }
    
    [DVVImagePickerControllerManager showImagePickerControllerFrom:self delegate:self];
    
}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    
    NSDictionary *dict = nil;
    
    NSString *name = nil;
    
    NSString *fileName  = nil;
    if (_picType == cardPositive){
        // 身份证正面
        dict = [NSDictionary dictionaryWithObjectsAndKeys:@"cardPositive.png",@"uploadFile",[UserInfoModel defaultUserInfo].empId,@"emp_Id",[UserInfoModel defaultUserInfo].custId,@"cust_Id",@"2",@"pic_Type",nil];
        name = @"uploadFile";
        fileName = @"cardPositive.png";
    }else if (_picType == cardReverse){
        // 身份证反面
        dict = [NSDictionary dictionaryWithObjectsAndKeys:@"cardReverse.png",@"uploadFile",[UserInfoModel defaultUserInfo].empId,@"emp_Id",[UserInfoModel defaultUserInfo].custId,@"cust_Id",@"3",@"pic_Type",nil];
        name = @"uploadFile";
        fileName = @"cardReverse.png";
    }
    
    
    [NetworkEntity postUpLoadPictureWithParamDic:dict urlStr:@"emp/uploadInsPic.json" name:name fileName:fileName picData:photeoData success:^(id responseObject) {
        //请求成功
        MMLog(@"请求成功：%@",responseObject);
        if (_picType == cardPositive){
            // 身份证正面
            _oneCardIDView.cardIDImageView.image = photoImage;
            _cardPositiveSuccess = YES;
            
        }else if (_picType == cardReverse){
            // 身份证反面
            _twoCardIDView.cardIDImageView.image = photoImage;
            _cardReverseSuccess = YES;
            
            
        }
        
        
        
    } failure:^(NSError *failure) {
        //请求失败
        MMLog(@"请求失败：%@",failure);
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"上传失败"];
        [toastView show];
    }];
    
    
    
}
- (BOOL)isNUllWithText:(NSString *)text{
    if (text == nil ||[text  isEqual:[NSNull null]]) {
        return YES;
    }else{
        return NO;
    }
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
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,kFooterCardH * 2 + 10 + 10 + 50)];
        _footerView.backgroundColor = [UIColor clearColor];
        
    }
    return _footerView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.width, 15)];
        _titleLabel.text = @"上传身份证";
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (SocialSecurityCardIDView *)oneCardIDView{
    if (_oneCardIDView == nil) {
        _oneCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame) + 10, self.view.width, kFooterCardH)];
        _oneCardIDView.imgStr = @"Buffer_CardIDBg";
        _oneCardIDView.backgroundColor = [UIColor whiteColor];
        _oneCardIDView.userInteractionEnabled = YES;
        _oneCardIDView.tag = 700000;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upCard:)];
        [_oneCardIDView addGestureRecognizer:tap];
    }
    return _oneCardIDView;
}
- (SocialSecurityCardIDView *)twoCardIDView{
    if (_twoCardIDView == nil) {
        _twoCardIDView = [[SocialSecurityCardIDView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneCardIDView.frame) + 10, self.view.width, kFooterCardH)];
        _twoCardIDView.backgroundColor = [UIColor whiteColor];
        _twoCardIDView.imgStr = @"Buffer_CardIDBg_F";
        _twoCardIDView.tag = 700001;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upCard:)];
        [_twoCardIDView addGestureRecognizer:tap];

    }
    return _twoCardIDView;
}

@end

