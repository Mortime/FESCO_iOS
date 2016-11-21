//
//  GroupInfoModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/18.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
 {
 "cust_Id" = 29;
 "group_Id" = 1;
 "group_Name" = "\U4e2d\U745e\U65b9\U80dc\U91d1\U878d\U670d\U52a1\U5916\U5305\Uff08\U5317\U4eac\Uff09\U6709\U9650\U516c\U53f8";
 "group_Status" = 1;
 id = 98;
 memo = "<null>";
 parentid = 0;
 },

 
 */
@interface GroupInfoModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *groupName;

@end
