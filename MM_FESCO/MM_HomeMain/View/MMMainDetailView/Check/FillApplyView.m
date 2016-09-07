//
//  FillApplyView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "FillApplyView.h"
#import "MMChooseTextFile.h"


@interface FillApplyView ()

// 签到类型
@property (nonatomic, strong) MMChooseTextFile *signType;

// 签到时间
@property (nonatomic, strong) MMChooseTextFile *signTime;

// 签到地点
@property (nonatomic, strong) MMChooseTextFile *signAddress;

// 签到原因
@property (nonatomic, strong) MMChooseTextFile *signReason;

// 审批人
@property (nonatomic, strong) MMChooseTextFile *checkPerson;

//
@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end
@implementation FillApplyView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.signType];
    [self addSubview:self.signTime];
    [self addSubview:self.signAddress];
    [self addSubview:self.signReason];
    [self addSubview:self.checkPerson];
    [self addSubview:self.commitButton];
}
- (void)layoutSubviews{
    [self.signType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(@44);
    }];
    [self.signTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signType.mas_bottom).offset(10);
        make.left.mas_equalTo(self.signType.mas_left);
        make.right.mas_equalTo(self.signType.mas_right);
        make.height.mas_equalTo(@44);
    }];
    [self.signAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signTime.mas_bottom).offset(10);
        make.left.mas_equalTo(self.signType.mas_left);
        make.right.mas_equalTo(self.signType.mas_right);
        make.height.mas_equalTo(@44);
    }];
    [self.signReason mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signAddress.mas_bottom).offset(10);
        make.left.mas_equalTo(self.signType.mas_left);
        make.right.mas_equalTo(self.signType.mas_right);
        make.height.mas_equalTo(@44);
    }];
    [self.checkPerson mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.signReason.mas_bottom).offset(10);
        make.left.mas_equalTo(self.signType.mas_left);
        make.right.mas_equalTo(self.signType.mas_right);
        make.height.mas_equalTo(@44);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(@50);
    }];
}
-(void)initData{
    __weak typeof(self) ws = self;
    
    [MMDataBase isExistWithId:@"exist" tname:t_applySignup isExist:^(BOOL isExist) {
        if (isExist) {
            // 数据已经存在
            [ws showData];
            
        }else{
            // 数据不存在,进行网络请求
            [NetworkEntity postApplyPeopleListWithSuccess:^(id responseObject) {
                
//                MMLog(@"ApplyPeopleList =====responseObject======%@",responseObject);
                [MMDataBase initializeDatabaseWithTableName:t_applySignup baseBlock:^(BOOL isSuccess) {
                    if (isSuccess) {
                        // 表创建成功
                        MMLog(@"表创建成功");
                        // 添加判断数据是否存在的字段
                        NSDictionary *dic = (NSDictionary *)responseObject;
                        NSMutableDictionary *mutableDic = dic.mutableCopy;
                        [mutableDic setValue:@"exist" forKey:@"ID"];
                        
                        // 保存数据
                        [MMDataBase saveItemDict:mutableDic tname:t_applySignup];
                        [ws showData];
                        
                    }
                    
                }];
                
                
            } failure:^(NSError *failure) {
                MMLog(@"ApplyPeopleList =====failure======%@",failure);
            }];
            
            
        }
        
    }];
    
}
- (void)showData{
    // 取出全部数据
    NSDictionary *dataBaseDic = [MMDataBase allDatalistWithTname:t_applySignup];
//        MMLog(@"数据库返回数据: %@",dataBaseDic);
    
    NSArray *resultPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                               NSUserDomainMask,
                                                               YES);
    NSString *restltDocumentDirectory = [resultPaths lastObject];
    MMLog(@"path ===== path ======= %@",restltDocumentDirectory);
    
    
    NSArray *param = [dataBaseDic objectForKey:@"approvalManList"];
    if (param.count) {
        for (NSDictionary *dic in param) {
            NSString *name = [dic objectForKey:@"emp_Name"];
            [self.dataArray addObject:name];
        }
    }


}
- (void)initWithTextFile:(UITextField *)textfile indexTag:(NSInteger)indexTag{
    if (indexTag == 400 ) {
        // 签到类型
        MMLog(@"签到类型回调");
    }
    if (indexTag == 401 ) {
        // 签到时间
         MMLog(@"签到时间回调");
    }
    if (indexTag == 402 ) {
        // 签到地点
         MMLog(@"签到地点回调");
    }
    if (indexTag == 403 ) {
        // 补签原因
         MMLog(@"补签原因回调");
    }
    if (indexTag == 404 ) {
        // 审批人
         MMLog(@"审批人回调");
    }
}
#pragma mark ---- Action
- (void)didSignButon:(UIButton *)sender{
    
}
- (MMChooseTextFile *)signType{
    if (_signType == nil) {
        _signType = [[MMChooseTextFile alloc] init];
        _signType.leftTitle = @"签到类型";
        _signType.placeHold = @"请选择签到类型";
        NSArray *typeArray = @[@"签到",@"签退",@"外勤"];
        _signType.dataArray = typeArray;
        _signType.tag = 400;
        [_signType dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];
    
        
        
    }
    return _signType;
}
- (MMChooseTextFile *)signTime{
    if (_signTime == nil) {
        _signTime = [[MMChooseTextFile alloc] init];
        _signTime.leftTitle = @"签到时间";
        _signTime.placeHold = @"请选择签到时间";
        _signTime.isShowDataPickView = YES;
        _signTime.tag = 401;
        [_signTime dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];

        
    }
    return _signTime;
}

- (MMChooseTextFile *)signAddress{
    if (_signAddress == nil) {
        _signAddress = [[MMChooseTextFile alloc] init];
        _signAddress.leftTitle = @"签到地点";
        _signAddress.placeHold = @"请选择签到地点";
        NSArray *addressArray = @[@"外企",@"丹棱街5号",@"东方美"];
        _signAddress.dataArray = addressArray;
        _signAddress.tag = 402;
        [_signAddress dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];

        
    }
    return _signAddress;
}
- (MMChooseTextFile *)signReason{
    if (_signReason == nil) {
        _signReason = [[MMChooseTextFile alloc] init];
        _signReason.leftTitle = @"补签原因";
        _signReason.placeHold = @"请输入补签原因";
        _signReason.isExist = YES;
        _signReason.tag = 403;
        [_signReason dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];

        
    }
    return _signReason;
}
- (MMChooseTextFile *)checkPerson{
    if (_checkPerson == nil) {
        _checkPerson = [[MMChooseTextFile alloc] init];
        _checkPerson.leftTitle = @"审批人";
        _checkPerson.placeHold = @"请选择审批人";
        _checkPerson.tag = 404;
        _checkPerson.dataArray = self.dataArray;
        [_checkPerson dvv_setTextFieldDidEndEditingBlock:^(UITextField *textField, NSInteger indexTag) {
            [self initWithTextFile:textField indexTag:indexTag];
        }];

        
    }
    return _checkPerson;
}

- (UIButton *)commitButton {
    
    if (_commitButton == nil) {
        _commitButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_commitButton setTitle:@"提交申请" forState:UIControlStateNormal];
        _commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_commitButton addTarget:self action:@selector(didSignButon:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _commitButton;
    
}
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
