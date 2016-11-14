//
//  TemplateInfoModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/14.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "cust_Id" = 29;
 "type_Code" = 1;
 "type_Name" = "\U65e5\U5e38\U62a5\U9500\U5355";

 
 */

@interface TemplateInfoModel : NSObject

@property (nonatomic, strong) NSString *typeName;

@property (nonatomic, assign) NSUInteger typeCode;
@end
