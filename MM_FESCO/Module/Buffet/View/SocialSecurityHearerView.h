//
//  SocialSecurityHearerView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SocialSecurityHearerViewDelegate <NSObject>

- (void)socialSecurityHearerViewDelegateWithTag:(NSInteger)tag;

@optional

- (void)socialSecurityHearerViewDelegateUpLoadImage;

@end
@interface SocialSecurityHearerView : UIView

@property (nonatomic, weak) id<SocialSecurityHearerViewDelegate>delegate;

@property (nonatomic, strong) UIImageView *iconView;

@end
