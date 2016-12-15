//
//  NumberAddOffView.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/10.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NumberAddOffViewDelegate <NSObject>

- (void)numberAddOffViewDelegateWihtBillNumber:(NSString *)billNumber;

@end

@interface NumberAddOffView : UIView

@property (nonatomic, strong) UILabel *resultLabel;

@property (nonatomic, weak) id <NumberAddOffViewDelegate> delegate;

@end
