//
//  PhoneListTableCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/25.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneListTableCellDelegate <NSObject>

- (void)phoneListTableCellDelegateWithEmpID:(NSInteger)empID empName:(NSString *)empName;

@end



@interface PhoneListTableCell : UITableViewCell

@property (nonatomic ,strong) UIImageView *leftImageView;

@property (nonatomic ,strong) UIImageView *messageImageView;

@property (nonatomic ,strong) UILabel *nameLabel;

@property (nonatomic ,strong) UILabel *phoneLabel;

@property (nonatomic ,strong) UILabel *mobileLabel;

@property (nonatomic, strong) UIViewController *parantVC;

@property (nonatomic, assign) NSInteger empID; // 该ID用于环信聊天

@property (nonatomic, strong) NSString *empName; // 该name用于环信聊天

@property (nonatomic, weak) id <PhoneListTableCellDelegate> delegate;

@end
