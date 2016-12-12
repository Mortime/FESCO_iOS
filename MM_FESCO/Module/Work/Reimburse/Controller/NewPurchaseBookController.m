//
//  NewPurchaseBookController.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NewPurchaseBookController.h"
#import "NewPurchaseSubTitleCell.h"
#import "NewPurchaseSubContentCell.h"
#import "NewPurchaseSubBookCell.h"
#import "UploadFile.h"
#import "PurchaseCityCell.h"
#import "CityListViewController.h"
#import "NSString+FontAwesome.h"

#define kBottomButtonW    ((kMMWidth) / 2)
@interface NewPurchaseBookController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate,CityListViewDelegate,NewPurchaseSubContentCellDelegate,NewPurchaseSubBookCellDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) MPUploadImageHelper *curUploadImageHelper;

@property (nonatomic, strong) UIButton *preservationButton;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong)  PurchaseCityCell *cityCell;

@property (nonatomic, strong) NSMutableArray *picIDArray;


// 保存时提交服务器数据
@property (nonatomic, strong) NSString *moneyNumber;  // 金额

@property (nonatomic, strong) NSString *startTime; // 开始时间

@property (nonatomic, strong) NSString *endTime; // 结束时间

@property (nonatomic, strong) NSString *billNumber; // 发票

@property (nonatomic, strong) NSString *picUrl; // 照片链接

@property (nonatomic, strong) NSString *picStr; // 照片描述

@property (nonatomic, strong) NSString *memo; // 我的描述

@property (nonatomic, strong) NSString *cityName; // 选择的城市


@end

@implementation NewPurchaseBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    self.picIDArray = [NSMutableArray array];
    
    //初始化
    _curUploadImageHelper=[MPUploadImageHelper MPUploadImageForSend:NO];
    _billNumber = @"1";
    
//    //设置右边
//    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
//    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(myAction)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem= rightItem;

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.preservationButton];
    
    // 注册一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPicID) name:kGetPicIDNotifition object:nil];
   
    
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
            cell.textFiled.placeHold = @"¥ 0.00";
            cell.textFiled.isExist = YES;
        cell.textFiled.rightTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        cell.delegate = self;
        cell.tag = 8000;
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
            cell.textFiled.placeHold = @"请选择日期";
            cell.textFiled.isShowDataPickView = YES;
            cell.textFiled.timeType = @"yyyy-mm-dd";
        }else{
            cell.textFiled.leftTitle = @"开始日期";
            cell.textFiled.placeHold = @"请选择开始日期";
            cell.textFiled.isShowDataPickView = YES;
            cell.textFiled.timeType = @"yyyy-mm-dd";
        }
        cell.tag = 8001;
        cell.delegate = self;
       
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
            cell.textFiled.placeHold = @"请选择结束日期";
            cell.textFiled.isShowDataPickView = YES;
            cell.textFiled.timeType = @"yyyy-mm-dd";
            cell.tag = 8002;
            cell.delegate = self;
            return cell;
        }

    }

    if ((_dateType == 1) ? (indexPath.row == 3):(indexPath.row == 4)) {
        static NSString *cellID = @"SubBook";
        NewPurchaseSubBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.delegate = self;
                
        return cell;
    }
    if ((_dateType == 1) ? (indexPath.row == 4):(indexPath.row == 5)) {
        static NSString *cellID = @"UploadCell";
        MPImageUploadProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[MPImageUploadProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        __weak typeof(self)weakSelf = self;
        cell.accessoryType    = UITableViewCellAccessoryNone;
        cell.curUploadImageHelper=self.curUploadImageHelper;
        cell.addPicturesBlock = ^(){
            [self showActionForPhoto];
        };
        cell.deleteImageBlock = ^(MPImageItemModel *toDelete){
            [weakSelf.curUploadImageHelper deleteAImage:toDelete];
            [weakSelf.tableView reloadData];
        };

        
        return cell;
    }


    if ((_dateType == 1) ? (indexPath.row == 5):(indexPath.row == 6)) {
        static NSString *cellID = @"ID";
        NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
            cell.textFiled.leftTitle = @"描述";
            cell.textFiled.placeHold = @"我的描述";
            cell.textFiled.isExist = YES;
        cell.delegate = self;
        cell.tag = 8003;
            
        
        return cell;
    }
    
    if ((_dateType == 1) ? (indexPath.row == 6):(indexPath.row == 7)) {
        static NSString *cellID = @"CityID";
        PurchaseCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[PurchaseCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        _cityCell = cell;
        
        return cell;

    }

    
    return nil;
    

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((_dateType == 1) ? (indexPath.row == 6):(indexPath.row == 7)) {
        // 城市选择
        CityListViewController *cityVC = [[CityListViewController alloc]init];
        cityVC.delegate = self;
        [self.navigationController pushViewController:cityVC animated:YES];
    }
}


#pragma mark ------  Notifition
- (void)getPicID{
    NSString *ns=[[NSUserDefaults standardUserDefaults] objectForKey:@"picID"][0];
    [_picIDArray addObject:ns];
}
#pragma mark 自定义代码

//弹出选择框
-(void)showActionForPhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照",@"从相册选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //拍照
        if (![cameraHelper checkCameraAuthorizationStatus]) {
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;//设置可编辑
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    }else if (buttonIndex == 1){
        //相册
        if (![cameraHelper checkPhotoLibraryAuthorizationStatus]) {
            return;
        }
        QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
        [imagePickerController.selectedAssetURLs removeAllObjects];
        [imagePickerController.selectedAssetURLs addObjectsFromArray:self.curUploadImageHelper.selectedAssetURLs];
        imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
        imagePickerController.delegate = self;
        imagePickerController.maximumNumberOfSelection = kupdateMaximumNumberOfImage;
        imagePickerController.allowsMultipleSelection = YES;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
        [self presentViewController:navigationController animated:YES completion:NULL];
    }
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *pickerImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary writeImageToSavedPhotosAlbum:[pickerImage CGImage] orientation:(ALAssetOrientation)pickerImage.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
        [self.curUploadImageHelper addASelectedAssetURL:assetURL];
        //局部刷新 根据布局相应调整
        [self partialTableViewRefresh];
    }];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UINavigationControllerDelegate, QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets{
    NSMutableArray *selectedAssetURLs = [NSMutableArray new];
    [imagePickerController.selectedAssetURLs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [selectedAssetURLs addObject:obj];
    }];
    MPWeakSelf(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.curUploadImageHelper.selectedAssetURLs = selectedAssetURLs;
        dispatch_async(dispatch_get_main_queue(), ^{
            MPStrongSelf(self)
            //局部刷新 根据布局相应调整
            [self partialTableViewRefresh];
        });
    });
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark  -----NewPurchaseSubContentCellDelegate
- (void)newPurchaseSubContentCellDelegateWithTextField:(UITextField *)textField indexTag:(NSInteger)indexTag{
    MMLog(@"newPurchaseSubContentCellDelegateWithTextField = %@%lu",textField.text,indexTag);
    if (indexTag == 8000) {
        // 金额
        _moneyNumber = textField.text;
    }
    if (indexTag == 8001) {
        // 开始日期
        _startTime = textField.text;
    }
    if (indexTag == 8002) {
        // 结束日期
        _endTime = textField.text;
    }
    if (indexTag == 8003) {
        // 我的描述
        _memo = textField.text;
    }

}
#pragma mark  -----NewPurchaseSubBookCellDelegate
- (void)newPurchaseSubBookCellDelegateWithBillNumber:(NSString *)billNumber{
    // 发票数量
    _billNumber = billNumber;
}

//  点击返回 
- (void)backView{
    
}
//上传图片
-(void)myAction
{
    if (self.curUploadImageHelper.selectedAssetURLs.count==0) {
//        [MBProgressHUD showAutoMessage:@"请选择照片进行上传" ToView:nil];
        return;
    }
    
//    MPUploadImageService *req=[[MPUploadImageService alloc]initWithUploadImages:self.curUploadImageHelper];
//    
//    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        //进行上传后的图片地址
//        
//    } failure:^(__kindof YTKBaseRequest *request) {
//        [MPRequstFailedHelper requstFailed:request];
//    }];
//    
//    //上传进度
//    MPWeakSelf(self)
//    req.uploadPropressBlock = ^(NSUInteger __unused bytesWritten,
//                                long long totalBytesWritten,
//                                long long totalBytesExpectedToWrite){
//        
//        MPStrongSelf(self);
//        CGFloat propress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
//        NSLog(@"进度进度：%lld/%lld___%2f",totalBytesWritten,totalBytesExpectedToWrite,propress);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //更新UI
//        });
//        
//        
//    };
        
    
}

//上传图后局部刷新图片行 根据布局相应调整
-(void)partialTableViewRefresh
{
    NSUInteger row = (_dateType == 1) ? 4 :  5;
    
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    
}
#pragma mark -- Action 

// 保存 在记一笔
- (void)didPreservationButton:(UIButton *)sender{
    
    if (!_moneyNumber) {
        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入金额"];
        [toastView show];
        return;
    }
    if (_dateType  == 1) {
        if (!_startTime) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入日期"];
            [toastView show];
            return;
        }
        
    }
    if (_dateType == 2) {
        if (!_startTime) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入开始日期"];
            [toastView show];
            return;
        }
        if (!_endTime) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入结束日期"];
            [toastView show];
            return;
        }


    }
    if (_needCity == 1) {
        if (!_cityName) {
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"请输入城市名称"];
            [toastView show];
            return;
        }

    }
   
    
    
    
    if (_dateType == 1) {
        _endTime = @"";
    }
    if (_needCity == 0) {
        _cityName = @"";
    }
    if (_picIDArray) {
        
        
        //把数组转换成字符串
        NSString *picStr=[_picIDArray componentsJoinedByString:@","];
        _picUrl= picStr;
        MMLog(@"picArray == %@,ns == %@",_picIDArray,picStr);
        _picStr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"imgDes"];
    }else{
        _picUrl = @"";
    }
    if (!_memo) {
        _memo = @"";
    }
    MMLog(@"\\\\\\\\\\\\\\\\\%@==%@==%@==%@==%@==%@==%@==%@==%@==%@",_moneyNumber,_startTime,_endTime,_billNumber,_picUrl,_picStr,_memo,_cityName,[NSString stringWithFormat:@"%lu",_ID],_typePurchaseStr);
    NSDictionary *dic = @{@"moneyAmount":_moneyNumber,
                          @"spendBegin":_startTime,
                          @"spendEnd":_endTime,
                          @"billNum":_billNumber,
                          @"picUrl":_picUrl,
                          @"picDesc":_picStr,
                          @"detailMemo":_memo,
                          @"spendCity":_cityName,
                          @"ID":[NSString stringWithFormat:@"%lu",_ID],
                          @"typePurchaseStr":_typePurchaseStr
                          };
    
    
    __weak typeof(self) ws = self;
    // 点击保存时将数据存入本地数据库
    [MMDataBase initializeDatabaseWithTableName:t_purchaseRecord baseBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            // 表创建成功
            MMLog(@"表创建成功");
            // 添加判断数据是否存在的字段
//            NSDictionary *dic = (NSDictionary *)responseObject;
            NSMutableDictionary *mutableDic = dic.mutableCopy;
            [mutableDic setValue:@"exist" forKey:@"ID"];
            
            NSArray *resultPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                       NSUserDomainMask,
                                                                       YES);
            NSString *restltDocumentDirectory = [resultPaths lastObject];
            MMLog(@"path ===== path ======= %@",restltDocumentDirectory);

            
            // 保存数据
//            [MMDataBase saveItemDict:mutableDic tname:t_purchaseRecord];
            [MMDataBase saveItemWithMoneyAmount:_moneyNumber spendBegin:_startTime spendEnd:_endTime billNum:_billNumber picUrl:_picUrl picDesc:_picStr detailMemo:_memo spendCity:_cityName ID: [NSString stringWithFormat:@"%lu",_ID]typePurchaseStr:_typePurchaseStr];
            // 保存成功
            if (sender.tag == 701) {
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
                [toastView show];
                NSArray * ctrlArray = self.navigationController.viewControllers;
                [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
            }else if (sender.tag == 700){
                NSArray * ctrlArray = self.navigationController.viewControllers;
                [self.navigationController popToViewController:[ctrlArray objectAtIndex:3] animated:YES];
            }
            
            
//            [ws showData];
            
        }

    }];
    
    
    
    
    
    
    
    
//    [NetworkEntity postPreservePurchaseRecordWithSpendType:_ID moneyAmount:_moneyNumber billNum:_billNumber detailMemo:_memo picUrl:_picUrl picDesc:_picStr spendBegin:_startTime spendEnd:_endTime spendCity:_cityName Success:^(id responseObject) {
//        MMLog(@"PreservePurchaseRecord  =======responseObject=====%@",responseObject);
//        if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
//            // 提交成功
//            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"提交成功"];
//            [toastView show];
//            NSArray * ctrlArray = self.navigationController.viewControllers;
//            [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
//            
//        }
//    } failure:^(NSError *failure) {
//        MMLog(@"PreservePurchaseRecord  =======failure=====%@",failure);
//        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
//        [toastView show];
//    }];
}

- (void)showData{
    // 取出全部数据
    NSDictionary *dataBaseDic = [MMDataBase allDatalistWithTname:t_purchaseRecord];
            MMLog(@"数据库返回数据: %@",dataBaseDic);
}
- (void)didClickedWithCityName:(NSString *)cityName{
    _cityName = cityName;
    _cityCell.resultLabel.textColor = [UIColor blackColor];
    _cityCell.resultLabel.text =  cityName;
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
- (UIButton *)preservationButton{
    if (_preservationButton == nil) {
        _preservationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _preservationButton.frame = CGRectMake(0, self.view.height - 50 - 64, kBottomButtonW, 50);
        [_preservationButton setTitle:@"在记一笔" forState:UIControlStateNormal];
        [_preservationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_preservationButton addTarget:self action:@selector(didPreservationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_preservationButton setBackgroundColor:MM_MAIN_FONTCOLOR_BLUE];
        _preservationButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _preservationButton.tag = 700;
        
    }
    return _preservationButton;
}
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(CGRectGetMaxX(self.preservationButton.frame), self.view.height - 50 - 64, kBottomButtonW, 50);
        [_cancelButton setTitle:@"保存" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:MM_MAIN_BACKGROUND_COLOR forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(didPreservationButton:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancelButton.tag = 701;
        
    }
    return _cancelButton;
}

@end
