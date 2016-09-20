//
//  LeaveApplyCell.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMChooseTextFile.h"

@interface LeaveApplyCell : UITableViewCell

@property (nonatomic,strong) MMChooseTextFile *textFile;


@property (nonatomic, strong) NSString *leftTitle;

@property (nonatomic, strong) NSString *placeTitle;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *pickData;

@end
