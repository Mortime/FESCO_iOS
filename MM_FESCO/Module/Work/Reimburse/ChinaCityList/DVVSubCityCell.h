//
//  DVVSubCityCell.h
//  studentDriving
//
//  Created by 大威 on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVCityListDMData.h"

@interface DVVSubCityCell : UICollectionViewCell

@property (nonatomic, strong) UIButton *cityNameButton;

- (void)refreshData:(DVVCityListDMData *)dmData;

@end
