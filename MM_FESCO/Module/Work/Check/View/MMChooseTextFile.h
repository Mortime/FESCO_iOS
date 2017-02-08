//
//  MMChooseTextFile.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/31.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DVVSearchViewUITextFieldDelegateBlock)(UITextField *textField,NSInteger indexTag);


@interface MMChooseTextFile : UIView


@property (nonatomic, strong) UITextField *rightTextFiled;

@property (nonatomic,strong) NSString *leftTitle;

@property (nonatomic,strong) NSString *placeHold;

@property (nonatomic,strong) NSString *textFileStr;

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic, assign) BOOL isShowDataPickView; // 默认是不显示的

@property (nonatomic,assign) BOOL isExist; // 是否可输入 , 默认不可输入

@property (nonatomic, assign) NSString *timeType;  // 当显示dataPickView 时 设置日期格式  默认为 yyyy-MM-dd HH:mm

/**
 *  textField结束编辑
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;

@end
