//
//  DVVSubCityView.h
//  studentDriving
//
//  Created by 大威 on 16/2/27.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVSubCityCell.h"
@class DVVSubCityView;

@protocol DVVSubCityViewDelegate <NSObject>

@optional
- (void)dvvSubCityView:(DVVSubCityView *)dvvSubCityView didSelectItemWithCityName:(NSString *)cityName;

@end

@interface DVVSubCityView : UIView<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id <DVVSubCityViewDelegate>delegate;

- (void)show;

- (void)remove;

@end
