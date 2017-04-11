//
//  NSArray+Sort.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/30.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

+ (NSArray  *)sortGroupWithDataSouce:(NSArray *)array  keyStr:(NSString *)keyStr{
    //    NSMutableArray  *mutableArray  = array.mutableCopy;
    NSArray *sortDesc = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:keyStr ascending:YES]];
    NSArray *sortedArr = [array sortedArrayUsingDescriptors:sortDesc];
    
    // 2、对数组进行分组，按GroupTag
    // 遍历,创建组数组,组数组中的每一个元素是一个模型数组
    NSMutableArray *_groupArr = [NSMutableArray array];
    NSMutableArray *currentArr = [NSMutableArray array];
    // 因为肯定有一个字典返回,先添加一个
    [currentArr addObject:sortedArr[0]];
    [_groupArr addObject:currentArr];
    
    
    // 如果不止一个,才要动画添加
    if(sortedArr.count > 1){
        for (int i = 1; i < sortedArr.count; i++) {
            // 先取出组数组中  上一个模型数组的第一个字典模型的groupID
            NSMutableArray *preModelArr = [_groupArr objectAtIndex:_groupArr.count-1];
            NSString *preGroupID = [[preModelArr objectAtIndex:0] objectForKey:keyStr];
            // 取出当前字典,根据groupID比较,如果相同则添加到同一个模型数组;如果不相同,说明不是同一个组的
            NSDictionary *currentDict = sortedArr[i];
            NSString *groupID = [currentDict objectForKey:keyStr];
            if ([groupID isEqualToString:preGroupID]) {
                [currentArr addObject:currentDict];
            }else{
                // 如果不相同,说明 有新的一组,那么创建一个模型数组,并添加到组数组_groupArr
                currentArr = [NSMutableArray array];
                [currentArr addObject:currentDict];
                [_groupArr addObject:currentArr];
            }
        }
    }
    MMLog(@"_groupArr  = %@",_groupArr);
    return _groupArr;

}

@end
