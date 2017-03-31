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
- (void)didClickedWithContent:(NSString *)content code:(NSString *)code dataType:(chooseDataType)dataType;

@end


@interface SocialSecurityChooseDataController : MMBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) chooseDataType dataType;

@property (nonatomic, weak) id <SocialSecurityChooseDataControllerDelegate> delegate;

@end
