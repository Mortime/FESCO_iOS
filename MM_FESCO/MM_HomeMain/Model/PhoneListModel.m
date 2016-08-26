//
//  PhoneListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/26.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PhoneListModel.h"

@implementation PhoneListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"empID": @"emp_Id",
              @"empName":@"emp_Name",
              @"photoUrl":@"photo_Url",
              @"groupName":@"group_Name"};
}
@end
