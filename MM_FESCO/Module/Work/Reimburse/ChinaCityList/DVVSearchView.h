//
//  DVVSearchView.h
//  studentDriving
//
//  Created by 大威 on 16/1/6.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVSearchViewUITextFieldDelegateBlock)(UITextField *textField);

@interface DVVSearchView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, readonly, assign) CGFloat defaultHeight;

/**
 *  textField开始编辑
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidBeginEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;
/**
 *  textField结束编辑
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;

/**
 *  文本改变
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldTextChangeBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;

@property (nonatomic,copy) NSString *placeholder;

@end
