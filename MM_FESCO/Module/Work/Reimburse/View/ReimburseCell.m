//
//  ReimburseCell.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ReimburseCell.h"

@interface ReimburseCell ()

@property (nonatomic, strong) UIImageView *flageView;

@property (nonatomic ,strong) UILabel *titleLabel;

@property (nonatomic ,strong) UILabel *detailLabel;

@property (nonatomic ,strong) UILabel *moneyLabel;



@end

@implementation ReimburseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)initUI{
    
    [self addSubview:self.flageView];
    
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.detailLabel];
    
    [self addSubview:self.moneyLabel];
    
    
    
}
- (void)layoutSubviews{
    [self.flageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@20);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.flageView.mas_top);
        make.left.mas_equalTo(self.flageView.mas_right).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-150);
        make.height.mas_equalTo(@15);
        
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.mas_right).offset(-150);
        make.height.mas_equalTo(@13);
        
    }];

    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
        
    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}
#pragma mark ---- Lazy 加载

- (UIImageView *)flageView{
    if (_flageView == nil) {
        _flageView = [[UIImageView alloc] init];
        _flageView.backgroundColor = [UIColor cyanColor];
    }
    return _flageView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
        _titleLabel.text = @"出差";
        
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.text = @"待提交 | 日常报销单";
        
    }
    return _detailLabel;
}

- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.textColor = [UIColor grayColor];
        _moneyLabel.text = @"¥ 8894";

    }
    return _moneyLabel;
}
- (void)setModel:(ReimburseModel *)model{
    if (model.title) {
        _titleLabel.text = model.title;
    }
    
    //报销单状态  // 0待提交，1待审批，2待支付，3未通过，4已支付
    NSString *status = @"";
    if (model.statusReimburse == 0) {
        status = @"待提交";
        
    }
    if (model.statusReimburse == 1) {
        status = @"待审批";
    }
    if (model.statusReimburse == 2) {
        status = @"待支付";
    }
    if (model.statusReimburse == 3) {
        status = @"待通过";
    }
    if (model.statusReimburse == 4) {
        status = @"已支付";
    }
    if (model.statusReimburse == 0) {
        _flageView.image = [UIImage imageNamed:@"NewReimburseController_Commit"];
    }else{
        _flageView.image = [UIImage imageNamed:@"NewReimburseController_Apply"];
    }
    _detailLabel.text = [NSString stringWithFormat:@"%@ | %@",status,model.typeStr];
    NSArray *array = model.details;
    
    // 总金额
    NSInteger number = 0;
    for (NSDictionary *dic in array) {
        number = number + [[dic objectForKey:@"money_Amount"] integerValue];
    }
    _moneyLabel.text = [NSString stringWithFormat:@"¥ %lu",number];
    
    
//    if (model.details) {
//        NSArray *detailArray = model.details;
//        NSDictionary *dic = detailArray[0];
//        NSArray *array  = [dic objectForKey:@"pics"];
//        if (array.count) {
//            
//            NSDictionary *dic = array[0];
//            NSString *picUrl = [dic objectForKey:@"pic_Url"];
//            if (![picUrl isKindOfClass:[NSNull class]]) {
//                MMLog(@"picUrl = %@",picUrl);
//                 [_flageView  sd_setImageWithURL:[NSURL URLWithString:picUrl]];
//            }
//           
//        }
//        
//    }
    
}
@end
