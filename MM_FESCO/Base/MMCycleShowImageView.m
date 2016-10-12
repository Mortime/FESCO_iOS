//
//  MMCycleShowImageView.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/11.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMCycleShowImageView.h"
//#import "UIImageView+WebCache.h"
#define VIEW_WIDTH self.frame.size.width
#define VIEW_HEIGHT self.frame.size.height

@interface MMCycleShowImageView()<UIScrollViewDelegate>

//用于回调用的Block
@property (nonatomic, copy) ImagesTouchUpInsideBlock imgTUIBlock;

//用于滚动展示图片
@property (nonatomic, strong) UIScrollView * scrollView;

//UIPageControl的位置（左侧、中间、右侧）
@property (nonatomic, assign) NSUInteger pageControlLocation;

//显示现在是第几张图片
@property (nonatomic, strong) UIPageControl * pageControl;

//循环复用的 3 个UIImageView
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * centerImageView;
@property (nonatomic, strong) UIImageView * rightImageView;

//自动循环播放的计时器
@property (nonatomic, strong) NSTimer * cycleTimer;

//是否循环播放
@property (nonatomic, assign) BOOL isCycle;

@end

@implementation MMCycleShowImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initAttribute];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//初始化属性
- (void)initAttribute {
    
    _placeImage = nil;
    _pageControlLocation = 1;
}

//设置数据
- (void)setPageControlLocation:(NSUInteger)location
                       isCycle:(BOOL)cycle {
    
    _pageControlLocation = location;
    _isCycle = cycle;
}

//刷新数据
- (void)reloadDataWithArray:(NSArray *)array {
    
    self.imagesUrlArray = array;
    self.pageControl.numberOfPages = self.imagesUrlArray.count;
    self.pageControl.currentPage = 0;
    [self setPageControlFrame];
    [self loadImages];
}

- (void)drawRect:(CGRect)rect {
    
    [self addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
    
    [self addSubview:self.pageControl];
    _pageControl.numberOfPages = _imagesUrlArray.count;
    [self setPageControlFrame];
    
    //加载图片
    [self loadImages];
    
    if (self.isCycle) {
        [self beginCycle];
    }
    
}

#pragma mark - 设置点击图片的回调方法 method

- (void)dvCycleShowImagesViewTouchUpInside:(ImagesTouchUpInsideBlock)handle {
    
    self.imgTUIBlock = handle;
}

- (void)imageClickAction {
    
    if (self.imgTUIBlock && self.imagesUrlArray.count) {
        
        self.imgTUIBlock(self.pageControl.currentPage);
    }
}

#pragma mark - 计时器 method

- (void)beginCycle {
    
    self.cycleTimer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(cycleTimerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.cycleTimer forMode:NSDefaultRunLoopMode];
}

- (void)cycleTimerAction {
    
    if (self.imagesUrlArray.count) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH * 2, 0);
        }];
        [self scrollViewDidEndDecelerating:[UIScrollView new]];
    }
}

- (void)endCycle {
    
    [self.cycleTimer invalidate];
}

#pragma mark - UIScrollViewDelegate method

//完成减速时执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self setCurrentPage];
    [self loadImages];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self endCycle];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self beginCycle];
//}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self beginCycle];
}

#pragma mark - 设置当前显示的图片 method

- (void)setCurrentPage {
    
    if (!_imagesUrlArray.count) {
        return;
    }
    NSInteger currentPage;
    //判断滑动的方向
    //向右
    if (_scrollView.contentOffset.x < VIEW_WIDTH) {
        
        currentPage = _pageControl.currentPage - 1;
        if (currentPage < 0) {
            currentPage = _imagesUrlArray.count - 1;
        }
        _pageControl.currentPage = currentPage;
        
    }else { //向左
        
        currentPage = _pageControl.currentPage + 1;
        if (currentPage > _imagesUrlArray.count - 1) {
            currentPage = 0;
        }
        _pageControl.currentPage = currentPage;
    }
}

#pragma mark - 更新图片 method

//滑动过后重置位置、刷新图片
- (void)loadImages {
    
    if (!_imagesUrlArray.count) {
        self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
        return;
    }
    NSUInteger maxIdx = _imagesUrlArray.count - 1;
    NSUInteger currentIdx = _pageControl.currentPage;
    NSInteger left;
    NSUInteger center;
    NSUInteger right;
    
    left = currentIdx - 1;
    if (left < 0) {
        left = maxIdx;
    }
    
    center = currentIdx;
    
    right = currentIdx + 1;
    if (right > maxIdx) {
        right = 0;
    }
    //下载并缓存图片
//    NSLog(@"________________imagesUrlArray[center]]%@",_imagesUrlArray[center]);
    
    self.centerImageView.image = [UIImage imageNamed:_imagesUrlArray[center]];
    self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
    self.leftImageView.image = [UIImage imageNamed:_imagesUrlArray[left]];
    self.rightImageView.image = [UIImage imageNamed:_imagesUrlArray[right]];
    
    
//    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[center]] placeholderImage:self.placeImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
//    self.scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
//    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[left]] placeholderImage:self.placeImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
//    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:_imagesUrlArray[right]] placeholderImage:self.placeImage options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

#pragma mark - 设置pageControl的坐标和大小 method

- (void)setPageControlFrame {
    
    if (_imagesUrlArray.count) {
        
        CGRect rect = self.frame;
        rect.origin.y = rect.size.height - 15;
        rect.size.height = 10;
        rect.size.width = _imagesUrlArray.count * 20.f;
        switch (_pageControlLocation) {
            case 0:
                rect.origin.x = (VIEW_WIDTH - rect.size.width) / 2.f;
                break;
            case 1:
            {
                rect.origin.x = VIEW_WIDTH / 2.f - rect.size.width / 2.f;
            }
                break;
            case 2:
                rect.origin.x = VIEW_WIDTH - rect.size.width;
                break;
            default:
                break;
        }
        _pageControl.frame = rect;
    }
}

#pragma mark - lazyLoad method

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
        _scrollView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        self.scrollView.contentSize = CGSizeMake(VIEW_WIDTH * 3, VIEW_HEIGHT);
        _scrollView.contentOffset = CGPointMake(VIEW_WIDTH, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        
        _pageControl = [UIPageControl new];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"323a45"];
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"00b6d8"];
    }
    return _pageControl;
}

- (UIImageView *)leftImageView {
    if (!_leftImageView){
        
        _leftImageView = [UIImageView new];
        _leftImageView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        if (_placeImage) {
            _leftImageView.image = _placeImage;
        }
    }
    return _leftImageView;
}
- (UIImageView *)centerImageView {
    if (!_centerImageView){
        
        _centerImageView = [UIImageView new];
        _centerImageView.backgroundColor = [UIColor whiteColor];
        _centerImageView.frame = CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT);
        [self addTouchForImageView:_centerImageView];
        if (_placeImage) {
            _centerImageView.image = _placeImage;
        }
        
    }
    return _centerImageView;
}

- (void)addTouchForImageView:(UIImageView *)imageView {
    
    UITapGestureRecognizer *touch = [UITapGestureRecognizer new];
    touch.numberOfTouchesRequired = 1;
    [touch addTarget:self action:@selector(imageClickAction)];
    [imageView addGestureRecognizer:touch];
    imageView.userInteractionEnabled = YES;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView){
        
        _rightImageView = [UIImageView new];
        _rightImageView.frame = CGRectMake(VIEW_WIDTH * 2, 0, VIEW_WIDTH, VIEW_HEIGHT);
        if (_placeImage) {
            _rightImageView.image = _placeImage;
        }
    }
    return _rightImageView;
}

- (NSTimer *)cycleTimer {
    if (!_cycleTimer) {
        _cycleTimer = [NSTimer new];
    }
    return _cycleTimer;
}



@end
