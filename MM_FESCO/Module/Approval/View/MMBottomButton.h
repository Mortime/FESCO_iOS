//
//  MMBottomButton.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MMBottomButtonDelegateBlock)(NSInteger indexTag);

@interface MMBottomButton : UIView


/**
 *  底部按钮点击事件
 *
 *  @param handle MMBottomButtonDelegateBlock
 */
- (void)mm_setBottomButtonDelegateBlock:(MMBottomButtonDelegateBlock)handle;

@end
