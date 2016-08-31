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


@end
@implementation FillApplyView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.signType];
    [self addSubview:self.signTime];
    [self addSubview:self.signAddress];
    [self addSubview:self.signReason];
    [self addSubview:self.checkPerson];
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
}
- (MMChooseTextFile *)signType{
    if (_signType == nil) {
        _signType = [[MMChooseTextFile alloc] init];
        _signType.leftTitle = @"签到类型";
        _signType.placeHold = @"请选择签到类型";
        
    }
    return _signType;
}
- (MMChooseTextFile *)signTime{
    if (_signTime == nil) {
        _signTime = [[MMChooseTextFile alloc] init];
        _signTime.leftTitle = @"签到时间";
        _signTime.placeHold = @"请选择签到时间";
        
    }
    return _signTime;
}

- (MMChooseTextFile *)signAddress{
    if (_signAddress == nil) {
        _signAddress = [[MMChooseTextFile alloc] init];
        _signAddress.leftTitle = @"签到地点";
        _signAddress.placeHold = @"请选择签到地点";
        
    }
    return _signAddress;
}
- (MMChooseTextFile *)signReason{
    if (_signReason == nil) {
        _signReason = [[MMChooseTextFile alloc] init];
        _signReason.leftTitle = @"补签原因";
        _signReason.placeHold = @"请输入补签原因";
        
    }
    return _signReason;
}
- (MMChooseTextFile *)checkPerson{
    if (_checkPerson == nil) {
        _checkPerson = [[MMChooseTextFile alloc] init];
        _checkPerson.leftTitle = @"审批人";
        _checkPerson.placeHold = @"请选择审批人";
        
    }
    return _checkPerson;
}


@end
