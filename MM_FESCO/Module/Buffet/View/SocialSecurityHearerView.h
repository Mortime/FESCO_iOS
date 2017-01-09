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

@end
@interface SocialSecurityHearerView : UIView

@property (nonatomic, weak) id<SocialSecurityHearerViewDelegate>delegate;

@end
