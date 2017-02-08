//
//  DVVDoubleRowToolBarView.m
//  Principal
//
//  Created by dawei on 15/11/27.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVDoubleRowToolBarView.h"
//标题和跟随条颜色
#define TITLE_COLOR [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1]

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height

@interface DVVDoubleRowToolBarView()

//执行点击事件的Block
@property(nonatomic,copy) DVVDoubleRowToolBarViewBlock itemBlock;

//跟随条
@property(nonatomic,strong) UILabel *followBarLabel;

@end

@implementation DVVDoubleRowToolBarView

- (instancetype)initWithFrame:(CGRect)frame isHomeDetailsVc:(BOOL)isHomeDetailsVc upTitleArray:(NSArray *)upTitleArray downTitleArray:(NSArray *)downTitleArray upTitleFont:(UIFont *)upTitleFont downTitleFont:(UIFont *)downTitleFont
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.isHomeDetailsVc = isHomeDetailsVc;
        self.upTitleArray = upTitleArray;
        self.downTitleArray = downTitleArray;
        self.upTitleFont = upTitleFont;
        self.downTitleFont = downTitleFont;
        
        //设置导航栏中的按钮大小
        CGSize buttonSize = CGSizeMake(WIDTH/_downTitleArray.count, HEIGHT);
        
        //循环创建所有的按钮
        for (int i = 0; i < _downTitleArray.count; i++) {
            
            UIButton *itemButton = [self createOneButtonWithUpTitle:_upTitleArray[i] downTitle:_downTitleArray[i] Size:buttonSize MinX:i * buttonSize.width Tag:i];
            [self addSubview:itemButton];
            
            if (self.isHomeDetailsVc) {
                
                UIView *lineView = [[UIView alloc] init];
                CGFloat lineViewX = itemButton.width-1;
                lineView.frame = CGRectMake(lineViewX, 10, 0.5, itemButton.height-20);
                lineView.backgroundColor = [UIColor lightGrayColor];
                lineView.alpha = 0.3;
                [itemButton addSubview:lineView];
                
            }
            
        }
        
        //添加跟随的按钮
        CGFloat locationFloat = _selectButtonInteger * buttonSize.width;
        if (_followBarLocation) {
            _followBarLabel.frame = CGRectMake(locationFloat, 0, buttonSize.width, _followBarHeight);
        }else{
            _followBarLabel.frame = CGRectMake(locationFloat, buttonSize.height-_followBarHeight, buttonSize.width, _followBarHeight);
        }
        //颜色
        _followBarLabel.backgroundColor = _followBarColor;
        
        //将跟随条的tag值设为12345，避免和按钮的tag值起冲突
        _followBarLabel.tag = 12345;
        
        if (!_followBarHidden) {
            [self addSubview:_followBarLabel];
        }
        
        //默认选中第一个按钮
        [self selectOneButton:_selectButtonInteger];
        
        //调用初始化属性
        [self chuShiHuaShuXing];
        
    }
    return self;
}

- (void)refreshUpTitle:(NSArray *)array {
    
    NSLog(@"%s array:%@ self.subviews:%@",__func__,array,self.subviews);
    
    if (!array.count) {
        return;
    }
    for (UIButton *itemButton in self.subviews) {
        
        for (UIButton *btn in itemButton.subviews) {
            if (btn.tag != 0 && [btn isKindOfClass:[UIButton class]]) {
                [btn setTitle:array[btn.tag - 1] forState:UIControlStateNormal];
                if (self.isHomeDetailsVc) {
                    [btn setTitleColor:RGB_Color(61, 139, 255) forState:UIControlStateNormal];
                }
            }
        }
    }
    
}

#pragma mark - 按钮的点击事件
- (void)btnClickAction:(UIButton *)sender {
    
    //加此判断，避免重复按一个按钮，重复触发事件
    if(sender.tag != _selectButtonInteger){
        
        for (UIButton *button in sender.superview.subviews) {
            
            //使跟随条跟随
            if (button.tag==12345 && !_followBarHidden) {
                //获取frame
                CGRect rect=button.frame;
                //现在要移动到的minX坐标
                CGFloat  newMinX=(sender.tag)*rect.size.width;
                
                rect.origin.x=newMinX;
                //动画
                [UIButton animateWithDuration:0.3 animations:^{
                    button.frame=rect;
                }];
            }else{
                if (button.tag == _selectButtonInteger) {
                    
                    //上次按下的背景色为正常情况下的颜色
                    button.backgroundColor = _buttonNormalColor;
                    //上次按下的字体色为正常情况下的颜色
                    [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
                }
            }
        }
        //选中此按钮
        [self selectOneButton:sender.tag];
        
        //如果Block不为空时才调用，执行在其他类中的实现的内容
        if (_itemBlock) {
            
            _itemBlock(sender);
        }
    }
}

#pragma mark - 选中一个按钮

- (void)selectOneButton:(NSInteger)tag {
    
    for (UIButton *button in self.subviews) {
        
        if (button.tag == tag) {
            //改变背景色和字体颜色为选中时的颜色
            button.backgroundColor=_buttonSelectColor;
            [button setTitleColor:_titleSelectColor forState:UIControlStateNormal];
        }
    }
    //更改当前选中的按钮tag值
    _selectButtonInteger=tag;
}
#pragma mark - 实现在 .h中声明的，模拟点击一项的方法（参数为一个Block）
/**
 param handle 用户实现的Block
 */
- (void)dvvDoubleRowToolBarViewItemSelected:(DVVDoubleRowToolBarViewBlock)handle {
    
    //指向用户实现的Block
    _itemBlock = handle;
}

#pragma mark - 创建导航栏中的所有按钮

#pragma mark 创建一个按钮

- (UIButton *)createOneButtonWithUpTitle:(NSString *)upTitle
                               downTitle:(NSString *)downTitle
                                    Size:(CGSize)size
                                    MinX:(CGFloat)mimX
                                     Tag:(NSInteger)tag {
    
    UIButton *btn = [UIButton new];
    //位置和大小
    btn.frame = CGRectMake(mimX, 0, size.width, size.height);
    //tag值
    btn.tag=tag;
    //点击事件
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *upButton = [UIButton new];
    upButton.tag = tag + 1;
    [upButton setBackgroundColor:[UIColor clearColor]];
    upButton.frame = CGRectMake(0, _upTitleOffSetY, size.width, size.height / 2.0);
    //显示文字
    [upButton setTitle:upTitle forState:UIControlStateNormal];
    //字体
    upButton.titleLabel.font = _downTitleFont;
   
    //显示文字颜色
    [upButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [upButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    if (self.isHomeDetailsVc) {
        [upButton setTitleColor:RGB_Color(140, 140, 140) forState:UIControlStateNormal];
        [upButton setTitleColor:RGB_Color(140, 140, 140) forState:UIControlStateSelected];
    }
    
    UIButton *downButton = [UIButton new];
    [downButton setBackgroundColor:[UIColor clearColor]];
    downButton.frame = CGRectMake(0, size.height / 2.0 - 10, size.width, size.height / 2.0);
    [downButton setTitle:downTitle forState:UIControlStateNormal];
    downButton.titleLabel.font = _downTitleFont;
    [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    if (self.isHomeDetailsVc) {
        [downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [downButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    }
    upButton.userInteractionEnabled = NO;
    downButton.userInteractionEnabled = NO;
    
    [btn addSubview:upButton];
    [btn addSubview:downButton];
    
    return btn;
    
}

#pragma mark - 初始化属性

- (void)chuShiHuaShuXing {
    
    
    //当前选中的按钮
    _selectButtonInteger = 0;
    
    //按钮
    _buttonNormalColor = [UIColor clearColor];
    _buttonSelectColor = [UIColor clearColor];
    
    //标题
    _upTitleArray = @[ @"1", @"2", @"3" ];
    _downTitleArray= @[ @"标题1", @"标题2", @"..." ];
    _upTitleFont = [UIFont systemFontOfSize:17];
    _downTitleFont = [UIFont systemFontOfSize:17];
    _titleNormalColor = [UIColor grayColor];
    _titleSelectColor = TITLE_COLOR;
    if (self.isHomeDetailsVc) {
        _titleSelectColor = [UIColor blueColor];
    }
    //跟随条
    _followBarColor = TITLE_COLOR;
    _followBarHeight = 2;
    _followBarLocation = 0;
    _followBarHidden = 0;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
