//
//  BaseTableController.m
//  Principal
//
//  Created by Mortimey on 16/8/01.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <Foundation/Foundation.h>

@interface NSString (Helper)

/**
 *  判断是否为正确的邮箱
 *
 *  @return 返回YES为正确的邮箱，NO为不是邮箱
 */
- (BOOL)isValidateEmail;

/**
 *  判断是否为正确的手机号
 *
 *  @return 返回YES为手机号，NO为不是手机号
 */
- (BOOL)checkTel;

/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  返回沙盒中的文件路径
 *
 *  @return 返回当前字符串对应在沙盒中的完整文件路径
 */
+ (NSString *)stringWithDocumentsPath:(NSString *)path;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;

/**
 *  一串字符在固定宽度下，正常显示所需要的高度
 *
 *  @param string：文本内容
 *  @param width：每一行的宽度
 *  @param 字体大小
 */
+ (CGFloat)autoHeightWithString:(NSString *)string
                        Width:(CGFloat)width
                         Font:(UIFont *)font;

/**
 *  一串字符在一行中正常显示所需要的宽度
 *
 *  @param string：文本内容
 *  @param 字体大小
 */
+ (CGFloat)autoWidthWithString:(NSString *)string
                         Font:(UIFont *)font;

/**
 *  一个字典按key值升序排序,然后根据keyValuekeyVale...keyValuekeyVale拼成字符串,并返回字符串 sign
 *
 *  @param Dictionary：字典
 *
 */
+ (NSString *)sortKeyWith:(NSDictionary *)dic;



/**
 *  将json格式转换成json字符串   @"'methodname':'emp/loadEmpInfo.json', 'tonnnn':'iiiiiiiii' }"
 *
 *  @param Dictionary：字典
 *
 */
+ (NSString *)jsonToJsonStingWith:(NSDictionary *)dic;


/**
 *  将json格式转换成json字符串   @"'methodname':'emp/loadEmpInfo.json', 'tonnnn':'iiiiiiiii' }"  如果遇到json 数字则    @"'methodname':'emp/loadEmpInfo.json', 'tonnnn':[iiiiiiiii] }"
 *
 *  @param Dictionary：字典
 *
 */
+ (NSString *)jsonToJsonStringArrayWith:(NSDictionary *)dic;



/**
 *  将  title  content  组合成  tittel(123...456)形式
 *
 *  @param  title 
 
 *  @param  content
 *
 */

+ (NSString *)stringWithTitle:(NSString *)title content:(NSInteger)content;
/**
 *  将json格式转换成json字符串   @"'methodname':'emp/loadEmpInfo.json', 'tonnnn':'iiiiiiiii' }"
 *
 *  @param Dictionary：字典
 *
 */
+ (NSString *)jsonToJsonArrayWith:(NSDictionary *)dic;

@end
