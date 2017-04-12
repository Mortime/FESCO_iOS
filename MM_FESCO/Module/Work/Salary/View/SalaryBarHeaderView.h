//
//  SalaryBarHeaderView.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/12.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
//预定义一个Block类型
typedef void(^MMToolBarViewBlock)(UILabel *label);

@interface SalaryBarHeaderView : UIView

/**  该方法用于显示tag的个数  */
- (void)initTag:(NSArray *)tagArray;

/** 模拟点击一项的方法(参数为一个Block)  */
- (void)MMToolBarViewItemSelected:(MMToolBarViewBlock)handle;

/** 手指点击smallScrollView */
- (void)MMscrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
@end
