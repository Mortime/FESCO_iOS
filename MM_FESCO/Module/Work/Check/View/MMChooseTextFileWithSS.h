//
//  MMChooseTextFileWithSS.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/3/30.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVSearchViewUITextFieldDelegateBlock)(UITextField *textField,NSInteger indexTag);

@interface MMChooseTextFileWithSS : UIView

@property (nonatomic, strong) UITextField *rightTextFiled;

@property (nonatomic,strong) NSString *leftTitle;

@property (nonatomic,strong) NSString *placeHold;

@property (nonatomic,strong) NSString *textFileStr;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, assign) BOOL isShowDataPickView; // 默认是不显示的

@property (nonatomic,assign) BOOL isExist; // 是否可输入 , 默认不可输入


/**
 *  textField结束编辑
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;

@end
