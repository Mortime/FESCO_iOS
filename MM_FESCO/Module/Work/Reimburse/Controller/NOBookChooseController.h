//
//  NOBookChooseController.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMBaseViewController.h"

@protocol NOBookChooseControllerDelegate <NSObject>

- (void)NOBookChooseControllerDelegateWithData:(NSMutableArray *)arrayData;

@end

@interface NOBookChooseController : MMBaseViewController

@property (nonatomic, weak) id <NOBookChooseControllerDelegate> delegate;

@end
