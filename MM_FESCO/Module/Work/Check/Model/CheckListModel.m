//
//  CheckListModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "CheckListModel.h"

@implementation CheckListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"signAddress": @"cust_Addr"
              };
}

@end
