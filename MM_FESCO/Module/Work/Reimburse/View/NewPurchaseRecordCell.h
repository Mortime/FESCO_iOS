//
//  NewPurchaseRecordCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewPurchaseRecordModel.h"
#import "EditMessageModel.h"

@protocol NewPurchaseRecordCellDelegate <NSObject>

- (void)newPurchaseRecordCellDelegateWithTag:(NSInteger)tag;

@end
@interface NewPurchaseRecordCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger indexTag;

@property (nonatomic, strong) UIButton *deleBtn;

@property (nonatomic, weak) id <NewPurchaseRecordCellDelegate> delegate;

@property (nonatomic, strong)  EditMessageModel *model;

@end
