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


#define kFooterCardH  140

@interface NOSocialSecurityController ()<UITableViewDataSource,UITableViewDelegate,SocialSecurityHearerViewDelegate,SocialSecurityChooseDataControllerDelegate>

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


@property (nonatomic, strong) NSString *countryStr;
@property (nonatomic, assign) upPictureType picType;
@property (nonatomic, strong) NSString *name; // 姓名
@property (nonatomic, strong) NSString *gender; // 性别
@property (nonatomic, strong) NSString *nationCode; // 民族
@property (nonatomic, strong) NSString *birthDate; // 出生日期
@property (nonatomic, strong) NSString *cardID; // 身份证号
@property (nonatomic, strong) NSString *countryCode; // 国籍
@property (nonatomic, strong) NSString *wordID; // 工作居住证
@property (nonatomic, strong) NSString *workDate; // 工作时间
@property (nonatomic, strong) NSString *populationType; // 户口性质
@property (nonatomic, strong) NSString *address; // 居住地址

@property (nonatomic, assign) BOOL photoSuccess; // 照片上传
@property (nonatomic, assign) BOOL cardPositiveSuccess; // 身份证正面上传
@property (nonatomic, assign) BOOL cardReverseSuccess; // 身份证反面上传

@property (nonatomic, assign) BOOL isSaveData; // 是否保存过, 默认NO



@end

@implementation NOSocialSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
        
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
    // 初始化
    _photoSuccess = NO;
    _cardPositiveSuccess= NO;
    _cardReverseSuccess = NO;
    _isSaveData = NO;
    [self getInfoData];
    
    }
- (void)getInfoData{
    WS(ws);
    [NetworkEntity postGetButtetInfoSuccess:^(id responseObject) {
        MMLog(@"GetButtetInfo =======responseObject=====%@",responseObject);
        
        if ([responseObject objectForKey:@"empIns"] == nil || [[responseObject objectForKey:@"empIns"] isEqual:[NSNull null]]) {
            // 不作处理
        }else if([[responseObject objectForKey:@"errcode"] integerValue] == 0){
            // 此时只有图片保存成功,不为空的值进行赋值,其他仍可以编辑
            // 图片赋值
            if ([responseObject objectForKey:@"idcard1"]) {
                NSData *data = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard1"] options:0];
                ws.oneCardIDView.cardIDImageView.image = [UIImage imageWithData:data];
                ws.cardPositiveSuccess = YES;
                ws.oneCardIDView.userInteractionEnabled = NO;
                
            }
            if ([responseObject objectForKey:@"idcard2"]) {
                NSData *data2 = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard2"] options:0];
                ws.twoCardIDView.cardIDImageView.image = [UIImage imageWithData:data2];
                ws.cardReverseSuccess = YES;
                ws.twoCardIDView.userInteractionEnabled = NO;

            }
            if ([responseObject objectForKey:@"photoPic"]) {
                NSData *data3 = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"photoPic"] options:0];
                ws.headerView.iconView.image = [UIImage imageWithData:data3];
                ws.photoSuccess = YES;
                ws.headerView.iconView.userInteractionEnabled = NO;
            }
           
            [ws.tableView reloadData];
            
            
        } else {
            NSDictionary *param = [responseObject objectForKey:@"empIns"];
            ws.isSaveData= YES;
            ws.cancelButton.backgroundColor = [UIColor grayColor];
            ws.cancelButton.userInteractionEnabled = NO;
            ws.name = [param objectForKey:@"yiliao_Name"];
            if ([[param objectForKey:@"gender"] integerValue] == 1) {
                ws.gender = @"男";
            }else if ([[param objectForKey:@"gender"] integerValue] == 2) {
                ws.gender = @"女";
            }
            ws.nationCode = [param objectForKey:@"nationStr"];
            ws.birthDate = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:[NSString stringWithFormat:@"%lu",[[param objectForKey:@"birthday"] integerValue]]];
            ws.cardID = [param objectForKey:@"yiliao_Iden_Card"];
            ws.countryCode = [param objectForKey:@"nationality"];
            if ([param objectForKey:@"resid_Permit_Code"] && ![[param objectForKey:@"resid_Permit_Code"] isEqual:[NSNull null]]) {
                
                ws.wordID = [param objectForKey:@"resid_Permit_Code"];
            }else{
                ws.wordID = @"暂无";
            }
            ws.workDate = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:[NSString stringWithFormat:@"%lu",[[param objectForKey:@"work_Date"] integerValue]]];
            if ([[param objectForKey:@"hukou_Type"] integerValue] == 1) {
                ws.populationType = @"城镇";
            }else if ([[param objectForKey:@"hukou_Type"] integerValue] == 2) {
                ws.populationType = @"农村";
            }else{
                ws.populationType = @"其他";
            }
            ws.address = [param objectForKey:@"residential_Addr"];
            
            if (ws.isSaveData) {
                ws.headerView.nameView.rightTextFiled.text = ws.name;
                ws.headerView.nameView.rightTextFiled.userInteractionEnabled = NO;
                
                ws.headerView.sexView.rightTextFiled.text = ws.gender;
                ws.headerView.sexView.rightTextFiled.userInteractionEnabled = NO;
                
                ws.headerView.nationView.rightTextFiled.text = ws.nationCode;
                ws.headerView.nationView.rightTextFiled.userInteractionEnabled = NO;
                
                ws.headerView.iconView.userInteractionEnabled = NO;
                
                ws.oneCardIDView.userInteractionEnabled = NO;
                ws.twoCardIDView.userInteractionEnabled = NO;
                
                // 图片赋值
                NSData *data = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard1"] options:0];
                ws.oneCardIDView.cardIDImageView.image = [UIImage imageWithData:data];
                
                NSData *data2 = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"idcard2"] options:0];
                ws.twoCardIDView.cardIDImageView.image = [UIImage imageWithData:data2];
                
                NSData *data3 = [[NSData alloc]initWithBase64EncodedString:[responseObject objectForKey:@"photoPic"] options:0];
                ws.headerView.iconView.image = [UIImage imageWithData:data3];
                
            }
            
            [ws.tableView reloadData];

        }

    } failure:^(NSError *failure) {
        MMLog(@"GetButtetInfo =======failure=====%@",failure);
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
    WS(ws);
        static NSString *cellID = @"socialSecurityID";
        SocialSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[SocialSecurityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
    if (indexPath.section == 0) {
        cell.socialTextFiledView.leftTitle = self.titleArray[indexPath.row];
        cell.socialTextFiledView.placeHold = self.placeArray[indexPath.row];
        // 出生日期
        if (indexPath.row == 0) {
            cell.tag = 500001;
            cell.socialTextFiledView.isShowDataPickView = YES;
            [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
                ws.birthDate = textField.text;
            }];
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _birthDate;
                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
            }
        }
        // 身份证号
        if (indexPath.row == 1) {
            cell.socialTextFiledView.isExist = YES;
            cell.tag = 500002;
            [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
                ws.cardID = textField.text;
            }];
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _cardID;
                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
            }


        }
        // 国籍
        if (indexPath.row == 2) {
            if (_countryStr) {
                cell.socialTextFiledView.rightTextFiled.text = _countryStr;
            }
            cell.socialTextFiledView.userInteractionEnabled = NO;
            
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _countryCode;
            }
        }

        
    }
    if (indexPath.section == 1) {
        cell.socialTextFiledView.leftTitle = self.titleArray[indexPath.row + 3];
        cell.socialTextFiledView.placeHold = self.placeArray[indexPath.row + 3];
        
        // 工作居住证号
        if (indexPath.row == 0) {
            cell.socialTextFiledView.isExist = YES;
            cell.tag = 500003;
            [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
                ws.wordID = textField.text;
            }];
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _wordID;
                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
            }
        }
        // 参加工作时间
        if (indexPath.row == 1) {
            cell.socialTextFiledView.isShowDataPickView = YES;
            cell.tag = 500004;
            [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
                ws.workDate = textField.text;
            }];
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _workDate;
                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
            }
        }
        // 户口性质
        if (indexPath.row == 2) {
            cell.socialTextFiledView.dataArray = @[@"农村",@"城镇",@"其他"];
            cell.tag = 500005;
            [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
                MMLog(@"户口性质 = %@ indexTag = %lu",textField.text,indexTag);
                if ([textField.text isEqualToString:@"农村"]) {
                    ws.populationType = @"2";
                }else if ([textField.text isEqualToString:@"城镇"]) {
                    ws.populationType = @"1";
                }else{
                    ws.populationType = @"3";
                }
               
                
            }];
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _populationType;
                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
            }
        }
        // 居住地址
        if (indexPath.row == 3) {
            cell.socialTextFiledView.isExist = YES;
            cell.tag = 500006;
            [cell.socialTextFiledView MM_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
                ws.address = textField.text;
            }];
            if (_isSaveData) {
                cell.socialTextFiledView.rightTextFiled.text = _address;
                cell.socialTextFiledView.rightTextFiled.userInteractionEnabled = NO;
            }
        }


        
    }

    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 2) {
        // 选择国家
        if (!_isSaveData) {
            SocialSecurityChooseDataController *chooseVC = [[SocialSecurityChooseDataController alloc] init];
            chooseVC.dataType = country;
            chooseVC.delegate = self;
            [self.navigationController pushViewController:chooseVC animated:YES];

        }
       
    }
}
#pragma mark -- SocialSecurityHearerViewDelegate
- (void)socialSecurityHearerViewDelegateWithTag:(NSInteger)tag{
    if (tag == 12301) {
        // 点击选择民族
        MMLog(@"点击选择民族");
        if (!_isSaveData) {
            SocialSecurityChooseDataController *chooseVC = [[SocialSecurityChooseDataController alloc] init];
            chooseVC.dataType = nation;
            chooseVC.delegate = self;
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
        
        
    }
}
-(void)socialSecurityHearerViewDelegateUpLoadImage{
    // 头像
    _picType = userPhone;
    
    [DVVImagePickerControllerManager showImagePickerControllerFrom:self delegate:self];
}
- (void)socialSecurityHearerViewDelegateBackDataWithTextFiled:(UITextField *)textFiled tag:(NSInteger)tag{
    if (tag == 70000) {
        _name = textFiled.text;
    }else if(tag == 70001){
        if ([textFiled.text isEqualToString:@"男"]) {
            _gender = @"1";
        }else if ([textFiled.text isEqualToString:@"女"]){
            _gender = @"2";
        }
    }
}
#pragma mark --- SocialSecurityChooseDataControllerDelegate  选择民族和国籍时,返回内容
- (void)didClickedWithContent:(NSString *)content code:(NSString *)code dataType:(chooseDataType)dataType{
    MMLog(@"content = %@ code = %@",content,code);
    if (dataType == nation) {
       _headerView.nationView.rightTextFiled.text = content;
        _nationCode = code;
    }else if (dataType == country){
        _countryStr = content;
        _countryCode = code;
        [_tableView reloadData];
    }
    
}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    NSDictionary *dict = nil;
    NSString *name = nil;
    NSString *fileName  = nil;
    if (_picType == userPhone) {
        // 照片
        dict = [NSDictionary dictionaryWithObjectsAndKeys:@"userOneBigPhoto.png",@"uploadFile",[UserInfoModel defaultUserInfo].empId,@"emp_Id",[UserInfoModel defaultUserInfo].custId,@"cust_Id",@"1",@"pic_Type",nil];
        name = @"uploadFile";
        fileName = @"userOneBigPhoto.png";
        
    }else if (_picType == cardPositive){
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
    WS(ws);
    [NetworkEntity postUpLoadPictureWithParamDic:dict urlStr:@"emp/uploadInsPic.json" name:name fileName:fileName picData:photeoData success:^(id responseObject) {
        //请求成功
        MMLog(@"请求成功：%@",responseObject);
        if (ws.picType == userPhone) {
            // 照片
            self.headerView.iconView.image = photoImage;
            ws.photoSuccess = YES;
        }else if (ws.picType == cardPositive){
            // 身份证正面
            ws.oneCardIDView.cardIDImageView.image = photoImage;
            ws.cardPositiveSuccess = YES;
          
        }else if (ws.picType == cardReverse){
            // 身份证反面
            ws.twoCardIDView.cardIDImageView.image = photoImage;
            ws.cardReverseSuccess = YES;
            
        }

        
        
    } failure:^(NSError *failure) {
        //请求失败
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"上传失败"];
        [toastView show];
    }];
    
    
    
}

#pragma mark --- Action 
- (void)didCancelButton:(UIButton *)sender{
    // 保存
    if (_name == nil || [_name isKindOfClass:[NSNull class]]) {
        _name = [UserInfoModel defaultUserInfo].empName;
    }
    if (!_photoSuccess) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请上传1寸照片"];
        [toastView show];
        return;
    }
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
    if (!_gender) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择性别"];
        [toastView show];
        return;
    }
    if (!_nationCode) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择民族"];
        [toastView show];
        return;
    }
    if (!_birthDate) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择出生日期"];
        [toastView show];
        return;
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
   
    
    if (!_countryCode) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择国籍"];
        [toastView show];
        return;
    }
    if (!_workDate) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择工作时间"];
        [toastView show];
        return;
    }
    if (!_populationType) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请选择户口类型"];
        [toastView show];
        return;
    }
    if (!_address) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入居住地址"];
        [toastView show];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息一旦保存,就无法修改,是否保存?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 取消
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 确定
        
        [NetworkEntity postSaveBuffetInfoWithEmpName:_name gender:_gender nation:_nationCode birthday:_birthDate card:_cardID nationality:_countryCode workCode:_wordID workDate:_workDate hukouType:_populationType address:_address Success:^(id responseObject) {
            MMLog(@"SaveBuffetInfo =======responseObject=====%@",responseObject);
            if (responseObject) {
                if ( [[responseObject objectForKey:@"message"]isEqualToString:@"success"]) {
                    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
                    [toastView show];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存失败"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --- 上传身份证
- (void)upCard:(UITapGestureRecognizer *)ges{
    SocialSecurityCardIDView *view = (SocialSecurityCardIDView *)ges.view;
    if (view.tag == 600000) {
        // 身份证正面
        MMLog(@"上传身份证正面");
        
        _picType = cardPositive;
    }
    if (view.tag == 600001) {
        // 身份证反面
        MMLog(@"上传身份证反面");
         _picType = cardReverse;
    }
    
    [DVVImagePickerControllerManager showImagePickerControllerFrom:self delegate:self];
    
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
        _oneCardIDView.userInteractionEnabled = YES;
        _oneCardIDView.tag = 600000;
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
        _twoCardIDView.tag = 600001;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(upCard:)];
        [_twoCardIDView addGestureRecognizer:tap];
    }
    return _twoCardIDView;
}

@end
