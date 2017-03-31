//
//  SocialSecurityHearerView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialSecurityCellView.h"

@protocol SocialSecurityHearerViewDelegate <NSObject>


@optional

- (void)socialSecurityHearerViewDelegateWithTag:(NSInteger)tag;

- (void)socialSecurityHearerViewDelegateBackDataWithTextFiled:(UITextField *)textFiled tag:(NSInteger)tag;

- (void)socialSecurityHearerViewDelegateUpLoadImage;

@end
@interface SocialSecurityHearerView : UIView

@property (nonatomic, weak) id<SocialSecurityHearerViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) SocialSecurityCellView *nameView;

@property (nonatomic, strong) SocialSecurityCellView *sexView;

@property (nonatomic, strong) SocialSecurityCellView *nationView;


@end
