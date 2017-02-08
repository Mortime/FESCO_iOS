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
#import "NOBookChooseModel.h"

@protocol NewPurchaseRecordCellDelegate <NSObject>

- (void)newPurchaseRecordCellDelegateWithTag:(NSInteger)tag sectionTag:(NSInteger)sectionTag;

@end
@interface NewPurchaseRecordCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dic;

@property (nonatomic, assign) NSInteger indexTag;

@property (nonatomic, assign) NSInteger sectionTag;



@property (nonatomic, strong) UIButton *deleBtn;

@property (nonatomic, weak) id <NewPurchaseRecordCellDelegate> delegate;

@property (nonatomic, strong)  EditMessageModel *model;

@property (nonatomic, strong) NOBookChooseModel *chooseModel;
@end
