//
//  SocialSecurityChooseDataController.h
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/9.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "MMBaseViewController.h"

@protocol SocialSecurityChooseDataControllerDelegate <NSObject>

// cell的点击事件
- (void)didClickedWithName:(NSString *)cityName;

@end


@interface SocialSecurityChooseDataController : MMBaseViewController<UITableViewDataSource,UITableViewDelegate>



@property (weak, nonatomic) id<SocialSecurityChooseDataControllerDelegate>delegate;

@property (strong, nonatomic) NSMutableArray *arrayLocatingCity;//定位城市数据
@property (strong, nonatomic) NSMutableArray *arrayHotCity;//热门城市数据
//@property (strong, nonatomic) NSMutableArray *arrayHistoricalCity;//常用城市数据

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *openCityArray; // 开放城市的数据




@property (nonatomic, strong) NSArray *dataSource;




@end
