//
//  NewReimburseConsumePopView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/8.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewReimburseConsumePopViewDelegate <NSObject>

- (void)newReimburseConsumePopViewDelegatWithRow:(NSInteger)row;

@end
@interface NewReimburseConsumePopView : UIView

@property (nonatomic,weak) id <NewReimburseConsumePopViewDelegate> delegate;

@end
