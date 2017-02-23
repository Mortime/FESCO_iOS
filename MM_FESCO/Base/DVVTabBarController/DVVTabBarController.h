//
//  DVVTabBarController.h
//  DVVTabBarController
//
//  Created by 大威 on 15/12/4.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMainController.h"
#import "BuffetController.h"
#import "NewsController.h"
#import "ToolsController.h"
#import "MyController.h"


@interface DVVTabBarController : UITabBarController

@property (strong, nonatomic) MMMainController   *homeVC;
@property (strong, nonatomic) BuffetController   *buffetVC;
@property (strong, nonatomic) NewsController   *newsVC;
@property (strong, nonatomic) ToolsController   *toolsVC;
@property (strong, nonatomic) MyController   *myVC;

- (void)seleItemWithIndex:(NSInteger )index;
@end
