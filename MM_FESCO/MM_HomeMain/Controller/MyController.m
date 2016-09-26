//
//  MyController.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MyController.h"

@interface MyController ()

@property (nonatomic, strong) UIImageView *flagImageView;

@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"d9f5f9"];
    [self.view addSubview:self.flagImageView];
    
}
- (void)viewWillLayoutSubviews{
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(@66);
        make.width.mas_equalTo(@178);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (UIImageView *)flagImageView{
    if (_flagImageView == nil) {
        _flagImageView = [[UIImageView alloc] init];
        _flagImageView.image = [UIImage imageNamed:@"Flag_ImageView_image"];
        _flagImageView.backgroundColor = [UIColor clearColor];
    }
    return _flagImageView;
}

@end
