//
//  ApprovalController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ApprovalController.h"
#import "JZPassRateToolBarView.h"
#import "OverTimeView.h"
#import "SignUpApprovalView.h"
#import "LeaveApprovalView.h"

@interface ApprovalController () <UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) OverTimeView *overTimeView;

@property (nonatomic, strong) SignUpApprovalView *signUpApprovalView;

@property (nonatomic, strong) LeaveApprovalView *leaveApprovalView;

@end

@implementation ApprovalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"审批";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.scrollView.delegate = self;
    [self initUI];
    
}
- (void)initUI{
    
    [self.view addSubview:self.toolBarView];
    [self.view addSubview:self.scrollView];
    
    [_scrollView addSubview:self.overTimeView];
    [_scrollView addSubview:self.signUpApprovalView];
    [_scrollView addSubview:self.leaveApprovalView];
    
    CGFloat contentOffsetX = 0 * self.view.width;
    _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    self.overTimeView.parementVC = self;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
//        self.checkRecordView.recodeType = RecodeTypeCheck;
//        self.checkRecordView.parementVC = self;
        
//        [self loadNetworkData];
        
        
        
    }else if (2 == index) {
        CGFloat contentOffsetX = 2 * self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        
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
}
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 40 - 64)];
        _scrollView.contentSize = CGSizeMake(3 * self.view.width, 0);
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
        _toolBarView.backgroundColor = [UIColor whiteColor];
        _toolBarView.selectButtonInteger = 0;
        _toolBarView.titleArray = @[ @"加班审批", @"签到审批", @"请假审批"];
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
// 加班审批
- (OverTimeView *)overTimeView{
    if (_overTimeView == nil) {
        _overTimeView = [[OverTimeView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _overTimeView.backgroundColor = [UIColor clearColor];
        //        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _overTimeView;
}
// 签到审批
- (SignUpApprovalView *)signUpApprovalView{
    if (_signUpApprovalView == nil) {
        _signUpApprovalView = [[SignUpApprovalView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        _signUpApprovalView.backgroundColor = [UIColor clearColor];
        //        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _signUpApprovalView;
}
// 请假审批
- (LeaveApprovalView *)leaveApprovalView{
    if (_leaveApprovalView == nil) {
        _leaveApprovalView = [[LeaveApprovalView alloc] initWithFrame:CGRectMake( 2 * self.view.width, 0, self.view.width, self.scrollView.height)];
        _leaveApprovalView.backgroundColor = [UIColor clearColor];
        //        _checkView.commentDateSearchType = kCommentDateSearchTypeLastMonth;
        
    }
    return _leaveApprovalView;
}


@end
