//
//  OverTimeApplySSCell.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/4/7.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMChooseTextFileWithSS.h"

@interface OverTimeApplySSCell : UITableViewCell
@property (nonatomic,strong) MMChooseTextFileWithSS *textFile;


@property (nonatomic, strong) NSString *leftTitle;

@property (nonatomic, strong) NSString *placeTitle;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSArray *pickData;

@end
