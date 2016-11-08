//
//  NewReimburseTemplateCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/7.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DVVSearchViewUITextFieldDelegateBlock)(UITextField *textField,NSInteger indexTag);


@interface NewReimburseTemplateCell : UITableViewCell

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *detailStr;

@property (nonatomic, assign) BOOL isShowDataPickView; // 默认是不显示的

@property (nonatomic,assign) BOOL isExist; // 是否可输入 , 默认不可输入


@property (nonatomic,strong) NSString *placeHold;

@property (nonatomic,strong) NSString *textFileStr;

@property (nonatomic, strong) UIImageView *arrowImageView;


/**
 *  textField结束编辑
 *
 *  @param handle DVVSearchViewUITextFieldDelegateBlock
 */
- (void)dvv_setTextFieldDidEndEditingBlock:(DVVSearchViewUITextFieldDelegateBlock)handle;
@end
