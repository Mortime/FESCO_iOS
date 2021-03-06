//
//  CheckWorkController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckWorkController.h"
#import "JZPassRateToolBarView.h"
#import "CheckView.h"
#import "CheckRecordView.h"
#import "FillApplyView.h"
#import "FillRecordView.h"

@interface CheckWorkController () <UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CheckView *checkView;

@property (nonatomic, strong)  CheckRecordView *checkRecordView;

@property (nonatomic, strong) FillApplyView *applyView;

@property (nonatomic, strong)  FillRecordView *fillRecordView;

@end

@implementation CheckWorkController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"考勤";
    [self initUI];
    [self initRefesh];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 判断签到次数是否清空
    // 当点击的不是本月的数据时, 进行数据刷新
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:kSignDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormat stringFromDate:date];
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr1 = [dateFormat1 stringFromDate: [NSDate date]];
    if (![dateStr isEqualToString:dateStr1]) {
        NSString *number = [[NSUserDefaults standardUserDefaults] objectForKey:kSingNumber];
        number = @"0";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:number forKey:kSingNumber];
    }

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.checkView.locService stopUserLocationService];
    [self.checkView.mapView viewWillDisappear];
    self.checkView.mapView.delegate = nil;
    

}
- (void)initUI{
    
    [self.view addSubview:self.toolBarView];
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.checkView];
    [_scrollView addSubview:self.checkRecordView];
    [_scrollView addSubview:self.applyView];
    [_scrollView addSubview:self.fillRecordView];
    
    CGFloat contentOffsetX = 0 * self.view.width;
    _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);

    
    
}
- (void)initRefesh{

    __weak typeof (self) ws = self;
    
    self.checkRecordView.refreshFooter.beginRefreshingBlock = ^(){
        [ws moreLoadData];
    };
    
}


- (void)loadNetworkData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    
     if (offSetX >= width && offSetX < width * 2) {
         
         // 考勤记录
        [self.checkRecordView networkRequest];
    }
    if (offSetX >= width * 3 && offSetX < width * 4) {
        
        // 补签申请
        [self.fillRecordView networkRequest];
    }
}

- (void)moreLoadData {
    
    CGFloat offSetX = self.scrollView.contentOffset.x;
    CGFloat width = self.scrollView.width;
    if (offSetX >= width && offSetX < width * 2) {
        // 考勤记录
        [self.checkRecordView moreData];
        
    }if (offSetX >= width * 3 && offSetX < width * 4) {
        
        // 补签申请
        
        [self.fillRecordView moreData];
    }

}

#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    
        
    }else if (1 == index) {
        // 考勤记录
        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.checkRecordView.recodeType = RecodeTypeCheck;
        self.checkRecordView.parementVC = self;
        
        [self loadNetworkData];
        
    
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        
    }
    else if (3 == index) {
        // 补签记录
        CGFloat contentOffsetX = 3 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.fillRecordView.recodeType = RecodeTypeFill;
        self.fillRecordView.parementVC = self;
        
        [self loadNetworkData];
    }
    
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 考勤
        [_toolBarView selectItem:0];
        //         self.allListView.frame = CGRectMake(0, -64, self.view.width, self.scrollView.height);
    }
    if (width == scrollView.contentOffset.x) {
        // 考勤记录
        [_toolBarView selectItem:1];
        //self.noExameListView.frame = CGRectMake(self.view.width, -64, self.view.width, self.scrollView.height);
        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 补签申请
        [_toolBarView selectItem:2];
        //        self.appointListView.frame = CGRectMake(self.view.width * 2, -64, self.view.width, self.scrollView.height);
        
    }
    if (3 * width == scrollView.contentOffset.x) {
        // 补签记录
        [_toolBarView selectItem:3];
        //        self.retestListView.frame = CGRectMake(self.view.width * 3, -64, self.view.width, self.scrollView.height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 40 - 64)];
        _scrollView.contentSize = CGSizeMake(4 * self.view.width, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _scrollView;
}
- (JZPassRateToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [JZPassRateToolBarView new];
        _toolBarView.frame = CGRectMake(0, 0, self.view.width, 40);
        _toolBarView.titleNormalColor = [UIColor whiteColor];
        _toolBarView.titleSelectColor = [UIColor whiteColor];
        _toolBarView.followBarColor = [UIColor whiteColor];
        _toolBarView.followBarHeight = 3;
        _toolBarView.backgroundColor = MM_MAIN_FONTCOLOR_BLUE;
        _toolBarView.selectButtonInteger = 0;
        _toolBarView.titleArray = @[ @"考勤", @"考勤记录", @"补签申请" , @"补签记录"];
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (MMIphone6Plus) {
            _toolBarView.titleFont = [UIFont systemFontOfSize:14*1.15];
        }
    }
    return _toolBarView;
}

// 考勤
- (CheckView *)checkView{
    if (_checkView == nil) {
        _checkView = [[CheckView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _checkView.backgroundColor = [UIColor clearColor];
//        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        _checkView.parentVC = self;
        
    }
    return _checkView;
}
// 考勤记录
- ( CheckRecordView *)checkRecordView{
    if (_checkRecordView == nil) {
        _checkRecordView = [[CheckRecordView alloc] initWithFrame:CGRectMake(kMMWidth, 0, self.view.width, self.scrollView.height)];
        _checkRecordView.backgroundColor = [UIColor clearColor];
        //        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _checkRecordView;
}
// 补签申请
- (FillApplyView *)applyView{
    if (_applyView == nil) {
        _applyView = [[FillApplyView alloc] initWithFrame:CGRectMake( 2 * kMMWidth, 0, self.view.width, self.scrollView.height)];
        _applyView.backgroundColor = [UIColor clearColor];
        //        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _applyView;
}

// 补签记录
- (FillRecordView *)fillRecordView{
    if (_fillRecordView == nil) {
        _fillRecordView = [[FillRecordView alloc] initWithFrame:CGRectMake(3 * kMMWidth, 0, self.view.width, self.scrollView.height)];
        _fillRecordView.backgroundColor = [UIColor clearColor];
        //        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _fillRecordView;
}


@end
