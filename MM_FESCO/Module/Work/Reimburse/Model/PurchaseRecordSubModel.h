//
//  PurchaseRecordSubModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseRecordSubModel : NSObject

/*
 "cust_Id" = 29;
 "date_Type" = "<null>";
 "has_Children" = "<null>";
 icon = "<null>";
 id = 17;
 "is_Root" = 0;
 "need_City" = "<null>";
 "p_Id" = 3;
 selected = 0;
 "sub_Types" = "<null>";
 "type_Code" = "<null>";
 "type_Name" = "\U7070\U673a";

*/

@property (nonatomic, strong) NSString *typeName;

@property (nonatomic, assign) NSInteger ID;

@end
