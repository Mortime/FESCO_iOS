//
//  OverTimeStatisticModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/10/21.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 {
 counts = "<null>";
 duration = "9.5";
 "emp_Name" = "\U8d75\U9a81";
 }
 */
@interface OverTimeStatisticModel : NSObject


@property (nonatomic,strong) NSString *name;

@property (nonatomic, assign) CGFloat  timeNumber;

@end
