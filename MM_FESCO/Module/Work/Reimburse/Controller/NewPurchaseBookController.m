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
#import "EditMessageModel.h"
#import "NOBookChooseModel.h"
#define kBottomButtonW    ((kMMWidth) / 2)
@interface NewPurchaseBookController ()<UITableViewDelegate,UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate,CityListViewDelegate,NewPurchaseSubContentCellDelegate,NewPurchaseSubBookCellDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) MPUploadImageHelper *curUploadImageHelper;

@property (nonatomic, strong) UIButton *preservationButton;

@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong)  PurchaseCityCell *cityCell;

@property (nonatomic, strong) NSMutableArray *picIDArray;  // 新建是图片ID

@property (nonatomic, strong) NSMutableArray *huancunIDArray;  // 缓存图片id的数据,用于编辑消费记录未保存之前


@property (nonatomic, strong) NSMutableArray *picStreamArray;



@end

@implementation NewPurchaseBookController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
        [_picStreamArray removeAllObjects];
        for (NSDictionary *dic in _EditPicArray) {
            if (![[dic objectForKey:@"id"] isEqual:[NSNull null]] ) {
                [self postGetPicStreamforeWithPicId:[dic objectForKey:@"id"] Success:^(id responseObject) {
                    MMLog(@"GetPicStreamforeWithPicId ====responseObject==== %@",responseObject);
                    UIImage *image = [UIImage imageWithData:responseObject];
                    MPImageItemModel *model = [[MPImageItemModel alloc] init];
                    model.thumbnailImage = image;
                    model.image= image;
                    [_picStreamArray addObject:model];
                    MMLog(@"_picStreamArray = %@",_picStreamArray);
                    [_tableView reloadData];
                    
                } failure:^(NSError *failure) {
                    MMLog(@"GetPicStreamforeWithPicId ====failure==== %@",failure);
                }];
                
                
            }
        }
    

    }
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    self.picIDArray = [NSMutableArray array];
    self.huancunIDArray = [NSMutableArray array];
    self.picStreamArray = [NSMutableArray array];
    //初始化
    _curUploadImageHelper=[MPUploadImageHelper MPUploadImageForSend:NO];

    _curUploadImageHelper.imagesArray = self.picStreamArray;

    _billNumber = @"1";

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.cancelButton];
    [self.view addSubview:self.preservationButton];
    
    
    // 注册一个通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPicID) name:kPicUpSuccessNotifition object:nil];
   // 未制单消费编辑时,给提交数据赋值
    
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
        if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
            cell.textFiled.textFileStr = _moneyNumber;
        }
            cell.textFiled.placeHold = @"¥ 0.00";
            cell.textFiled.isExist = YES;
        cell.textFiled.rightTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
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
        if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
            cell.textFiled.textFileStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:_startTime];
        }
       
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
            
            if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
                cell.textFiled.textFileStr = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:_endTime];
            }

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
        if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
            cell.addOffView.resultLabel.text = _billNumber;
        }
                
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
        
        if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
//            self.curUploadImageHelper.selectedAssetURLs = self.urlArray;
            
        }
        
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
        if ((_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) && ![_memo isKindOfClass:[NSNull class]]) {
            cell.textFiled.textFileStr = _memo;
        }
        
        return cell;
    }
    
    if ((_dateType == 1) ? (indexPath.row == 6):(indexPath.row == 7)) {
        static NSString *cellID = @"CityID";
        PurchaseCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[PurchaseCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        _cityCell = cell;
        
        if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
            cell.resultLabel.text = _cityName;
        }
        return cell;

    }

    
    return [UITableViewCell new];
    

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
    NSString *ns=[[NSUserDefaults standardUserDefaults] objectForKey:kPicUpSuccessID];
    
    if (_bookType == editReimburseBook ) {
        [_picIDArray addObject:ns];
    }else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:ns forKey:@"id"];
        [_huancunIDArray addObject:dic];
    }
    
}
#pragma mark 自定义代码

//弹出选择框
-(void)showActionForPhoto
{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        MMLog(@"点击了取消按钮");
    }];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照
        if (![cameraHelper checkCameraAuthorizationStatus]) {
            return;
        }
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;//设置可编辑
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];//进入照相界面
    }];
    UIAlertAction *chooseAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 从相册选择
        if (![cameraHelper checkPhotoLibraryAuthorizationStatus]) {
            return;
        }
        QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
        [imagePickerController.selectedAssets removeAllObjects];
        [imagePickerController.selectedAssets addObjectsFromArray:self.curUploadImageHelper.selectedAssetURLs];
        imagePickerController.mediaType = QBImagePickerMediaTypeImage;
        imagePickerController.delegate = self;
        imagePickerController.maximumNumberOfSelection = kupdateMaximumNumberOfImage;
        imagePickerController.allowsMultipleSelection = YES;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
        [self presentViewController:navigationController animated:YES completion:NULL];

    }];
    
    [alertController addAction:OKAction];
    [alertController addAction:chooseAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
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
    [imagePickerController.selectedAssets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MMLog(@"obj == %@",obj);
        [selectedAssetURLs addObject:obj];
    }];
    if (_bookType == editReimburseBook || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
//        [selectedAssetURLs addObjectsFromArray:_urlArray];
    }
//    _urlArray = selectedAssetURLs;
    MMLog(@"selectedAssetURLs = %@",selectedAssetURLs);
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
    
    
     // 1. 报销单消费网络编辑
    if (_bookType == PurchaseNetworkEdit) {
        if (sender.tag == 700 && _sectionTag == 2) {
            // 删除
            [_networkArrayEdit removeObjectAtIndex:_indexTag];
            if ([_delegate respondsToSelector:@selector(newPurchaseBookControllerDelegateWith:sectionTag:)]) {
                [_delegate newPurchaseBookControllerDelegateWith:_networkArrayEdit sectionTag:_sectionTag];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else if (sender.tag == 701 && _sectionTag == 2){
            
            EditMessageModel *model = _networkArrayEdit[_indexTag];
            model.moneyAmount = [_moneyNumber floatValue];
            model.spendBegin = _startTime;
            model.spendEnd = _endTime;
            model.billNum = [_billNumber integerValue];
            model.detailMemo = _memo;
            model.cityName = _cityName;
            // 图片数组
            NSArray *picArray = model.picArray;
            NSMutableArray *muArray = picArray.mutableCopy;
            for (NSDictionary *dic in _huancunIDArray) {
                [muArray addObject:dic];
            }
            model.picArray = muArray;
            
            [_networkArrayEdit replaceObjectAtIndex:_indexTag withObject:model];
            if ([_delegate respondsToSelector:@selector(newPurchaseBookControllerDelegateWith:sectionTag:)]) {
                [_delegate newPurchaseBookControllerDelegateWith:_networkArrayEdit sectionTag:_sectionTag];
            }
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
        // 2. 报销单消费记录本地编辑
        if (_bookType == PurchaseBenDiEdit) {
            if (sender.tag == 700 && _sectionTag == 3) {
                // 删除
                [_networkArrayEdit removeObjectAtIndex:_indexTag];
                if ([_delegate respondsToSelector:@selector(newPurchaseBookControllerDelegateWith:sectionTag:)]) {
                    [_delegate newPurchaseBookControllerDelegateWith:_networkArrayEdit sectionTag:_sectionTag];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else if (sender.tag == 701 && _sectionTag == 3){
                
                NSDictionary *dic = _networkArrayEdit[_indexTag];
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
                NSMutableDictionary *mutDic = dic.mutableCopy;
                [mutDic setValue:_moneyNumber forKey:@"moneyAmount"];
                [mutDic setValue:_startTime forKey:@"spendBegin"];
                [mutDic setValue:_endTime forKey:@"spendEnd"];
                [mutDic setValue:_billNumber forKey:@"billNum"];
                [mutDic setValue:_memo forKey:@"detailMemo"];
                [mutDic setValue:_cityName forKey:@"spendCity"];
                [mutDic setValue:[NSString stringWithFormat:@"%lu",_ID] forKey:@"ID"];
                [mutDic setValue:_picUrl forKey:@"picUrl"];
                [_networkArrayEdit replaceObjectAtIndex:_indexTag withObject:mutDic];
                [[NSUserDefaults standardUserDefaults] setObject:_networkArrayEdit forKey:kReimburseRecordList];
                [self.navigationController popViewControllerAnimated:YES];
            }
 
        }
        
        // 3. 报销单消费记录未制单编辑
        if (_bookType == PurchaseNOBookEdit) {
            
            if (sender.tag == 700 && _sectionTag == 4) {
                // 删除
                [_networkArrayEdit removeObjectAtIndex:_indexTag];
                if ([_delegate respondsToSelector:@selector(newPurchaseBookControllerDelegateWith:sectionTag:)]) {
                    [_delegate newPurchaseBookControllerDelegateWith:_networkArrayEdit sectionTag:_sectionTag];
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else if (sender.tag == 701 && _sectionTag == 4){
                
                NOBookChooseModel *model = _networkArrayEdit[_indexTag];
                model.moneyAmount = [_moneyNumber floatValue];
                model.spendBegin = _startTime;
                model.spendEnd = _endTime;
                model.billNum = [_billNumber integerValue];
                model.detailMemo = _memo;
                model.cityName = _cityName;
                // 图片数组
                NSArray *picArray = model.picArray;
                NSMutableArray *muArray = picArray.mutableCopy;
                for (NSDictionary *dic in _huancunIDArray) {
                    [muArray addObject:dic];
                }
                model.picArray = muArray;
                
                
                [_networkArrayEdit replaceObjectAtIndex:_indexTag withObject:model];
                if ([_delegate respondsToSelector:@selector(newPurchaseBookControllerDelegateWith:sectionTag:)]) {
                    [_delegate newPurchaseBookControllerDelegateWith:_networkArrayEdit sectionTag:_sectionTag];
                }
                [self.navigationController popViewControllerAnimated:YES];
                
            }

        }
        
    // 未制单消费模块消费记录编辑
        if (_bookType == NOBookPurchaseEdit) {
            if (sender.tag == 700) {
                // 删除
                [NetworkEntity postDeleReimburseRecordWithDetailId:_noBookmodel.detailId Success:^(id responseObject) {
                    MMLog(@"DeleReimburseRecord  =======responseObject=====%@",responseObject);
                    if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"删除成功"];
                        [toastView show];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"删除失败"];
                        [toastView show];
                    }
                    
                } failure:^(NSError *failure) {
                    MMLog(@"DeleReimburseRecord  =======failure=====%@",failure);
                    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                    [toastView show];
                }];

            } else if (sender.tag == 701){
                // 保存
                // 空数据判断
                [self showMessageNoData];
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
                    NSString *picID=[_picIDArray componentsJoinedByString:@","];
                    _picUrl= picID;
                    MMLog(@"picArray == %@,ns == %@",_picIDArray,picID);
                }else{
                    _picUrl = @"";
                }
                if (!_memo) {
                    _memo = @"";
                }

                NSString *detail = [NSString stringWithFormat:@"%lu",_noBookmodel.detailId];
                [NetworkEntity postPreservePurchaseRecordWithSpendType:_ID moneyAmount:_moneyNumber billNum:_billNumber detailMemo:_memo picUrl:_picUrl spendBegin:_startTime spendEnd:_endTime spendCity:_cityName detailId:detail Success:^(id responseObject) {
                    MMLog(@"PreservePurchaseRecord  =======responseObject=====%@",responseObject);
                    if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
                        [toastView show];
                        NSArray * ctrlArray = self.navigationController.viewControllers;
                        [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
                        
                        
                        
                    }else{
                        ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存失败"];
                        [toastView show];
                    }
                } failure:^(NSError *failure) {
                    MMLog(@"PreservePurchaseRecord  =======failure=====%@",failure);
                    ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
                    [toastView show];
                }];
                
            }
        }
        
    }
        
        
    if (_bookType == noBookPurchase) {
        //在记一笔 保存未制单消费
        NSString *detail = @"";
        [NetworkEntity postPreservePurchaseRecordWithSpendType:_ID moneyAmount:_moneyNumber billNum:_billNumber detailMemo:_memo picUrl:_picUrl spendBegin:_startTime spendEnd:_endTime spendCity:_cityName detailId:detail Success:^(id responseObject) {
            MMLog(@"PreservePurchaseRecord  =======responseObject=====%@",responseObject);
            if ([[responseObject objectForKey:@"errcode"] integerValue] == 0) {
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
                [toastView show];
                NSArray * ctrlArray = self.navigationController.viewControllers;
                [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
                
                
                
            }else{
                ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存失败"];
                [toastView show];
            }
        } failure:^(NSError *failure) {
            MMLog(@"PreservePurchaseRecord  =======failure=====%@",failure);
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"网络错误"];
            [toastView show];
        }];

    }
    // 新建消费记录
    if (_bookType == newReimburseBook) {
        // 空数据判断
        [self showMessageNoData];
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
            NSString *picID=[_picIDArray componentsJoinedByString:@","];
            _picUrl= picID;
            MMLog(@"picArray == %@,ns == %@",_picIDArray,picID);
        }else{
            _picUrl = @"";
        }
        if (!_memo) {
            _memo = @"";
        }

        // 添加报销单的消费记录
        MMLog(@"\\\\\\\\\\\\\\\\\%@==%@==%@==%@==%@==%@==%@==%@==%@",_moneyNumber,_startTime,_endTime,_billNumber,_picUrl,_memo,_cityName,[NSString stringWithFormat:@"%lu",_ID],_typePurchaseStr);
        NSDictionary *dic = @{@"moneyAmount":_moneyNumber,
                              @"spendBegin":_startTime,
                              @"spendEnd":_endTime,
                              @"billNum":_billNumber,
                              @"picUrl":_picUrl,
                              @"detailMemo":_memo,
                              @"spendCity":_cityName,
                              @"icon":self.icon,
                              @"ID":[NSString stringWithFormat:@"%lu",_ID],
                              @"typePurchaseStr":_typePurchaseStr
                              };
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kReimburseRecordList];
        if (array.count == 0) {
            array = [NSArray array];
        }
        NSMutableArray *mutArray = array.mutableCopy;
        [mutArray addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:mutArray forKey:kReimburseRecordList];
        
        
        // 保存成功
        if (sender.tag == 701) {
            // 保存
            ToastAlertView *toastView = [[ToastAlertView alloc] initWithTitle:@"保存成功"];
            [toastView show];
            NSArray * ctrlArray = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[ctrlArray objectAtIndex:1] animated:YES];
        }else if (sender.tag == 700){
            // 在记一笔
            NSArray * ctrlArray = self.navigationController.viewControllers;
            [self.navigationController popToViewController:[ctrlArray objectAtIndex:2] animated:YES];
        }

    }

    
}

- (void)showData{
    // 取出全部数据
    NSDictionary *dataBaseDic = [MMDataBase allDatalistWithTname:t_purchaseRecord];
            MMLog(@"数据库返回数据: %@",dataBaseDic);
}

- (void)postGetPicStreamforeWithPicId:(NSString *)picId Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSData *cerData = [[NSData alloc] initWithBase64EncodedString:kHttpsCerBase64 options:0];
    NSSet * certSet = [[NSSet alloc] initWithObjects:cerData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    [securityPolicy setPinnedCertificates:certSet];
    manager.securityPolicy  = securityPolicy;

    
    NSDictionary *dic = @{
                          @"pic_Id":picId,
                          @"methodname":@"expense/getPicStream.json"
                          };
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/getPicStream.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    [manager POST:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}



- (void)didClickedWithCityName:(NSString *)cityName{
    _cityName = cityName;
    _cityCell.resultLabel.textColor = [UIColor blackColor];
    _cityCell.resultLabel.text =  cityName;
}

- (void)showMessageNoData{
    
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
        if (_bookType == NOBookPurchaseEdit || _bookType == PurchaseNetworkEdit || _bookType == PurchaseBenDiEdit ||_bookType == PurchaseNOBookEdit) {
            // 未制单消费
            [_preservationButton setTitle:@"删除" forState:UIControlStateNormal];
        }else{
            [_preservationButton setTitle:@"在记一笔" forState:UIControlStateNormal];
        }
        
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
