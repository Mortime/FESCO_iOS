//
//  PersonalMessageHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/19.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageHeaderView.h"
#import "DVVImagePickerControllerManager.h"
#import "MMSwitchText.h"

@interface PersonalMessageHeaderView () <UIImagePickerControllerDelegate,UploadFiledProgressDelegate>

@property (nonatomic, strong) UIImageView *bgViewImg;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MMSwitchText *sexSwitch;

@property (strong, nonatomic) UIPickerView *pickerView;


@end


@implementation PersonalMessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgViewImg];
    [self.bgViewImg addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.imageView];
    [self.bgViewImg addSubview:self.nameLabel];
    [self.bgViewImg addSubview:self.sexSwitch];
    UITapGestureRecognizer *tapGesRe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIcon:)];
    [self.imageView addGestureRecognizer:tapGesRe];

}

- (void)selectIcon:(UIGestureRecognizer *)ges{
     [DVVImagePickerControllerManager showImagePickerControllerFrom:self.paramentVC delegate:self];
}

- (void)layoutSubviews{
    [self.bgViewImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
        
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgViewImg.mas_top).offset(10);
        make.centerX.mas_equalTo(self.bgViewImg.mas_centerX);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@80);
        
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.mas_equalTo(self.bgImageView.mas_centerX);
        make.centerY.mas_equalTo(self.bgImageView.mas_centerY);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@75);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
        make.height.mas_equalTo(@17);
        
    }];
    [self.sexSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.imageView.mas_centerX);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@30);
        
    }];

    

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
    
   NSData *cerData = [[NSData alloc] initWithBase64EncodedString:kHttpsCerBase64 options:0];
    NSSet * certSet = [[NSSet alloc] initWithObjects:cerData, nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    [securityPolicy setPinnedCertificates:certSet];
    manager.securityPolicy  = securityPolicy;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/uploadPic.json"];
    //2.上传文件
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"userHeader.png",@"uploadFile",[UserInfoModel defaultUserInfo].empId,@"emp_Id",[UserInfoModel defaultUserInfo].custId,@"cust_Id",nil];
    [manager POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
//        NSData* imageData = UIImagePNGRepresentation(photoImage);
        NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* totalPath = [documentPath stringByAppendingPathComponent:@"userAvatarInfo"];
        
        //保存到 document
        [photeoData writeToFile:totalPath atomically:NO];
        
        MMLog(@"totalPath = %@",totalPath);
        
        //保存到 NSUserDefaults
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:totalPath forKey:@"avatarInfo"];
        

        UIImage *selfPhoto = [UIImage imageWithContentsOfFile:totalPath];
        
        NSData *photeoData11 = UIImageJPEGRepresentation(selfPhoto, 0.5);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:photeoData11 forKey:kUsreIcon];

        
        //上传文件参数
        [formData appendPartWithFileData:photeoData11 name:@"uploadFile" fileName:@"userHeader.png" mimeType:@"image/png"];
        
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
   
    self.imageView.image = photoImage;
    
}


- (void)uploadFiledProgressDelegateWithSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    
//    CGFloat propress = totalBytesWritten*1.0/totalBytesExpectedToWrite;
//    dispatch_async(dispatch_get_main_queue(), ^{
////        self.propress=propress;
//    });
    
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
//        showSwitchValue.text = @"是";
    }else {
//        showSwitchValue.text = @"否";
    }
}
#pragma mark ----- icon
- (UIImageView *)bgViewImg{
    if (_bgViewImg == nil) {
        _bgViewImg = [[UIImageView alloc] init];
        _bgViewImg.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _bgViewImg.userInteractionEnabled = YES;
    }
    return _bgViewImg;
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
//        _bgImageView.image = [UIImage imageNamed:@"PersonalMes_BGImage"];
        _bgImageView.backgroundColor = [UIColor whiteColor];
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.cornerRadius = 40;
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.image = [UIImage imageNamed:@"People_placehode"];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 37.5;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
#pragma mark ----- name

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}
- (MMSwitchText *)sexSwitch {
    if (_sexSwitch == nil) {
        _sexSwitch = [[MMSwitchText alloc] init];
    }
    return _sexSwitch;
}

@end
