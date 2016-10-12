//
//  PersonalMessageModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/22.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PersonalMessageModel.h"

@implementation PersonalMessageModel



/*"emp_Id" = 163;
"emp_Name" = "\U80e1\U677e";
 */

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"empID": @"emp_Id",
              @"empName":@"emp_Name"};
}

@end
