//
//  PurchaseRecordSubModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "PurchaseRecordSubModel.h"

@implementation PurchaseRecordSubModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"typeName":@"type_Name",
              @"ID":@"id"
              };
}

@end
