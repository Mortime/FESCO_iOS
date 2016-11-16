//
//  ewPurchaseSubBookCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewPurchaseSubBookCellDelegate <NSObject>

- (void)newPurchaseSubBookCellDelegateWithBillNumber:(NSString *)billNumber;

@end
@interface NewPurchaseSubBookCell : UITableViewCell

@property (nonatomic, weak) id <NewPurchaseSubBookCellDelegate> delegate;

@end
