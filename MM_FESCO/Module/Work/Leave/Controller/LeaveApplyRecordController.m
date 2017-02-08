//
//  LeaveApplyRecordController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "LeaveApplyRecordController.h"
#import "JZPassRateToolBarView.h"
#import "LeaveApplyView.h"
#import "LeaveRecordView.h"
#import "MMScrollView.h"

@interface LeaveApplyRecordController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) MMScrollView *scrollView;

@property (nonatomic, strong) LeaveApplyView *leaveApplyView;

@property (nonatomic, strong) LeaveRecordView *recordApplyView;

@end

@implementation LeaveApplyRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"休假申请";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.scrollView.delegate = self;
    [self initUI];
    
}
- (void)initUI{
    
    [self.view addSubview:self.toolBarView];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.leaveApplyView];
    [_scrollView addSubview:self.recordApplyView];

    
    CGFloat contentOffsetX = 0 * self.view.width;
    _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    self.leaveApplyView.parementVC = self;
//    self.overTimeView.approvalType = overTimeApprovalType;
    [_leaveApplyView networkRequest];
    
    
    
}
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    if (index == 0) {
        self.title = @"休假申请";
    }else{
        self.title = @"休假记录";
    }
    
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.leaveApplyView.parementVC = self;
        [_leaveApplyView networkRequest];
        
        
        
    }else if (1 == index) {

        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.recordApplyView.parementVC = self;
        [_recordApplyView networkRequest];
        
        
        
    }
    
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 考勤
        [_toolBarView selectItem:0];
       
    }
    if (width == scrollView.contentOffset.x) {
        // 考勤记录
        [_toolBarView selectItem:1];
        
        
    }
    if (2 * width== scrollView.contentOffset.x) {
        // 补签申请
        [_toolBarView selectItem:2];
        
    }
}
- (MMScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[MMScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 40 - 64)];
        _scrollView.contentSize = CGSizeMake(2 * self.view.width, 0);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
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
        _toolBarView.backgroundColor = [UIColor whiteColor];
        _toolBarView.selectButtonInteger = 0;
        _toolBarView.titleArray = @[ @"休假申请", @"休假记录"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
// 休假申请
- (LeaveApplyView *)leaveApplyView{
    if (_leaveApplyView == nil) {
        _leaveApplyView = [[LeaveApplyView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _leaveApplyView.backgroundColor = [UIColor clearColor];
        
    }
    return _leaveApplyView;
}
// 休假记录
- (LeaveRecordView *)recordApplyView{
    if (_recordApplyView == nil) {
        _recordApplyView = [[LeaveRecordView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        _recordApplyView.backgroundColor = [UIColor clearColor];
        
    }
    return _recordApplyView;
}


@end
