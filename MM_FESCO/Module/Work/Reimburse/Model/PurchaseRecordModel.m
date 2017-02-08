//
//  PurchaseRecordModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PurchaseRecordModel.h"

@implementation PurchaseRecordModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"typeName":@"type_Name",
              @"subTypes":@"sub_Types",
              @"dateType":@"date_Type",
              @"needCity":@"need_City",
              @"typeCode":@"type_Code",
              @"ID":@"id"
              
            };
}

@end
