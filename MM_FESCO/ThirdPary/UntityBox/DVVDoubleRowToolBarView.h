//
//  DVVDoubleRowToolBarView.h
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVDoubleRowToolBarView : UIView

@property (nonatomic,assign) BOOL isHomeDetailsVc;

- (instancetype)initWithFrame:(CGRect)frame isHomeDetailsVc:(BOOL)isHomeDetailsVc upTitleArray:(NSArray *)upTitleArray downTitleArray:(NSArray *)downTitleArray upTitleFont:(UIFont *)upTitleFont downTitleFont:(UIFont *)downTitleFont;

//预定义一个Block类型
typedef void(^DVVDoubleRowToolBarViewBlock)(UIButton *button);

//当前选中的按钮（默认为 0 ）
@property(nonatomic,assign) NSInteger selectButtonInteger;

//按钮正常情况下的颜色
@property(nonatomic,strong) UIColor *buttonNormalColor;
//按钮选中时的颜色
@property(nonatomic,strong) UIColor *buttonSelectColor;

//存放全部标题的数组
@property(nonatomic,strong) NSArray *upTitleArray;
@property(nonatomic,strong) NSArray *downTitleArray;

//标题字体大小
@property(nonatomic,strong) UIFont *upTitleFont;
@property(nonatomic,strong) UIFont *downTitleFont;
//标题正常情况下的颜色
@property(nonatomic,strong) UIColor *titleNormalColor;
//标题选中时的颜色
@property(nonatomic,strong) UIColor *titleSelectColor;
//标题的位置Y偏移量
@property(nonatomic,assign) CGFloat upTitleOffSetY;

//跟随条的位置（0：下方；1：上方）
@property(nonatomic,assign) BOOL followBarLocation;
//跟随条的颜色
@property(nonatomic,strong) UIColor *followBarColor;
//跟随条的高度
@property(nonatomic,assign) CGFloat followBarHeight;
//跟随条是否隐藏
@property(nonatomic,assign) CGFloat followBarHidden;

//模拟点击一项的方法(参数为一个Block)
- (void)dvvDoubleRowToolBarViewItemSelected:(DVVDoubleRowToolBarViewBlock)handle;

- (void)refreshUpTitle:(NSArray *)array;

@end
