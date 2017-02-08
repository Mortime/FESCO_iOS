//
//  OverTimeApplyController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "OverTimeApplyController.h"
#import "JZPassRateToolBarView.h"
#import "OverTimeApplyView.h"
#import "OverTimeRecordView.h"

@interface OverTimeApplyController ()<UIScrollViewDelegate>

@property (nonatomic, strong) JZPassRateToolBarView *toolBarView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) OverTimeApplyView *overTimeApplyView;

@property (nonatomic, strong) OverTimeRecordView *overTimeRecordView;

@end

@implementation OverTimeApplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"加班申请";
    self.view.backgroundColor = MM_GRAYWHITE_BACKGROUND_COLOR;
    self.scrollView.delegate = self;
    [self initUI];
    
}
- (void)initUI{
    
    [self.view addSubview:self.toolBarView];
    [self.view addSubview:self.scrollView];
    [_scrollView addSubview:self.overTimeApplyView];
    [_scrollView addSubview:self.overTimeRecordView];
    
    
    CGFloat contentOffsetX = 0 * self.view.width;
    _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
    self.overTimeApplyView.parementVC = self;
    //    self.overTimeView.approvalType = overTimeApprovalType;
    [_overTimeApplyView networkRequest];
    
    
    
}
#pragma mark 筛选条件
- (void)dvvToolBarViewItemSelectedAction:(NSInteger)index {
    
    NSLog(@"11_scrollView.contentOffset.y:%f",_scrollView.contentOffset.y);
    if (index == 0) {
        self.title = @"加班申请";
    }else{
        self.title = @"加班记录";
    }
    
    if (0 == index) {
        
        CGFloat contentOffsetX = 0;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.overTimeApplyView.parementVC = self;
        [_overTimeApplyView networkRequest];
        
        
        
    }else if (1 == index) {
        
        CGFloat contentOffsetX = self.view.width;
        _scrollView.contentOffset = CGPointMake(contentOffsetX, 0);
        self.overTimeRecordView.parementVC = self;
        [_overTimeRecordView networkRequest];
        
        
        
    }
    
}
#pragma mark --- UIScroller delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.view.width;
    
    if (0 == scrollView.contentOffset.x) {
        // 加班申请
        [_toolBarView selectItem:0];
        
    }
    if (width == scrollView.contentOffset.x) {
        // 加班记录
        [_toolBarView selectItem:1];
        
        
    }
    
}
- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, self.view.height - 40 - 64)];
        _scrollView.contentSize = CGSizeMake(2 * self.view.width, 0);
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
        _toolBarView.titleArray = @[ @"加班申请", @"加班记录"];
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
// 加班申请
- (OverTimeApplyView *)overTimeApplyView{
    if (_overTimeApplyView == nil) {
        _overTimeApplyView = [[OverTimeApplyView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.scrollView.height)];
        _overTimeApplyView.backgroundColor = [UIColor clearColor];
        
    }
    return _overTimeApplyView;
}
// 加班记录
- (OverTimeRecordView *)overTimeRecordView{
    if (_overTimeRecordView == nil) {
        _overTimeRecordView = [[OverTimeRecordView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.scrollView.height)];
        _overTimeRecordView.backgroundColor = [UIColor clearColor];
        
    }
    return _overTimeRecordView;
}


@end
