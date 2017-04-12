//
//  SalaryBarHeaderView.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "SalaryBarHeaderView.h"

#import "DDChannelLabel.h"

@interface SalaryBarHeaderView ()<UIScrollViewDelegate>

// 可以滑动的视图
@property (nonatomic, strong) UIScrollView *smallScrollView;

// 给随的线
@property (nonatomic, strong) UIView *underline;

//执行点击事件的Block
@property (nonatomic, copy) MMToolBarViewBlock itemBlock;



@end

@implementation SalaryBarHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //调用初始化属性
        [self chuShiHuaShuXing];
    }
    return self;
}
#pragma mark - 初始化属性
- (void)chuShiHuaShuXing {
    
    [self addSubview:self.smallScrollView];
    
}


- (void)initTag:(NSArray *)tagArray{
    
    
    CGFloat x = 0;
    CGFloat h = _smallScrollView.bounds.size.height;
    CGFloat w = _smallScrollView.bounds.size.width;
    
    CGFloat margin =( w - (h * tagArray.count)) / (tagArray.count + 1);
    int i = 0;
    for (NSString *channel in tagArray) {
        DDChannelLabel *label = [DDChannelLabel channelLabelWithTitle:channel];
        label.frame = CGRectMake(((i * h) +  (i + 1) * margin), 0, h, h);
        label.textColor = MM_MAIN_FONTCOLOR_BLUE;
        label.text = tagArray[i];
        label.backgroundColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 7;
        // 默认选择最后一个
        if (i == (tagArray.count - 1)) {
            label.alpha = 1;
        }else{
          label.alpha = 0.4;
        }
        
        [_smallScrollView addSubview:label];
        
        x += label.bounds.size.width;
        label.tag = i++;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
    }
    _smallScrollView.contentSize = CGSizeMake(x + margin, 0);
    
    // 设置下滑线
    [self setLine];
    
}

#pragma mark - UICollectionViewDelegate
/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value < 0) {return;} // 防止在最左侧的时候，再滑，下划线位置会偏移，颜色渐变会混乱。
    
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    if (rightIndex >= [self getLabelArrayFromSubviews].count) {  // 防止滑到最右，再滑，数组越界，从而崩溃
        rightIndex = [self getLabelArrayFromSubviews].count - 1;
    }
    
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft  = 1 - scaleRight;
    
    DDChannelLabel *labelLeft  = [self getLabelArrayFromSubviews][leftIndex];
    DDChannelLabel *labelRight = [self getLabelArrayFromSubviews][rightIndex];
    
    labelLeft.scale  = scaleLeft;
    labelRight.scale = scaleRight;
    
    // 点击label会调用此方法1次，会导致【scrollViewDidEndScrollingAnimation】方法中的动画失效，这时直接return。
    if (scaleLeft == 1 && scaleRight == 0) {
        return;
    }
    
}
/** 获取smallScrollView中所有的DDChannelLabel，合成一个数组，因为smallScrollView.subViews中有其他非Label元素 */
- (NSArray *)getLabelArrayFromSubviews
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    //    NSLog(@"%@",self.smallScrollView.subviews);
    for (DDChannelLabel *label in self.smallScrollView.subviews) {
        if ([label isKindOfClass:[DDChannelLabel class]]) {
            [arrayM addObject:label];
        }
    }
    return arrayM.copy;
}

/** Label点击事件 */

- (void)labelClick:(UITapGestureRecognizer *)recognizer
{
    DDChannelLabel *relultlabel = (DDChannelLabel *)recognizer.view;
    
    for (DDChannelLabel *label in [self getLabelArrayFromSubviews]) {
        if (label.tag == relultlabel.tag) {
             label.alpha = 1;
        }else{
             label.alpha = 0.4;
        }
    }
    
    // 点击label后，让bigCollectionView滚到对应位置。
    //如果Block不为空时才调用，执行在其他类中的实现的内容
    if (_itemBlock) {
        _itemBlock(relultlabel);
    }
}
// 设置下滑线
- (void)setLine{
    DDChannelLabel *firstLabel = [self getLabelArrayFromSubviews][0];
    firstLabel.textColor = MM_MAIN_FONTCOLOR_BLUE;
    [_smallScrollView addSubview:firstLabel];
}
#pragma mark - 实现在 .h中声明的，模拟点击一项的方法（参数为一个Block）
/**
 param handle 用户实现的Block
 */
- (void)MMToolBarViewItemSelected:(MMToolBarViewBlock)handle {
    
    //指向用户实现的Block
    _itemBlock = handle;
}
/** 手指点击smallScrollView */
- (void)MMscrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.width;
    // 滚动标题栏到中间位置
    DDChannelLabel *titleLable = [self getLabelArrayFromSubviews][index];
    CGFloat offsetx   =  titleLable.center.x - _smallScrollView.width * 0.5;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    // 在最左和最右时，标签没必要滚动到中间位置。
    if (offsetx < 0)		 {offsetx = 0;}
    if (offsetx > offsetMax) {offsetx = offsetMax;}
    [_smallScrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    // 先把之前着色的去色：（快速滑动会导致有些文字颜色深浅不一，点击label会导致之前的标题不变回黑色）
    for (DDChannelLabel *label in [self getLabelArrayFromSubviews]) {
        label.textColor = [UIColor whiteColor];
    }
    
    // 着色
    [UIView animateWithDuration:0.5 animations:^{
        titleLable.textColor = MM_MAIN_FONTCOLOR_BLUE;
    }];
}


- (UIScrollView *)smallScrollView
{
    if (_smallScrollView == nil) {
        _smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _smallScrollView.backgroundColor = [UIColor clearColor];
        _smallScrollView.delegate = self;
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        
    }
    return _smallScrollView;
}

@end
