//
//  LeaveRecordCell.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveRecordCell.h"


#define fontSize 12

@interface LeaveRecordCell ()

@property (nonatomic ,strong) UIView *bgView;

@property (nonatomic ,strong) UILabel *titleName;

@property (nonatomic ,strong) UIView *bottomBgView;

@property (nonatomic, strong) UIButton *flagButon;

@property (nonatomic, strong) UIButton *flagBottomButon;

@property (nonatomic, strong) UILabel *name;

@property (nonatomic ,strong) UILabel *applyTime;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic ,strong) UILabel *startTime;

@property (nonatomic ,strong) UILabel *endTime;





@end

@implementation LeaveRecordCell


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
    
    [self.bgView addSubview:self.titleName];
    [self.bgView addSubview:self.bottomBgView];
    
    [self.bottomBgView addSubview:self.flagButon];
    [self.bottomBgView addSubview:self.flagBottomButon];
    [self.bottomBgView addSubview:self.name];
    [self.bottomBgView addSubview:self.applyTime];
    [self.bottomBgView addSubview:self.lineView];
    [self.bottomBgView addSubview:self.startTime];
    [self.bottomBgView addSubview:self.endTime];
    
    
}
- (void)layoutSubviews{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
    }];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top);
        make.left.mas_equalTo(self.bgView.mas_left).offset(5);
        make.height.mas_equalTo(@20);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    [self.bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.left.mas_equalTo(self.bgView.mas_left);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.right.mas_equalTo(self.bgView.mas_right);
        
    }];
    
    [self.flagButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBgView.mas_top).offset(10);
        make.left.mas_equalTo(self.bottomBgView.mas_left).offset(20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@80);
        
    }];
    
    [self.flagBottomButon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flagButon.mas_bottom);
        make.left.mas_equalTo(self.flagButon.mas_left);
        make.right.mas_equalTo(self.flagButon.mas_right);
        make.height.mas_equalTo(@20);
        
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomBgView.mas_top).offset(15);
        make.left.mas_equalTo(self.flagButon.mas_right).offset(20);
        make.right.mas_equalTo(self.bottomBgView.mas_right);
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
        make.left.mas_equalTo(self.flagButon.mas_right).offset(5);
        make.right.mas_equalTo(self.bottomBgView.mas_right).offset(-5);
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
        _bgView.backgroundColor  =  [UIColor blackColor];
        
    }
    return _bgView;
}
- (UILabel *)titleName{
    if (_titleName == nil) {
        _titleName = [[UILabel alloc] init];
        _titleName.font = [UIFont systemFontOfSize:14];
        _titleName.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _titleName.text = @"家长会假";
        
    }
    return _titleName;
}

- (UIView *)bottomBgView{
    if (_bottomBgView == nil) {
        _bottomBgView = [[UIView alloc] init];
        _bottomBgView.backgroundColor  =  [UIColor whiteColor];
        
    }
    return _bottomBgView;
}
- (UIButton *)flagButon{
    if (_flagButon == nil) {
        _flagButon = [UIButton buttonWithType:UIButtonTypeCustom];
        _flagButon.backgroundColor = [UIColor clearColor];
        [_flagButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _flagButon.titleLabel.font = [UIFont systemFontOfSize:14];
        [_flagButon setImage:[UIImage imageNamed:@"apply_ing"] forState:UIControlStateNormal];
        [_flagButon setTitle:@"审批中" forState:UIControlStateNormal];
        _flagButon.layer.borderWidth = 0.5;
        _flagButon.layer.borderColor = [UIColor grayColor].CGColor;
        [_flagButon setImageEdgeInsets:UIEdgeInsetsMake(4, 20, 4, 20)];
        [_flagButon setTitleEdgeInsets:UIEdgeInsetsMake(20, -60, 10, 0)];
        
    }
    return _flagButon;
}
- (UIButton *)flagBottomButon{
    if (_flagBottomButon == nil) {
        _flagBottomButon = [UIButton buttonWithType:UIButtonTypeCustom];
        _flagBottomButon.backgroundColor = [UIColor blackColor];
        [_flagBottomButon setTitleColor:MM_MAIN_FONTCOLOR_BLUE forState:UIControlStateNormal];
        _flagBottomButon.titleLabel.font = [UIFont systemFontOfSize:12];
        [_flagBottomButon setTitle:@"审批人:胡松" forState:UIControlStateNormal];
        
        
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

//- (void)setListModel:(LeaveApprovalListModel *)listModel{
//    _name.text = listModel.empName;
//    _applyTime.text = [NSString stringWithFormat:@"申请时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.applyDate]];
//    _startTime.text =  [NSString stringWithFormat:@"开始时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.beginTime]];
//    _endTime.text = [NSString stringWithFormat:@"结束时间: %@",[NSDate dateFromSSWithDateType:@"yyyy-MM-dd HH:mm" ss:listModel.endTime]];
//    _leaveTypeLabel.text = listModel.name;
//    [_flagButon setTitle:[NSString stringWithFormat:@"%lu",_index] forState:UIControlStateNormal];
//    
//}
@end
