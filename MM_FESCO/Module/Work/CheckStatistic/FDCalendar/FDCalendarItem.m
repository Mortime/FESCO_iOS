//
//  FDCalendarItem.m
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDCalendarItem.h"

@interface FDCalendarCell : UICollectionViewCell

- (UILabel *)dayLabel;
- (UILabel *)chineseDayLabel;
- (UIView *)flagView;

@end

@implementation FDCalendarCell {
    UILabel *_dayLabel;
    UILabel *_chineseDayLabel;
    UIView *_flagView; // 当签到状态有两种时,这时显示
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.font = [UIFont systemFontOfSize:15];
        _dayLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 );
        [self addSubview:_dayLabel];
    }
    return _dayLabel;
}

- (UILabel *)chineseDayLabel {
    if (!_chineseDayLabel) {
        _chineseDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        _chineseDayLabel.textAlignment = NSTextAlignmentCenter;
        _chineseDayLabel.font = [UIFont boldSystemFontOfSize:9];
        
        CGPoint point = _dayLabel.center;
        point.y += 15;
        _chineseDayLabel.center = point;
//        [self addSubview:_chineseDayLabel];
    }
    return _chineseDayLabel;
}

- (UIView *)flagView {
    if (!_flagView) {
        _flagView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 15, self.bounds.size.height - 15)];
        _flagView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _flagView.backgroundColor = [UIColor redColor];
        _flagView.hidden = YES;
        [self addSubview:_flagView];
    }
    return _flagView;
}


@end

#define CollectionViewHorizonMargin 0
#define CollectionViewVerticalMargin 5

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]

typedef NS_ENUM(NSUInteger, FDCalendarMonth) {
    FDCalendarMonthPrevious = 0,
    FDCalendarMonthCurrent = 1,
    FDCalendarMonthNext = 2,
};

@interface FDCalendarItem () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation FDCalendarItem

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupCollectionView];
        [self setFrame:CGRectMake(0, 0, DeviceWidth, self.collectionView.frame.size.height + CollectionViewVerticalMargin * 2)];
    }
    return self;
}
#pragma mark --- 刷新UI
- (void) initRefreshUI{
    [self.collectionView reloadData];
}

#pragma mark - Custom Accessors

- (void)setDate:(NSDate *)date {
    _date = date;
    [self.collectionView reloadData];
}

#pragma mark - Public 

// 获取date的下个月日期
- (NSDate *)nextMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = 1;
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return nextMonthDate;
}

// 获取date的上个月日期
- (NSDate *)previousMonthDate {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = -1;
    NSDate *previousMonthDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:self.date options:NSCalendarMatchStrictly];
    return previousMonthDate;
}

#pragma mark - Private

// collectionView显示日期单元，设置其属性
- (void)setupCollectionView {
    CGFloat itemWidth = (DeviceWidth - CollectionViewHorizonMargin * 2 - 6) / 7;
    CGFloat itemHeight = itemWidth;
    
    UICollectionViewFlowLayout *flowLayot = [[UICollectionViewFlowLayout alloc] init];
    flowLayot.sectionInset = UIEdgeInsetsZero;
    flowLayot.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayot.minimumLineSpacing = 1;
    flowLayot.minimumInteritemSpacing = 1;
    
    CGRect collectionViewFrame = CGRectMake(CollectionViewHorizonMargin, CollectionViewVerticalMargin, DeviceWidth - CollectionViewHorizonMargin * 2, itemHeight * 6 + 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayot];
    [self addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[FDCalendarCell class] forCellWithReuseIdentifier:@"CalendarCell"];
}

// 获取date当前月的第一天是星期几
- (NSInteger)weekdayOfFirstDayInDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    [components setDay:1];
    NSDate *firstDate = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday fromDate:firstDate];
    return firstComponents.weekday - 1;
}

// 获取date当前月的总天数
- (NSInteger)totalDaysInMonthOfDate:(NSDate *)date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

// 获取某月day的日期
- (NSDate *)dateOfMonth:(FDCalendarMonth)calendarMonth WithDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date;
    
    switch (calendarMonth) {
        case FDCalendarMonthPrevious:
            date = [self previousMonthDate];
            break;
            
        case FDCalendarMonthCurrent:
            date = self.date;
            break;
            
        case FDCalendarMonthNext:
            date = [self nextMonthDate];
            break;
        default:
            break;
    }
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:day];
    NSDate *dateOfDay = [calendar dateFromComponents:components];
    return dateOfDay;
}

// 获取date当天的农历
- (NSString *)chineseCalendarOfDate:(NSDate *)date {
    NSString *day;
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    if (components.day == 1) {
        day = ChineseMonths[components.month - 1];
    } else {
        day = ChineseDays[components.day - 1];
    }

    return day;
}

#pragma mark - UICollectionDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CalendarCell";
    FDCalendarCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.flagView.backgroundColor = [UIColor colorWithHexString:@"ededed"];

    cell.dayLabel.textColor = [UIColor blackColor];
    cell.chineseDayLabel.textColor = [UIColor grayColor];
    
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    NSInteger totalDaysOfMonth = [self totalDaysInMonthOfDate:self.date];
    NSInteger totalDaysOfLastMonth = [self totalDaysInMonthOfDate:[self previousMonthDate]];
    
    if (indexPath.row < firstWeekday) {    // 小于这个月的第一天
        NSInteger day = totalDaysOfLastMonth - firstWeekday + indexPath.row + 1;
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
        cell.dayLabel.textColor = [UIColor grayColor];
        cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthPrevious WithDay:day]];
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];

    } else if (indexPath.row >= totalDaysOfMonth + firstWeekday) {    // 大于这个月的最后一天
        NSInteger day = indexPath.row - totalDaysOfMonth - firstWeekday + 1;
        cell.dayLabel.text = [NSString stringWithFormat:@"%ld", day];
        cell.dayLabel.textColor = [UIColor grayColor];
        cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthNext WithDay:day]];
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    } else {    // 属于这个月
        NSInteger day = indexPath.row - firstWeekday + 1;
        cell.dayLabel.text= [NSString stringWithFormat:@"%ld", day];
        
        
        // 显示签到类型的背景色值  (_dataArray.count + firstWeekday 本月数据数据越界问题 )
        if (indexPath.row < _dataArray.count + firstWeekday) {
            if (_dataArray.count) {
                NSArray *array = _dataArray[day - 1];
                cell.flagView.hidden = YES;
                if (array.count) {
                    if ([array[0] isEqualToString:@"normal"]) {
                        cell.backgroundColor =  [UIColor colorWithHexString:@"edf963"];
                    }
                    if ([array[0] isEqualToString:@"lateArrive"]) {
                        cell.backgroundColor =  [UIColor colorWithHexString:@"e963f9"];
                        cell.dayLabel.textColor = [UIColor whiteColor];
                    }
                    if ([array[0] isEqualToString:@"earlyLeave"]) {
                        cell.backgroundColor =  [UIColor colorWithHexString:@"636df9"];
                        cell.dayLabel.textColor = [UIColor whiteColor];
                    }
                    if ([array[0] isEqualToString:@"offWork"]) {
                        cell.backgroundColor =  [UIColor colorWithHexString:@"f96363"];
                        cell.dayLabel.textColor = [UIColor whiteColor];
                    }
                    if ([array[0] isEqualToString:@"holiday"]) {
                        cell.backgroundColor =  [UIColor colorWithHexString:@"63f971"];
                        cell.dayLabel.textColor = [UIColor whiteColor];
                    }
                    if ([array[0] isEqualToString:@"extraWork"]) {
                        cell.backgroundColor =  [UIColor colorWithHexString:@"f99b63"];
                        cell.dayLabel.textColor = [UIColor whiteColor];
                    }
                }
                // 当有两张状态时 色块重叠
                if (array.count == 2) {
                    cell.flagView.hidden = NO;
                    cell.dayLabel.textColor = [UIColor whiteColor];
                    
                    if ([array[1] isEqualToString:@"normal"]) {
                        cell.flagView.backgroundColor =  [UIColor colorWithHexString:@"edf963"];
                    }
                    if ([array[1] isEqualToString:@"lateArrive"]) {
                        cell.flagView.backgroundColor =  [UIColor colorWithHexString:@"e963f9"];
                        
                    }
                    if ([array[1] isEqualToString:@"earlyLeave"]) {
                        cell.flagView.backgroundColor =  [UIColor colorWithHexString:@"636df9"];
                    }
                    if ([array[1] isEqualToString:@"offWork"]) {
                        cell.flagView.backgroundColor =  [UIColor colorWithHexString:@"f96363"];
                    }
                    if ([array[1] isEqualToString:@"holiday"]) {
                        cell.flagView.backgroundColor =  [UIColor colorWithHexString:@"63f971"];
                    }
                    if ([array[1] isEqualToString:@"extraWork"]) {
                        cell.flagView.backgroundColor =  [UIColor colorWithHexString:@"f99b63"];
                    }
                    
                }
            }

        }
        
        
        if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.date]) {
            cell.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
//            cell.layer.cornerRadius = cell.frame.size.height / 2;
            cell.dayLabel.textColor = [UIColor whiteColor];
            cell.chineseDayLabel.textColor = [UIColor whiteColor];
        }
        
        // 如果日期和当期日期同年同月不同天, 注：第一个判断中的方法是iOS8的新API, 会比较传入单元以及比传入单元大得单元上数据是否相等，亲测同时传入Year和Month结果错误
        if ([[NSCalendar currentCalendar] isDate:[NSDate date] equalToDate:self.date toUnitGranularity:NSCalendarUnitMonth] && ![[NSCalendar currentCalendar] isDateInToday:self.date]) {
            
            // 将当前日期的那天高亮显示
            if (day == [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:[NSDate date]]) {
                cell.dayLabel.textColor = [UIColor redColor];
            }
        }
        
        cell.chineseDayLabel.text = [self chineseCalendarOfDate:[self dateOfMonth:FDCalendarMonthCurrent WithDay:day]];
    }
    
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self.date];
    NSInteger firstWeekday = [self weekdayOfFirstDayInDate];
    [components setDay:indexPath.row - firstWeekday + 1];
    NSDate *selectedDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    // 把选中的日期转化为字符串
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [dateFormat stringFromDate:selectedDate];


    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dateStr forKey:@"kDate"];
    [[NSNotificationCenter defaultCenter] postNotificationName:kDateChangeNotifition object:self];
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(calendarItem:didSelectedDate:)]) {
        [self.delegate calendarItem:self didSelectedDate:selectedDate];
    }
}

@end
