//
//  PushInformationManager.h
//  studentDriving
//
//  Created by bestseller on 15/11/11.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface PushInformationManager : NSObject

+ (void)receivePushInformation:(NSDictionary *)pushInformation;

@end
