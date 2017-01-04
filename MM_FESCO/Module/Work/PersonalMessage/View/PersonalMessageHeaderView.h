//
//  PersonalMessageHeaderView.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/19.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVSearchViewUITextFieldDelegateBlock)(UITextField *textField);


@interface PersonalMessageHeaderView : UIView

@property (nonatomic, strong) UITextField *nameTextFiled;

@property (nonatomic, strong) UITextField *sexTextFiled;

@property (nonatomic, strong) UIViewController *paramentVC;

@property (nonatomic, strong) UIImageView *imageView;


/**
 *  textField结束编辑
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;

@end
