//
//  MMRegisterTextFiledView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MMRegisterTextFiledViewDelegateBlock)(UITextField *textField,NSInteger indexTag);

@interface MMRegisterTextFiledView : UIView


@property (nonatomic,strong) NSString *leftTitle;

@property (nonatomic,strong) NSString *placeHold;




/**
 *  textField结束编辑
 *
 *  @param handle MMRegisterTextFiledViewDelegateBlock
 */
- (void)MM_setTextFieldDidEndEditingBlock:(MMRegisterTextFiledViewDelegateBlock)handle;


@end
