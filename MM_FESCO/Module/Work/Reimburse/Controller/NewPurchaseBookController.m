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


@interface NewPurchaseBookController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, QBImagePickerControllerDelegate>


@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) MPUploadImageHelper *curUploadImageHelper;

@end

@implementation NewPurchaseBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0eff5"];
    
    //初始化
    _curUploadImageHelper=[MPUploadImageHelper MPUploadImageForSend:NO];
    
//    //设置右边
//    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,70,30)];
//    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(myAction)forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem= rightItem;
//

    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
    return [MPImageUploadCell cellHeightWithObj:self.curUploadImageHelper];
    }
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *cellID = @"SubTitleID";
        NewPurchaseSubTitleCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;

    }
    if (indexPath.row == 1 || indexPath.row == 2) {
        static NSString *cellID = @"SubContentID";
         NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        if (indexPath.row == 1) {
            cell.textFiled.leftTitle = @"金额";
            cell.textFiled.placeHold = @"¥ 0.00";
            cell.textFiled.isExist = YES;
        }
        if (indexPath.row == 2) {
            cell.textFiled.leftTitle = @"日期";
            cell.textFiled.placeHold = @"请选择日期";
            cell.textFiled.isShowDataPickView = YES;
            cell.textFiled.timeType = @"yyyy-mm-dd";
        }

        
        
        return cell;
    }
    
    if (indexPath.row == 3) {
        static NSString *cellID = @"SubBook";
        NewPurchaseSubBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
                
        return cell;
    }
    if (indexPath.row == 4) {
        static NSString *cellID = @"UploadCell";
        MPImageUploadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[MPImageUploadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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


    if (indexPath.row == 5) {
        static NSString *cellID = @"ID";
        NewPurchaseSubContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[NewPurchaseSubContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
            cell.textFiled.leftTitle = @"描述";
            cell.textFiled.placeHold = @"我的描述";
        
        
        
        
        return cell;
    }

    
    return nil;
    

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
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    
    
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , self.view.width, self.view.height) style:UITableViewStylePlain];
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
