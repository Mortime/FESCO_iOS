//
//  FileMainApprovalDetailCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol fileMainApprovalDetailCellDelegate <NSObject>

- (void)fileMainApprovalDetailCellDelegateWithTextFile:(UITextField *)textfile indexTag:(NSInteger)indexTag;

@end

@interface FileMainApprovalDetailCell : UITableViewCell

@property (nonatomic ,strong) NSString *leftTitle;

@property (nonatomic, strong) NSString *rightTitle;

@property (nonatomic, strong) NSArray *pickDataArray;

@property (nonatomic, assign) BOOL isExist;

@property (nonatomic, assign) NSInteger textFiledTag;

@property (nonatomic, weak) id <fileMainApprovalDetailCellDelegate> delegate;

@end
