//
//  CheckListModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 beginTime = 1473123834000;
 "check_Type" = 1;
 "cust_Addr" = "\U96e8\U9716\U5927\U53a6";
 endTime = "<null>";
 memo = "<null>";
 
 */

@interface CheckListModel : NSObject

@property (nonatomic, strong) NSString *beginTime;

@property (nonatomic, strong) NSString *signAddress;

@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) NSString *memo;



@end
