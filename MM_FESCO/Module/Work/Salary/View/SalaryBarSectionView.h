//
//  SalaryBarSectionView.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/13.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SalaryBarSectionViewDelegate <NSObject>

- (void)SalaryBarSectionViewDelegateWith:(UIButton *)sender;

@end

@interface SalaryBarSectionView : UIView
@property (nonatomic, strong) UIButton *flagButton;
@property (nonatomic,strong) NSString *monthStr;
@property (nonatomic,strong) NSString *moneyStr;
@property (nonatomic, assign) NSInteger indexTag;
@property (nonatomic, weak) id <SalaryBarSectionViewDelegate> delegate;
@end
