//
//  PersonalMessageHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/19.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageHeaderView.h"
#import "DVVImagePickerControllerManager.h"

@interface PersonalMessageHeaderView () <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIView *nameBG;

@property (nonatomic, strong) UILabel *nameLabel;


@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *sexBG;

@property (nonatomic, strong) UILabel *sexLabel;


@property (nonatomic, strong) UIButton *flagButton;

@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) NSArray *dataArray;

@property (nonatomic, strong) DVVSearchViewUITextFieldDelegateBlock didEndEditingBlock;


@end


@implementation PersonalMessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.nameTextFiled.delegate = self;
        self.sexTextFiled.delegate = self;
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.imageView];
    
    [self.bgView addSubview:self.nameBG];
    [self.nameBG addSubview:self.nameLabel];
    [self.nameBG addSubview:self.nameTextFiled];

    [self.bgView addSubview:self.lineView];

    [self.bgView addSubview:self.sexBG];
    [self.sexBG addSubview:self.sexLabel];
    [self.sexBG addSubview:self.sexTextFiled];
    [self.sexBG addSubview:self.flagButton];
    
    
    self.sexTextFiled.inputView = self.pickerView;
    
    UITapGestureRecognizer *tapGesRe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIcon:)];
    [self.imageView addGestureRecognizer:tapGesRe];


}

- (void)selectIcon:(UIGestureRecognizer *)ges{
     [DVVImagePickerControllerManager showImagePickerControllerFrom:self.paramentVC delegate:self];
}

- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle {
    _didEndEditingBlock = handle;
}
- (void)layoutSubviews{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
        
    }];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@70);
        
    }];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerX.mas_equalTo(self.bgImageView.mas_centerX);
        make.centerY.mas_equalTo(self.bgImageView.mas_centerY);
        make.width.mas_equalTo(@65);
        make.height.mas_equalTo(@65);
        
    }];
    [self.nameBG mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgImageView.mas_right).offset(20);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@60);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.nameBG.mas_left).offset(0);
        make.centerY.mas_equalTo(self.nameBG.mas_centerY);
        make.width.mas_equalTo(@35);
        make.height.mas_equalTo(@15);
        
    }];
    [self.nameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.nameBG.mas_centerY);
        make.right.mas_equalTo(self.nameBG.mas_right);
        make.height.mas_equalTo(self.nameBG.mas_height);
        
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.bgImageView.mas_right).offset(15);
        make.top.mas_equalTo(self.nameBG.mas_bottom);
        make.right.mas_equalTo(self.bgView.mas_right);
        make.height.mas_equalTo(@1);
        
    }];

    [self.sexBG mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.left.mas_equalTo(self.nameBG.mas_left);
        make.right.mas_equalTo(self.nameBG.mas_right);
        make.height.mas_equalTo(@60);
        
    }];
    [self.sexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.sexBG.mas_left).offset(0);
        make.centerY.mas_equalTo(self.sexBG.mas_centerY);
        make.width.mas_equalTo(@35);
        make.height.mas_equalTo(@15);
        
    }];
    [self.sexTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.mas_equalTo(self.sexLabel.mas_right).offset(15);
        make.centerY.mas_equalTo(self.sexBG.mas_centerY);
        make.right.mas_equalTo(self.sexBG.mas_right).offset(-50);
        make.height.mas_equalTo(self.sexBG.mas_height);
        
    }];
    [self.flagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.centerY.mas_equalTo(self.sexBG.mas_centerY);
        make.right.mas_equalTo(self.sexBG.mas_right).offset(-50);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@22);
        
    }];


}

#pragma mark ---- UITextFileDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textColor = MM_MAIN_FONTCOLOR_BLUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.textColor = [UIColor whiteColor];
    if (textField.tag == 200) {
        if (_didEndEditingBlock) {
                _didEndEditingBlock(textField);
            }
    }
}
#pragma mark ------ UIPickViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *resultString = self.dataArray[row];
    self.sexTextFiled.text = resultString;
    
    if (_didEndEditingBlock) {
        _didEndEditingBlock(self.sexTextFiled);
    }

}
#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.imageView.image = photoImage;
    
//    __weak typeof(self) weakself = self;
//    __block NSData *gcdPhotoData = photeoData;
//    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
//    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        
//        NSDictionary *dataDic = data;
//        NSString *qiniuToken = dataDic[@"data"];
//        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
//        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[AcountManager manager].userid];
//        
//        [upLoadManager putData:gcdPhotoData key:keyUrl token:qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            if (info) {
//                
//                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
//                NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,@"userinfo/updateuserinfo"];
//                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};
//                
//                NSDictionary *dicParam = @{@"headportrait":[JsonTransformManager dictionaryTransformJsonWith:headPortrait],@"userid":[AcountManager manager].userid};
//                [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
//                    NSDictionary *dataParam = data;
//                    NSNumber *messege = dataParam[@"type"];
//                    if (messege.intValue == 1) {
//                        [self showTotasViewWithMes:@"修改成功"];
//                        [AcountManager saveUserHeadImageUrl:upImageUrl];
//                        [weakself.iconImageView sd_setImageWithURL:[NSURL URLWithString:[AcountManager manager].userHeadImageUrl] placeholderImage:[UIImage imageWithData:gcdPhotoData]];
//                        [[NSNotificationCenter defaultCenter] postNotificationName:YBNotif_ChangeUserPortrait object:nil];
//                        
//                    }else {
//                        [self obj_showTotasViewWithMes:@"修改失败"];
//                        
//                        return;
//                    }
//                }];
//            }
//        } option:nil];
//    }];
}
#pragma mark ----- Acction
- (void)didClickSex:(UIButton *)btn{
    [self.sexTextFiled becomeFirstResponder];
}
#pragma mark ----- icon
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        _bgImageView = [[UIImageView alloc] init];
//        _bgImageView.image = [UIImage imageNamed:@"PersonalMes_BGImage"];
        _bgImageView.backgroundColor = [UIColor whiteColor];
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.layer.cornerRadius = 35;
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
        _imageView.layer.cornerRadius = 32.5;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
#pragma mark ----- name
- (UIView *)nameBG{
    if (_nameBG == nil) {
        _nameBG = [[UIView alloc] init];
        _nameBG.backgroundColor = [UIColor clearColor];
    }
    return _nameBG;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"姓名";
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    }
    return _nameLabel;
}
- (UITextField *)nameTextFiled{
    if (_nameTextFiled == nil) {
        _nameTextFiled = [[UITextField alloc] init];
        _nameTextFiled.placeholder = @"姓名";
        [_nameTextFiled setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_nameTextFiled setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _nameTextFiled.font = [UIFont systemFontOfSize:15];
        _nameTextFiled.textColor = [UIColor whiteColor];
        _nameTextFiled.backgroundColor = [UIColor clearColor];
        _nameTextFiled.tag = 200;
        _nameTextFiled.userInteractionEnabled = NO;
        
   
    }
    return _nameTextFiled;
}
#pragma mark ----- Line
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = MM_MAIN_LINE_COLOR;
    }
    return _lineView;
}
#pragma mark ----- sex
- (UIView *)sexBG{
    if (_sexBG == nil) {
        _sexBG = [[UIView alloc] init];
        _sexBG.backgroundColor = [UIColor clearColor];
    }
    return _sexBG;
}

- (UILabel *)sexLabel{
    if (_sexLabel == nil) {
        _sexLabel = [[UILabel alloc] init];
        _sexLabel.text = @"性别";
        _sexLabel.font = [UIFont systemFontOfSize:15];
        _sexLabel.backgroundColor = [UIColor clearColor];
        _sexLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    }
    return _sexLabel;
}
- (UITextField *)sexTextFiled{
    if (_sexTextFiled == nil) {
        _sexTextFiled = [[UITextField alloc] init];
        _sexTextFiled.placeholder = @"性别";
        [_sexTextFiled setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [_sexTextFiled setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _sexTextFiled.font = [UIFont systemFontOfSize:15];
        _sexTextFiled.textColor = [UIColor whiteColor];
        _sexTextFiled.backgroundColor = [UIColor clearColor];
        _sexTextFiled.tag = 201;
    
        
    }
    return _sexTextFiled;
}
- (UIButton *)flagButton{
    if (_flagButton == nil) {
        _flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flagButton setBackgroundImage:[UIImage imageNamed:@"PersonalMes_FlagButton"] forState:UIControlStateNormal];
        [_flagButton addTarget:self action:@selector(didClickSex:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _flagButton;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@"男",@"女"];
    }
    return _dataArray;
}
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = MM_MAIN_BACKGROUND_COLOR;
    }
    return _pickerView;
}
@end
