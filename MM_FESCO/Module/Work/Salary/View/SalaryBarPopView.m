//
//  SalaryBarPopView.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/14.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SalaryBarPopView.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"

@interface SalaryBarPopView ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIButton *popButton;

@end
@implementation SalaryBarPopView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)layoutSubviews{
    [self initUI];
}
- (void)initUI{
    
    self.backgroundColor = RGB_Color(218, 244, 249);
    for (int index = 0; index < [_dataDic allKeys].count; index++) {
        UIView *image = [[UIView alloc] init];
        image.backgroundColor = [UIColor cyanColor];
        [self.imageArray addObject:image];
    }
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 100, kMMWidth, (kMMHeight - 100 - 50 - 64))];
    pageFlowView.backgroundColor = [UIColor clearColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.isCarousel = NO;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    
    //提前告诉有多少页
    //    pageFlowView.orginPageCount = self.imageArray.count;
    
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(pageFlowView.frame)+20, kMMWidth, 8)];
    pageFlowView.pageControl = pageControl;
    pageControl.currentPageIndicatorTintColor = MM_MAIN_FONTCOLOR_BLUE;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:pageControl];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [bottomScrollView addSubview:pageFlowView];
    
    [pageFlowView reloadData];
    
    [self addSubview:bottomScrollView];
 [self addSubview:self.popButton];
}
#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kMMWidth - 84, (kMMHeight - 100 - 50 - 64));
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    NSString *key = [_dataDic allKeys][index];
    
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, kMMWidth - 84, (kMMHeight - 100 - 50 - 64))];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
        bannerView.dic = [_dataDic objectForKey:key];
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
//    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}
// 移除弹出视图
- (void)didClickDis:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(SalaryBarPopViewDelegateWithSender:)]) {
        [_delegate SalaryBarPopViewDelegateWithSender:sender];
    }
}
#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
- (UIButton *)popButton{
    if (_popButton == nil) {
        _popButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _popButton.frame = CGRectMake(kMMWidth - 40, 0, 40, 40);
        _popButton.backgroundColor = [UIColor cyanColor];
        [_popButton addTarget:self action:@selector(didClickDis:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popButton;
}
- (void)refreshUI{
    [self initUI];
}
@end
