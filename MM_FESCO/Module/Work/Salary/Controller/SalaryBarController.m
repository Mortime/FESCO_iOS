//
//  SalaryBarController.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SalaryBarController.h"
#import "SalaryBarHeaderView.h"
#import "SalaryBarCell.h"
#import "SalaryBarSectionView.h"

@interface SalaryBarController ()<UITableViewDelegate,UITableViewDataSource,SalaryBarSectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@property (nonatomic, strong) UIView *headerBgView;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) SalaryBarHeaderView *tagView;

@property (nonatomic, strong) UIView *textBgView;

@property (nonatomic, strong) UILabel *salaryTypeLabel;

@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) NSString *yearText;

@property (nonatomic, strong) NSMutableArray *yearsArray;

@property (nonatomic, strong) NSMutableArray *monthArray;



@end

@implementation SalaryBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"工资数据汇总";
    _monthArray = [NSMutableArray array];
    _yearsArray = [self yearsData];
    _yearText =[_yearsArray lastObject];
    self.view.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    [self initUI];
    [self initData];
    
}
- (void)initUI{
    [self.headerBgView addSubview:self.nameLable];
    [self.headerBgView addSubview:self.numberLabel];
    [self.headerBgView addSubview:self.tagView];
    [self.view addSubview:self.headerBgView];
    
    [self.textBgView addSubview:self.salaryTypeLabel];
    [self.textBgView addSubview:self.moneyLabel];
    [self.view addSubview:self.textBgView];
    
    [self.view addSubview:[self cycleView]];
    [self.view addSubview:self.tableView];
}
- (void)initData{
    [NetworkEntity postSalaryBarDataWithYear:_yearText success:^(id responseObject) {
        MMLog(@"SalaryBarData  =======responseObject=====%@",responseObject);
        if ([[responseObject objectForKey:@"errcode"] integerValue]== 0) {
            NSMutableArray *marginArray = [NSMutableArray array];
            NSDictionary *param = [responseObject objectForKey:@"dataMap"];
            NSArray *allKey = [param allKeys];
            for (NSString *key in allKey) {
                if ([[param objectForKey:key] count] == 0) {
                    [marginArray addObject:key];
                }
            }
            
         _monthArray = [self sortDataWithArray:marginArray].mutableCopy;
            MMLog(@"_monthArray = %@",_monthArray);
            [_tableView reloadData];
        }
    } failure:^(NSError *failure) {
        MMLog(@"SalaryBarData  =======failure=====%@",failure);
        [self showTotasViewWithMes:@"网络错误"];
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SalaryBarSectionView *sectionView = [[SalaryBarSectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    sectionView.monthStr = _monthArray[section];
    sectionView.moneyStr =  @"¥ 20000";
    sectionView.indexTag = section;
    sectionView.delegate = self;
    return sectionView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _monthArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    SalaryBarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[SalaryBarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalaryBarCell *cell = (SalaryBarCell *)[tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.5 animations:^{
        cell.flagButton.transform = CGAffineTransformRotate(cell.flagButton.transform, M_PI);
        
    } completion:^(BOOL finished) {
    }];
   }
// SalaryBarSectionViewDelegate
- (void)SalaryBarSectionViewDelegateWith:(UIButton *)sender{
    [UIView animateWithDuration:0.5 animations:^{
        sender.transform = CGAffineTransformRotate(sender.transform, M_PI);
        
    } completion:^(BOOL finished) {
    }];
}
// 选择年份回调
- (void)selectYearWithLaber:(UILabel *)label{
    MMLog(@"lable tag %lu",label.tag);
    NSString *year = [_yearsArray objectAtIndex:label.tag];
    _yearText = year;
    [self initData];
}
// 获得展示的年份
- (NSMutableArray *)yearsData{
    NSMutableArray *resultArray = [NSMutableArray array];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    for (NSInteger i = 4; i >= 0; i--) {
        NSInteger margin = [locationString integerValue] - i;
        
        [resultArray addObject:[NSString stringWithFormat:@"%lu",margin]];
    }
    return resultArray;
}
/* 数据进行排序(降序) */
- (NSArray *)sortDataWithArray:(NSArray *)data{
    
    NSComparator finderSort = ^(id string1,id string2){
        
        if ([string1 integerValue] < [string2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }else if ([string1 integerValue] > [string2 integerValue]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        else
            return (NSComparisonResult)NSOrderedSame;
    };
    NSArray *resultArray = [data sortedArrayUsingComparator:finderSort];
    return resultArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIView *)headerBgView{
    if (_headerBgView == nil) {
        _headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,85)];
        _headerBgView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _headerBgView.userInteractionEnabled = YES;
    }
    return _headerBgView;
}
- (UILabel *)nameLable{
    if (_nameLable == nil) {
        _nameLable =  [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 52, 13)];
        _nameLable.backgroundColor = [UIColor clearColor];
        _nameLable.font = [UIFont systemFontOfSize:12];
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.text = [UserInfoModel defaultUserInfo].empName;
        
    }
    return _nameLable;
}
- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel =  [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.nameLable.frame) + 10, 52, 13)];
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textColor = [UIColor whiteColor];
        _numberLabel.text = @"NO:007";
        
    }
    return _numberLabel;
}
- (UIView *)textBgView{
    if (_textBgView == nil) {
        _textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerBgView.frame), self.view.width,40)];
        _textBgView.backgroundColor =[UIColor colorWithHexString:@"1abddc"];
    }
    return _textBgView;
}
- (UILabel *)salaryTypeLabel{
    if (_salaryTypeLabel == nil) {
        _salaryTypeLabel =  [[UILabel alloc] initWithFrame:CGRectMake(self.view.width / 3, 10, 80, 13)];
        _salaryTypeLabel.backgroundColor = [UIColor clearColor];
        _salaryTypeLabel.font = [UIFont systemFontOfSize:12];
        _salaryTypeLabel.textColor = [UIColor whiteColor];
        _salaryTypeLabel.text = @"工资类型";
        
    }
    return _salaryTypeLabel;
}
- (UILabel *)moneyLabel{
    if (_moneyLabel == nil) {
        _moneyLabel =  [[UILabel alloc] initWithFrame:CGRectMake((self.view.width * 2) / 3, 10, 80, 13)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.font = [UIFont systemFontOfSize:12];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.text = @"实发金额";
        
    }
    return _moneyLabel;
}

- (SalaryBarHeaderView *)tagView
{
    if (_tagView == nil) {
        _tagView = [[SalaryBarHeaderView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameLable.frame), CGRectGetMidY(self.nameLable.frame), self.view.width - 52 - 10, 35)];
        _tagView.backgroundColor = [UIColor clearColor];
        _tagView.centerY = self.headerBgView.centerY;
        NSArray *array = _yearsArray;
        [_tagView initTag:array];
        [_tagView MMToolBarViewItemSelected:^(UILabel *label) {
            [self selectYearWithLaber:label];
        }];
    }
    return _tagView;
}
- (UIView *)cycleView{
    CGFloat bigW = 50;
    CGFloat mightW = 45;
    CGFloat smallW = 35;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMinY(self.textBgView.frame) - 10, bigW, bigW)];
    bgView.backgroundColor = [UIColor clearColor];
    // bigCycle
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bigW, bigW)];
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.8;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = bigW/2;
    [bgView addSubview:view];
    // minhtCycle
    UIView *mightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, mightW, mightW)];
    mightView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
    mightView.centerX = view.centerX;
    mightView.centerY = view.centerY;
    mightView.layer.masksToBounds = YES;
    mightView.layer.cornerRadius = mightW/2;
    [bgView addSubview:mightView];
    // smallCycle
    UIView *smallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, smallW, smallW)];
    smallView.backgroundColor = [UIColor whiteColor];
    smallView.center = view.center;
    smallView.layer.masksToBounds = YES;
    smallView.layer.cornerRadius = smallW/2;
    [bgView addSubview:smallView];
    // label
    UILabel *centerLabel =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, smallW, 13)];
    centerLabel.backgroundColor = [UIColor clearColor];
    centerLabel.font = [UIFont systemFontOfSize:12];
    centerLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    centerLabel.text = @"月份";
    centerLabel.center = view.center;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:centerLabel];
    
    return bgView;
}
- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.textBgView.frame), self.view.width, self.view.height - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
    }
    return _tableView;
}

@end
