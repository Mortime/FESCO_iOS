//
//  LaterTimeStatisticModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/10/20.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 
 {
 counts = 2;
 duration = "<null>";
 "emp_Name" = "\U5b59\U8d6b";
 },

 
 */

@interface LaterTimeStatisticModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic, assign) NSInteger  timeNumber;

@end
