//
//  BaseTableController.m
//  Principal
//
//  Created by Mortimey on 16/8/01.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NSString+Helper.h"

#import "NSString+MD5.h"



@implementation NSString (Helper)

#pragma mark 是否空字符串
- (BOOL)isEmptyString {
    if (![self isKindOfClass:[NSString class]]) {
        return TRUE;
    }else if (self==nil) {
        return TRUE;
    }else if(!self) {
        // null object
        return TRUE;
    } else if(self==NULL) {
        // null object
        return TRUE;
    } else if([self isEqualToString:@"NULL"]) {
        // null object
        return TRUE;
    }else if([self isEqualToString:@"(null)"]){
        
        return TRUE;
    }else{
        //  使用whitespaceAndNewlineCharacterSet删除周围的空白字符串
        //  然后在判断首位字符串是否为空
        NSString *trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return TRUE;
        } else {
            // is neither empty nor null
            return FALSE;
        }
    }
}

#pragma mark 判断是否是手机号
- (BOOL)checkTel {
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

#pragma mark 判断是否是邮箱
- (BOOL)isValidateEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

#pragma mark 清空字符串中的空白字符
- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 返回沙盒中的文件路径
+ (NSString *)stringWithDocumentsPath:(NSString *)path {
    NSString *file = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [file stringByAppendingPathComponent:path];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 一串字符在固定宽度下，正常显示所需要的高度 method
+ (CGFloat)autoHeightWithString:(NSString *)string Width:(CGFloat)width Font:(UIFont *)font {
    
    //大小
    CGSize boundRectSize = CGSizeMake(width, MAXFLOAT);
    //绘制属性（字典）
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    //调用方法,得到高度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.height;
    return newFloat;
}

#pragma mark 一串字符在一行中正常显示所需要的宽度 method
+ (CGFloat)autoWidthWithString:(NSString *)string Font:(UIFont *)font {
    
    //大小
    CGSize boundRectSize = CGSizeMake(MAXFLOAT, font.lineHeight);
    //绘制属性（字典）
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    //调用方法,得到高度
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.width;
    return newFloat;
}
#pragma mark ---- 个字典按key值升序排序,然后根据keyValuekeyVale...keyValuekeyVale拼成字符串,并返回字符串
+ (NSString *)sortKeyWith:(NSDictionary *)dic{
    /*
     enum{
     NSCaseInsensitiveSearch = 1,//不区分大小写比较
     NSLiteralSearch = 2,//区分大小写比较
     NSBackwardsSearch = 4,//从字符串末尾开始搜索
     NSAnchoredSearch = 8,//搜索限制范围的字符串
     NSNumbericSearch = 64//按照字符串里的数字为依据，算出顺序。例如 Foo2.txt < Foo7.txt < Foo25.txt
     //以下定义高于 mac os 10.5 或者高于 iphone 2.0 可用
     ,
     NSDiacriticInsensitiveSearch = 128,//忽略 "-" 符号的比较
     NSWidthInsensitiveSearch = 256,//忽略字符串的长度，比较出结果
     NSForcedOrderingSearch = 512//忽略不区分大小写比较的选项，并强制返回 NSOrderedAscending 或者 NSOrderedDescending
     //以下定义高于 iphone 3.2 可用
     ,
     NSRegularExpressionSearch = 1024//只能应用于 rangeOfString:..., stringByReplacingOccurrencesOfString:...和 replaceOccurrencesOfString:... 方法。使用通用兼容的比较方法，如果设置此项，可以去掉 NSCaseInsensitiveSearch 和 NSAnchoredSearch
     }
     */
    
    
    // NSString *secret = [NSString stringWithFormat:@"%@%@",@"secret",@"appsecret"];
    NSMutableDictionary *mutableDic = dic.mutableCopy;
    [mutableDic setValue:@"appsecret" forKey:@"secret"];
    NSArray *allKey = [mutableDic allKeys];
    MMLog(@"allKey  排序前 = %@",allKey);
    // 对key进行排序
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
    NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray = [allKey sortedArrayUsingComparator:sort];
    MMLog(@"resultArray2  排序后 = %@",resultArray);
    // 根据keyValuekeyVale...keyValuekeyVale拼成字符串
    NSString *resultStr = @"";
    for (NSString *keyStr in resultArray) {
        
        NSString *valueStr = @"";
        if ([keyStr isEqualToString:@"methodname"] || [keyStr isEqualToString:@"secret"]) {
            valueStr = [mutableDic objectForKey:keyStr];
        }
        
        resultStr = [NSString stringWithFormat:@"%@%@%@",resultStr,keyStr,valueStr];
    }
    MMLog(@" sort =======   =======    resultStr ========%@",resultStr);
    NSString *md5Str = [[resultStr MD5Digest] uppercaseString];
    MMLog(@" md5Str =======   =======    md5Str ========%@",md5Str);
    return md5Str;
}
#pragma mark ----- 将json格式转换成json字符串   @"'methodname':'emp/loadEmpInfo.json', 'tonnnn':'iiiiiiiii' }"
+ (NSString *)jsonToJsonStingWith:(NSDictionary *)dic{
    
    NSString *resultStr = @"";
    NSArray *allKey = [dic allKeys];
    for (NSString *key in allKey) {
        NSString *valueStr = [dic objectForKey:key];
        NSString *mignhtStr = [NSString stringWithFormat:@"'%@':'%@'",key,valueStr];
        resultStr = [NSString stringWithFormat:@"%@,%@",resultStr,mignhtStr];
    }
    
//    MMLog(@"00000000000000 ===========  re %@",resultStr);
    
    resultStr = [resultStr substringFromIndex:1];//截取掉下标0之后的字符串
    resultStr = [NSString stringWithFormat:@"{%@}",resultStr];
    return resultStr;
}

+ (NSString *)jsonToJsonStringArrayWith:(NSDictionary *)dic{
    NSString *resultStr = @"";
    NSArray *allKey = [dic allKeys];
    for (NSString *key in allKey) {
        NSString *valueStr = [dic objectForKey:key];
        
        NSString *mignhtStr = @"";
        if ([key isEqualToString:@"apply"] || [key isEqualToString:@"details"]) {
            mignhtStr = [NSString stringWithFormat:@"'%@':%@",key,valueStr];
        }else{
            mignhtStr = [NSString stringWithFormat:@"'%@':'%@'",key,valueStr];
        }
        
        resultStr = [NSString stringWithFormat:@"%@,%@",resultStr,mignhtStr];
    }
    
    //    MMLog(@"00000000000000 ===========  re %@",resultStr);
    
    resultStr = [resultStr substringFromIndex:1];//截取掉下标0之后的字符串
    resultStr = [NSString stringWithFormat:@"{%@}",resultStr];
    return resultStr;

}
#pragma mark ----  组合成  tittel(123...456)形式
+ (NSString *)stringWithTitle:(NSString *)title content:(NSInteger)content{
    
    NSString *mightStr = [NSString stringWithFormat:@"%lu",content];
    
    NSString *oneStr = [mightStr substringToIndex:4];
    
    NSInteger  length = mightStr.length;
    NSString *twoStr = [mightStr substringFromIndex:length - 4];
    
    return [NSString stringWithFormat:@"%@(%@...%@)",title,oneStr,twoStr];
//    return [NSString stringWithFormat:@"%@%@",title,mightStr];
}
+ (NSString *)jsonToJsonArrayWith:(NSDictionary *)dic{
    NSString *resultStr = @"";
    NSArray *allKey = [dic allKeys];
    for (NSString *key in allKey) {
        NSString *valueStr = [dic objectForKey:key];
        NSString *mignhtStr = [NSString stringWithFormat:@"'%@':'%@'",key,valueStr];
        resultStr = [NSString stringWithFormat:@"%@,%@",resultStr,mignhtStr];
    }
    
    //    MMLog(@"00000000000000 ===========  re %@",resultStr);
    
    resultStr = [resultStr substringFromIndex:1];//截取掉下标0之后的字符串
    resultStr = [NSString stringWithFormat:@"{%@}",resultStr];
    return resultStr;

}
//  根据名称返回一个图片名称
+ (NSString *)backPicNameWith:(NSString *)title{
    NSString *str  = @"";
    if ([title isEqualToString:@"长途"]) {
        str = @"NewReimburseController_ChangTu";
    }
    if ([title isEqualToString:@"交通"]) {
        str = @"NewReimburseController_JiaoTong";
        
    }
    if ([title isEqualToString:@"餐饮"]) {
        str = @"NewReimburseController_CanYin";
        
    }
    if ([title isEqualToString:@"住宿"]) {
        str = @"NewReimburseController_Hotel";
        
    }
    if ([title isEqualToString:@"通讯"]) {
        str = @"NewReimburseController_TongXun";
        
    }
    if ([title isEqualToString:@"补助"]) {
        str = @"NewReimburseController_BuZhu";
        
    }
    if ([title isEqualToString:@"其他"]) {
        str = @"NewReimburseController_Other";
        
    }
    if ([title isEqualToString:@"日常报销单"]) {
        str = @"ReimburseApproal_RiChang";
        
    }
    if ([title isEqualToString:@"差旅报销单"]) {
        str = @"ReimburseApproal_ChuChai";
        
    }if ([title isEqualToString:@"付款申请单"]) {
        str = @"ReimburseApproal_FuKuang";
        
    }
    return str;
}


+(BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data{
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:kHttpsCerKey
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
//  根据月份返回英文状态下的月份
+ (NSString *)enlishMonthWithNumberMon:(NSString *)numberMon{
    NSInteger result = [numberMon integerValue];
    switch (result) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            
        default:
            break;
    }
    return nil;
}
// 服务器返回 "null", 判断是否为空
+ (BOOL)isNUllWithText:(NSString *)text{
    if (text == nil ||[text  isEqual:[NSNull null]]) {
        return YES;
    }else{
        return NO;
    }
}
@end
