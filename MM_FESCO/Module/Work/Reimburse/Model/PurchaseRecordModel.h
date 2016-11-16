//
//  PurchaseRecordModel.h
//  MM_FESCO
//
//  Created by Mortimey on 2016/11/9.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PurchaseRecordModel : NSObject

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *typeName;

@property (nonatomic, strong) NSArray *subTypes;

@property (nonatomic, assign) NSInteger dateType;

@property (nonatomic, assign) NSInteger needCity;

@property (nonatomic, assign) NSInteger  typeCode;




@end
