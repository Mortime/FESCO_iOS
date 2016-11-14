//
//  NewReimbursePopView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewReimbursePopViewDelegate <NSObject>

- (void)newReimbursePopViewDelegateWithType:(NSString *)type;

- (void)newReimbursePopViewDelegate;

@end
@interface NewReimbursePopView : UIView

@property (nonatomic,weak) id <NewReimbursePopViewDelegate> delegate;
@property (nonatomic,strong) NSArray *dataArray;

@end
