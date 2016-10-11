//
//  OverTimeRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeRecordCell.h"

#define fontSize 12

@interface OverTimeRecordCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic, strong) UIView *flagView;

@property (nonatomic, strong) UIImageView *flagImageView;

@property (nonatomic, strong) UILabel *flagLabel;

@property (nonatomic, strong) UIButton *flagBottomButon;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic ,strong) UILabel *applyTime;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic ,strong) UILabel *startTime;

@property (nonatomic ,strong) UILabel *endTime;





@end

@implementation OverTimeRecordCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.flagView];
    [self.flagView addSubview:self.flagImageView];
    [self.flagView addSubview:self.flagLabel];
    [self.bgView addSubview:self.flagBottomButon];

    [self.bgView addSubview:self.name];
    [self.bgView addSubview:self.applyTime];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.startTime];
    [self.bgView addSubview:self.endTime];
    
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
    }];
    
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(10);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@80);
        
    }];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.flagView.mas_centerX);
        make.centerY.mas_equalTo(self.flagView.mas_centerY);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@72);
        
    }];
    [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.flagView.mas_centerX);
        make.centerY.mas_equalTo(self.flagView.mas_centerY);
        make.width.mas_equalTo(self.flagView.mas_width);
        make.height.mas_equalTo(@14);
        
    }];


    
    [self.flagBottomButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flagView.mas_bottom);
        make.left.mas_equalTo(self.flagView.mas_left);
        make.right.mas_equalTo(self.flagView.mas_right);
        make.height.mas_equalTo(@20);
        
    }];


    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(15);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.right.mas_equalTo(self.flagView.mas_left).offset(-20);
        make.height.mas_equalTo(@15);
        
    }];
    
    [self.applyTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name.mas_bottom).offset(10);
        make.left.mas_equalTo(self.name.mas_left);
        make.right.mas_equalTo(self.name.mas_right);
        make.height.mas_equalTo(@fontSize);
        
    }];
    
    
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.applyTime.mas_bottom).offset(10);
        make.left.mas_equalTo(self.bgView.mas_left).offset(5);
        make.right.mas_equalTo(self.flagView.mas_left).offset(-5);
        make.height.mas_equalTo(@1);
        
        
    }];
    
    [self.startTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(self.name.mas_left);
        make.right.mas_equalTo(self.name.mas_right);
        make.height.mas_equalTo(@fontSize);
        
    }];
    [self.endTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.startTime.mas_bottom).offset(10);
        make.left.mas_equalTo(self.name.mas_left);
        make.right.mas_equalTo(self.name.mas_right);
        make.height.mas_equalTo(@fontSize);
        
    }];

    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor  =  [UIColor whiteColor];
        
    }
    return _bgView;
}
- (UIView *)flagView{
    if (_flagView == nil) {
        _flagView = [[UIView alloc] init];
        _flagView.backgroundColor = [UIColor whiteColor];
        _flagView.layer.borderWidth = 0.5;
        _flagView.layer.borderColor = [UIColor grayColor].CGColor;
        
    }
    return _flagView;
}
- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.backgroundColor = [UIColor clearColor];
    }
    return _flagImageView;
}

- (UILabel *)flagLabel{
    if (_flagLabel == nil) {
        _flagLabel = [[UILabel alloc] init];
        _flagLabel.font = [UIFont systemFontOfSize:14];
        _flagLabel.textColor = [UIColor blackColor];
        _flagLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _flagLabel;
}

- (UIButton *)flagBottomButon{
    if (_flagBottomButon == nil) {
        _flagBottomButon = [UIButton buttonWithType:UIButtonTypeCustom];
        _flagBottomButon.backgroundColor = [UIColor blackColor];
        [_flagBottomButon setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        _flagBottomButon.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_flagBottomButon setTitle:@"审批人:胡松" forState:UIControlStateNormal];
        
        
    }
    return _flagBottomButon;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.textColor = [UIColor blackColor];
        _name.text = @"张亚涛";
        
    }
    return _name;
}

- (UILabel *)applyTime{
    if (_applyTime == nil) {
        _applyTime = [[UILabel alloc] init];
        _applyTime.font = [UIFont systemFontOfSize:12];
        _applyTime.textColor = [UIColor grayColor];
        _applyTime.text = @"申请时间: 2016-8-30 20:34";
        
    }
    return _applyTime;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}



- (UILabel *)startTime{
    if (_startTime == nil) {
        _startTime = [[UILabel alloc] init];
        _startTime.font = [UIFont systemFontOfSize:12];
        _startTime.textColor = [UIColor grayColor];
        _startTime.text = @"开始时间: 2016-8-31 20:56";
        
    }
    return _startTime;
}
- (UILabel *)endTime{
    if (_endTime == nil) {
        _endTime = [[UILabel alloc] init];
        _endTime.font = [UIFont systemFontOfSize:12];
        _endTime.textColor = [UIColor grayColor];
        _endTime.text = @"结束时间: 2016-8-31 20:56";
        
    }
    return _endTime;
}
- (void)setListModel:(OverTimeRecordListModel *)listModel{
        _name.text = listModel.empName;
        _applyTime.text = [NSString stringWithFormat:@"申请时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.applyDate]];
        _startTime.text =  [NSString stringWithFormat:@"开始时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.beginTime]];
        _endTime.text = [NSString stringWithFormat:@"结束时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.endTime]];
    
    [_flagBottomButon setTitle:[NSString stringWithFormat:@"审批人:%@",listModel.applyMan] forState:UIControlStateNormal];
    MMLog(@"listModel.statusType == %lu",listModel.statusType);
    

    // 1 是通过，2 是正在审批，0 是审批未通过
    
    if (listModel.statusType == 0) {
        
    
        // 未通过
        _flagView.layer.borderColor = [UIColor colorWithHexString:@"d2d2d2"].CGColor;
        _flagImageView.image = [UIImage imageNamed:@"apply_no"];
        _flagLabel.text = @"未通过";
        
        _flagBottomButon.backgroundColor = [UIColor colorWithHexString:@"d2d2d2"];
        [_flagBottomButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }

    if (listModel.statusType == 1) {
        // 通过
        _flagView.layer.borderColor = MM_MAIN_FONTCOLOR_BLUE.CGColor;
        _flagImageView.image = [UIImage imageNamed:@"apply_pass"];
        _flagLabel.text = @"通过";
        
        _flagBottomButon.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        [_flagBottomButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        }
    if (listModel.statusType == 2) {
        
        
        _flagView.layer.borderColor = [UIColor colorWithHexString:@"323a45"].CGColor;
        _flagImageView.image = [UIImage imageNamed:@"apply_ing"];
        _flagLabel.text = @"审批中";
        _flagBottomButon.backgroundColor = [UIColor colorWithHexString:@"323a45"];
        [_flagBottomButon setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        
    
        
    }

    
    
    
    
    
}
@end

