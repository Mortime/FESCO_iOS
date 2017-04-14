//
//  SalaryBarPopView.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/14.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SalaryBarPopViewDelegate <NSObject>

- (void)SalaryBarPopViewDelegateWithSender:(UIButton *)sender;

@end
@interface SalaryBarPopView : UIView
@property (nonatomic, strong) NSDictionary *dataDic; // 一个月所有数据
@property (nonatomic, weak) id <SalaryBarPopViewDelegate> delegate;
- (void)refreshUI;
@end
