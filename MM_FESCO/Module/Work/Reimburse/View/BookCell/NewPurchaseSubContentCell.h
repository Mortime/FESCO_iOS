//
//  ewPurchaseSubContentCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMChooseTextFile.h"

@protocol NewPurchaseSubContentCellDelegate <NSObject>

- (void)newPurchaseSubContentCellDelegateWithTextField:(UITextField *)textField indexTag:(NSInteger)indexTag;

@end

@interface NewPurchaseSubContentCell : UITableViewCell

@property (nonatomic, strong) MMChooseTextFile *textFiled;

@property (nonatomic, weak) id <NewPurchaseSubContentCellDelegate> delegate;
@end
