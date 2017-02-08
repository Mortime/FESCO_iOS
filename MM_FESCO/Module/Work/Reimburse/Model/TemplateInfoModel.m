//
//  TemplateInfoModel.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "TemplateInfoModel.h"

@implementation TemplateInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{ @"typeName":@"type_Name",
              @"typeCode":@"type_Code"
              };
}

@end
