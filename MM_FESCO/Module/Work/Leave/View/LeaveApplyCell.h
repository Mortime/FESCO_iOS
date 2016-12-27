//
//  LeaveApplyCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMChooseTextFile.h"


@protocol LeaveApplyCellDelegate <NSObject>


@optional
- (void)leaveApplyCellDelegateWithHourTime:(NSString *)hourtime;  

- (void)leaveApplyCellDelegateWithAMPM:(UITextField *)AMPM;

@end

@interface LeaveApplyCell : UITableViewCell

@property (nonatomic,strong) MMChooseTextFile *textFile;


@property (nonatomic, strong) NSString *leftTitle;

@property (nonatomic, strong) NSString *placeTitle;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *pickData;

@property (nonatomic, strong) NSArray *holTypeArray;

@property (nonatomic, strong) NSArray *unitsArray;

@property (nonatomic, strong) NSString *holNumberStr; // 剩余假期数

@property (nonatomic, assign) BOOL isShowAMPM;   // 是否显示上午或者下午选择框

@property (nonatomic, assign) BOOL isShowTimeNum; // 当假期类型为休假 时间单位为小时时显示

@property (nonatomic, strong) NSString *timeType;


@property (nonatomic, weak) id <LeaveApplyCellDelegate> delegate;

@end
