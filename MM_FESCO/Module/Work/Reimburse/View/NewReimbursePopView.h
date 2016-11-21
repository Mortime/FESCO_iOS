//
//  NewReimbursePopView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewReimbursePopViewDelegate <NSObject>

- (void)newReimbursePopViewDelegateWithType:(NSString *)type typeCode:(NSInteger)typeCode indexTag:(NSInteger)indexTag;

- (void)newReimbursePopViewDelegateWithIndexTag:(NSInteger)indexTag;

@end
@interface NewReimbursePopView : UIView

@property (nonatomic,weak) id <NewReimbursePopViewDelegate> delegate;

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *titleLabel;  // title
@property (nonatomic, assign) popViewType popViewType;

- (instancetype)initWithFrame:(CGRect)frame type:(popViewType)popViewType;
@end
