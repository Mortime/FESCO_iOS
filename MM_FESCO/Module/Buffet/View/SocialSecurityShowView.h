//
//  SocialSecurityShowView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/23.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SocialSecurityShowViewDelegate <NSObject>

-(void)socialSecurityShowViewDelegateWithMessageTag:(NSInteger)messageTag viewTag:(NSInteger)viewTag;

@end

@interface SocialSecurityShowView : UIView

@property (nonatomic, weak) id <SocialSecurityShowViewDelegate> delegate;

@end
