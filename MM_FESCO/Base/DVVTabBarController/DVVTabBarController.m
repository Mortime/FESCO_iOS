//
//  DVVTabBarController.m
//  DVVTabBarController
//
//  Created by 大威 on 15/12/4.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import "DVVTabBarController.h"
#import "DVVDockItem.h"

@interface DVVTabBarController ()

@property (nonatomic, assign) BOOL loaded;

// 所有项的图片名字（正常）
@property (nonatomic, strong) NSArray *iconNormalArray;
// 所有项的图片名字（选中）
@property (nonatomic, strong) NSArray *iconSelectedArray;

@property (nonatomic, strong) NSArray *itemBackgroundNormalArray;
@property (nonatomic, strong) NSArray *itembackgroundSelectedArray;

// 所有项的名字
@property (nonatomic, strong) NSArray *titleArray;
// 正常情况下的颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
// 选中时的颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *backgroundColor;

// 定义一个UIView添加到TabBar上
// 在这个视图上添加每一项
// 每一项都用一个UIButton代替
@property(nonatomic, strong) UIView *coverView;

@property(nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic,assign) UIButton *selectBtn;

@property (nonatomic, strong) NSMutableArray *itemArray;

@end

@implementation DVVTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialProperty];
    }
    return self;
}

#pragma mark - 初始化属性 method
- (void)initialProperty {
    
    
    // 去除顶部黑线
    [UITabBar appearance].clipsToBounds = YES;
    
    _titleNormalColor = [UIColor blackColor];
    _titleSelectedColor = MM_MAIN_FONTCOLOR_BLUE ;
    _itemArray = [NSMutableArray array];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_loaded) {
        return;
    }
    
    //    self.backgroundImage = [UIImage imageNamed:@"tabBar_background"];
    
//    self.iconNormalArray = @[ @"Home_Work_Normal",
//                              @"Home_Zizhu_Normal",
//                              @"Home_News_Normal" ,
//                              @"Home_Tools_Normal",
//                              @"Home_My_Normal"];
//    
//    self.iconSelectedArray = @[ @"Home_Work_Select",
//                                @"Home_Zizhu_Select",
//                                @"Home_News_Select",
//                                @"Home_Tools_Select",
//                                @"Home_My_Select"];
    
    self.iconNormalArray = @[ @"Home_Work_Normal",
                              @"Test_Approval",
                              @"Test_Purase" ,
                              @"Test_Phone",
                              @"Home_My_Normal"];
    
    self.iconSelectedArray = @[ @"Home_Work_Select",
                                @"Test_Approval_Select",
                                @"Test_Purase_Select",
                                @"Test_Phone_Select",
                                @"Home_My_Select"];
//
//    self.itemBackgroundNormalArray = @[ @"",
//                                        @"",
//                                        @"" ];
//    
//    self.itembackgroundSelectedArray = @[ @"",
//                                          @"",
//                                          @"" ];
    
//    self.titleArray = @[ @"工作", @"自助", @"资讯",@"工具",@"我的"];
    
    self.titleArray = @[ @"工作", @"审批", @"报销",@"通讯录"];

    
    CGRect rect = self.tabBar.bounds;
    // 高度需要+1，否则会出现底部tabBar的白色背景（会显示出来一条白线）
    rect.size.height += 1;
    
    _coverView = [UIView new];
    _coverView.frame = rect;
//    _coverView.backgroundColor = RGB_Color(29, 28, 33);
    _coverView.backgroundColor = [UIColor whiteColor];
    // 添加背景图片
//    if (_backgroundImage) {
//        _coverView.backgroundColor = [UIColor clearColor];
//        _backgroundImageView = [UIImageView new];
//        _backgroundImageView.image = _backgroundImage;
//        _backgroundImageView.frame = rect;
//        [self.tabBar addSubview:_backgroundImageView];
//    }
    
    [self.tabBar addSubview:_coverView];
    
    
    //添加所有的子项
    for (int i=0; i<_titleArray.count; i++) {
        
        [self addOneItemWithTitle:_titleArray[i] tag:i];
    }
    
    _loaded = true;
}

#pragma mark - 选中一项 method
- (void)itemButtonSelected:(UIButton *)sender {
    
//    [self.selectBtn setBackgroundColor:RGB_Color(29, 28, 33)];
//    [sender setBackgroundColor:RGB_Color(22, 22, 25)];
    self.selectBtn = sender;
    
    //取消上次选中的状态
    for (UIButton *itemBtn in _coverView.subviews) {
        
        if ([itemBtn isKindOfClass:[UIButton class]] && itemBtn.tag == self.selectedIndex) {
            
            itemBtn.selected = NO;
        }
    }
    
    //打开选中的窗体
    self.selectedIndex = sender.tag;
    
    
    sender.selected = YES;
}

#pragma mark - 重新布局 coverView 中的子控件 method
- (void)reconfigureCoverViewSubviewsFrame {
    
    //得到一个按钮的宽度
    CGFloat btnWidth = _coverView.bounds.size.width / _coverView.subviews.count;
    for (UIButton *itemBtn in _coverView.subviews) {
        
        CGRect frameRect;
        //调整width,height
        frameRect.size.width = btnWidth;
        frameRect.size.height = _coverView.bounds.size.height - 2;
        //调整minX,ninY
        frameRect.origin.x = itemBtn.tag * btnWidth;
        frameRect.origin.y = 2;
        
        //赋值坐标
        itemBtn.frame = frameRect;
    }
    
}


#pragma mark - 向视图中添加一项 method

- (void)addOneItemWithTitle:(NSString *)newTitle tag:(NSInteger)tag {
    
    DVVDockItem *itemBtn = [DVVDockItem new];
    //设置tag值
    itemBtn.tag = tag;
    itemBtn.backgroundColor = [UIColor clearColor];
    //    if (tag == 0) {
    //        itemBtn.backgroundColor = [UIColor redColor];
    //    }
    //    if (tag == 1) {
    //        itemBtn.backgroundColor = [UIColor greenColor];
    //    }
    //    if (tag == 2) {
    //        itemBtn.backgroundColor = [UIColor orangeColor];
    //    }
    //取消高亮效果
    itemBtn.adjustsImageWhenHighlighted = NO;
    //设置图片
    [itemBtn setImage:[UIImage imageNamed:[_iconNormalArray objectAtIndex:tag]] forState:UIControlStateNormal];
    [itemBtn setImage:[UIImage imageNamed:[_iconSelectedArray objectAtIndex:tag]] forState:UIControlStateSelected];
    
    [itemBtn setBackgroundImage:[UIImage imageNamed:[_itemBackgroundNormalArray objectAtIndex:tag]] forState:UIControlStateNormal];
    [itemBtn setBackgroundImage:[UIImage imageNamed:[_itembackgroundSelectedArray objectAtIndex:tag]] forState:UIControlStateSelected];
    
    //设置标题
    [itemBtn setTitle:newTitle forState:UIControlStateNormal];
    [itemBtn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    [itemBtn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
    
    //添加点击事件
    [itemBtn addTarget:self action:@selector(itemButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加
    [_coverView addSubview:itemBtn];
    [_itemArray addObject:itemBtn];
    
    //重新布局
    [self reconfigureCoverViewSubviewsFrame];
    
    if (itemBtn.tag == 0) {
        
        [self itemButtonSelected:itemBtn];
    }
}
- (void)seleItemWithIndex:(NSInteger )index{
    for (DVVDockItem *item in _itemArray) {
        if (item.tag == index) {
            [self itemButtonSelected:item];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
