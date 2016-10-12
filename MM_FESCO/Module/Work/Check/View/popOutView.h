//
//  popOutView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

//预定义一个Block类型
typedef void(^MMSignOUtButtonBlock)(UIButton *button);

typedef void(^MMSignOUtTextFieldDelegateBlock)(UITextField *textField);

@interface popOutView : UIView
/**
 
 *  textField结束编辑
 *
 *  @param handle MMSignOUtTextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidEndEditingBlock:(MMSignOUtTextFieldDelegateBlock)handle;


- (void)mm_setSignOutSelected:(MMSignOUtButtonBlock)handle;
@end
