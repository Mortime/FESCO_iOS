//
//  MMDataCodeTool.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/1/10.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "MMDataCodeTool.h"

@implementation MMDataCodeTool
/**
 *  将某个对象写入文件时会调用
 *  在这个方法中说清楚哪些属性需要存储
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.array forKey:@"dataKey"];

}

/**
 *  从文件中解析对象时会调用
 *  在这个方法中说清楚哪些属性需要存储
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        // 读取文件的内容
        self.array = [decoder decodeObjectForKey:@"dataKey"];
    }
    return self;
}
@end
