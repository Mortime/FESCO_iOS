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


#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
//                self.lastMonthView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
//        self.lastMonthView.commnetLevel = self.commentLevel;
//        self.lastMonthView.parementVC = self;
        
    
        
    }else if (1 == index) {
        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
//        self.lastWeekView.commentDateSearchType = kCommentDateSearchTypeLastWeek;
//        self.lastWeekView.commnetLevel = self.commentLevel;
//        self.lastWeekView.parementVC = self;
        
    
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
//
//        self.todayView.commentDateSearchType = kCommentDateSearchTypeToday;
//        self.todayView.commnetLevel = self.commentLevel;
//        self.todayView.parementVC = self;
        
        
       
        
    }
    else if (3 == index) {
        CGFloat contentOffsetX = 3 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
//        self.thisWeekView.commentDateSearchType = kCommentDateSearchTypeThisWeek;
//        self.thisWeekView.commnetLevel = self.commentLevel;
//        self.thisWeekView.parementVC = self;
        
        
        
        
    }
    
        
        
    
    
//    NSLog(@"+++++++_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    
//    [self loadNetworkData];
    
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
        _scrollView.contentSize = CGSizeMake(5 * self.view.width, 0);
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
        _toolBarView.titleNormalColor = [UIColor grayColor];
        _toolBarView.titleSelectColor = MM_MAIN_FONTCOLOR_BLUE;
        _toolBarView.followBarColor = MM_MAIN_FONTCOLOR_BLUE;
        _toolBarView.followBarHeight = 3;
        _toolBarView.backgroundColor = [UIColor clearColor];
        _toolBarView.selectButtonInteger = 0;
        _toolBarView.titleArray = @[ @"考勤", @"考勤记录", @"补签申请" , @"补签记录"];
        __weak typeof(self) ws = self;
        [_toolBarView dvvToolBarViewItemSelected:^(UIButton *button) {
            [ws dvvToolBarViewItemSelectedAction:button.tag];
        }];
        
        if (YBIphone6Plus) {
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
