//
//  BuffetDataTool.m
//  MM_FESCO
//
//  Created by Mortimey on 2017/3/29.
//  Copyright © 2017年 Mortimey. All rights reserved.
//

#import "BuffetDataTool.h"
#import "PinYinForObjc.h"


@interface BuffetDataTool ()

@property (nonatomic, strong) NSMutableArray *nationArray1;
@property (nonatomic, strong) NSMutableArray *nationArray2;
@property (nonatomic, strong) NSMutableArray *nationArray3;
@property (nonatomic, strong) NSMutableArray *nationArray4;
@property (nonatomic, strong) NSMutableArray *nationArray5;
@property (nonatomic, strong) NSMutableArray *nationArray6;
@property (nonatomic, strong) NSMutableArray *nationArray7;
@property (nonatomic, strong) NSMutableArray *nationArray8;
@property (nonatomic, strong) NSMutableArray *nationArray9;
@property (nonatomic, strong) NSMutableArray *nationArray10;
@property (nonatomic, strong) NSMutableArray *nationArray11;
@property (nonatomic, strong) NSMutableArray *nationArray12;
@property (nonatomic, strong) NSMutableArray *nationArray13;
@property (nonatomic, strong) NSMutableArray *nationArray14;
@property (nonatomic, strong) NSMutableArray *nationArray15;
@property (nonatomic, strong) NSMutableArray *nationArray16;
@property (nonatomic, strong) NSMutableArray *nationArray17;
@property (nonatomic, strong) NSMutableArray *nationArray18;
@property (nonatomic, strong) NSMutableArray *nationArray19;
@property (nonatomic, strong) NSMutableArray *nationArray20;
@property (nonatomic, strong) NSMutableArray *nationArray21;
@property (nonatomic, strong) NSMutableArray *nationArray22;
@property (nonatomic, strong) NSMutableArray *nationArray23;
@property (nonatomic, strong) NSMutableArray *nationArray24;
@property (nonatomic, strong) NSMutableArray *nationArray25;
@property (nonatomic, strong) NSMutableArray *nationArray26;

@end




@implementation BuffetDataTool
- (instancetype)init{
    self.nationArray1 = [NSMutableArray array];
    self.nationArray2 = [NSMutableArray array];
    self.nationArray3 = [NSMutableArray array];
    self.nationArray4  = [NSMutableArray array];
    self.nationArray5  = [NSMutableArray array];
    self.nationArray6  = [NSMutableArray array];
    self.nationArray7  = [NSMutableArray array];
    self.nationArray8  = [NSMutableArray array];
    self.nationArray9  = [NSMutableArray array];
    self.nationArray10 = [NSMutableArray array];
    self.nationArray11 = [NSMutableArray array];
    self.nationArray12 = [NSMutableArray array];
    self.nationArray13 = [NSMutableArray array];
    self.nationArray14 = [NSMutableArray array];
    self.nationArray15 = [NSMutableArray array];
    self.nationArray16 = [NSMutableArray array];
    self.nationArray17 = [NSMutableArray array];
    self.nationArray18 = [NSMutableArray array];
    self.nationArray19 = [NSMutableArray array];
    self.nationArray20  = [NSMutableArray array];
    self.nationArray21  = [NSMutableArray array];
    self.nationArray22  = [NSMutableArray array];
    self.nationArray23  = [NSMutableArray array];
    self.nationArray24 = [NSMutableArray array];
    self.nationArray25 = [NSMutableArray array];
    self.nationArray26 = [NSMutableArray array];

    
    return self;
}
// 完成民族plist文件
- (void)buffetDataNationPlist{
    [NetworkEntity postNationerAndCountryWithType:@"nation" Success:^(id responseObject) {
        MMLog(@"x ============%@",responseObject);
        if (responseObject) {
            NSDictionary *dataArray = [responseObject objectForKey:@"dictInfo"];
            NSArray *keyArray = [dataArray allKeys];
            
            for (int i=0;i < keyArray.count ; i++) {
                NSString *dicStr = [dataArray objectForKey:[NSString stringWithFormat:@"%d",i+1]];
                // 汉字转换为拼音,然后取首字母
                NSLog(@"==========dicStr === %@",dicStr);
                NSString *headerPin =  [PinYinForObjc chineseConvertToPinYinHead:dicStr];
                NSString *header =    [headerPin substringToIndex:1];
                NSLog(@"==========header === %@",header);
                [self headerWithPin:header objectDic:dicStr subNumber:i];
                
                
            }
            
            //这里使用的是位于工程自身的plist（手动新建的那一个）
            NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"nation"ofType:@"plist"];
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
            [self soreHeaerGroupWithDic:dataDic];
            [dataDic writeToFile:plistPath atomically:YES];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReUI" object:self];
        }
        
        
    } failure:^(NSError *failure) {
        MMLog(@"NationerAndCountry ========= responseObject ============%@",failure);
    }];
}

// 完成国家plist文件
- (void)buffetDataCountPlist{
    [NetworkEntity postNationerAndCountryWithType:@"country" Success:^(id responseObject) {
        MMLog(@"NationerAndCountry ========= responseObject ============%@",responseObject);
        if (responseObject) {
            NSDictionary *dataArray = [responseObject objectForKey:@"dictInfo"];
            NSArray *keyArray = [dataArray allKeys];
            
            for (int i=0;i < keyArray.count ; i++) {
                NSString *dicStr = [dataArray objectForKey:[NSString stringWithFormat:@"%d",i+1]];
                // 汉字转换为拼音,然后取首字母
                NSLog(@"==========dicStr === %@",dicStr);
                NSString *headerPin =  [PinYinForObjc chineseConvertToPinYinHead:dicStr];
                NSString *header =    [headerPin substringToIndex:1];
                NSLog(@"==========header === %@",header);
                [self headerWithPin:header objectDic:dicStr subNumber:i];
                
                
            }
            
            //这里使用的是位于工程自身的plist（手动新建的那一个）
            NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"nation"ofType:@"plist"];
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
            [self soreHeaerGroupWithDic:dataDic];
            [dataDic writeToFile:plistPath atomically:YES];
        }
        
        
    } failure:^(NSError *failure) {
        MMLog(@"NationerAndCountry ========= responseObject ============%@",failure);
    }];

}


#pragma mark --- Publick
- (void)headerWithPin:(NSString *)header objectDic:(NSString *)dicStr subNumber:(int)i {
    if ([header isEqualToString:@"a"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray1  addObject:dic];
    }
    if ([header isEqualToString:@"b"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray2  addObject:dic];
    }
    if ([header isEqualToString:@"c"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray3   addObject:dic];
    }
    if ([header isEqualToString:@"d"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray4   addObject:dic];
    }
    if ([header isEqualToString:@"e"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray5  addObject:dic];
    }
    if ([header isEqualToString:@"f"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray6  addObject:dic];
    }
    if ([header isEqualToString:@"g"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray7  addObject:dic];
    }
    if ([header isEqualToString:@"h"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray8   addObject:dic];
    }
    if ([header isEqualToString:@"i"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray9   addObject:dic];
    }
    if ([header isEqualToString:@"j"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray10  addObject:dic];
    }
    if ([header isEqualToString:@"k"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray11  addObject:dic];
    }
    if ([header isEqualToString:@"l"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray12  addObject:dic];
    }
    if ([header isEqualToString:@"m"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray13  addObject:dic];
    }
    if ([header isEqualToString:@"n"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray4  addObject:dic];
    }
    if ([header isEqualToString:@"o"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray15  addObject:dic];
    }
    if ([header isEqualToString:@"p"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray16  addObject:dic];
    }
    if ([header isEqualToString:@"q"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray17  addObject:dic];
    }
    if ([header isEqualToString:@"r"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray18  addObject:dic];
    }
    if ([header isEqualToString:@"s"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray19  addObject:dic];
    }
    if ([header isEqualToString:@"t"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray20  addObject:dic];
    }
    if ([header isEqualToString:@"u"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray21  addObject:dic];
    }
    if ([header isEqualToString:@"v"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray22 addObject:dic];
    }
    if ([header isEqualToString:@"w"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray23  addObject:dic];
    }
    if ([header isEqualToString:@"x"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray24  addObject:dic];
    }
    if ([header isEqualToString:@"y"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray25  addObject:dic];
    }
    if ([header isEqualToString:@"z"]) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:dicStr,[NSString stringWithFormat:@"%d",i], nil];
        [_nationArray26  addObject:dic];
    }
}
- (void)soreHeaerGroupWithDic:(NSMutableDictionary *)dataDic{
    dataDic[@"A"] = _nationArray1;
    dataDic[@"B"] = _nationArray2 ;
    dataDic[@"C"] = _nationArray3 ;
    dataDic[@"D"] = _nationArray4 ;
    dataDic[@"E"] = _nationArray5 ;
    dataDic[@"F"] = _nationArray6;
    dataDic[@"G"] = _nationArray7;
    dataDic[@"H"] = _nationArray8;
    dataDic[@"I"] = _nationArray9;
    dataDic[@"J"] = _nationArray10;
    dataDic[@"K"] = _nationArray11;
    dataDic[@"L"] = _nationArray12;
    dataDic[@"M"] = _nationArray13;
    dataDic[@"N"] = _nationArray14;
    dataDic[@"O"] = _nationArray15;
    dataDic[@"P"] = _nationArray16;
    dataDic[@"Q"] = _nationArray17;
    dataDic[@"R"] = _nationArray18;
    dataDic[@"S"] = _nationArray19;
    dataDic[@"T"] = _nationArray20;
    dataDic[@"U"] = _nationArray21;
    dataDic[@"V"] = _nationArray22;
    dataDic[@"W"] = _nationArray23;
    dataDic[@"X"] = _nationArray24;
    dataDic[@"Y"] = _nationArray25;
    dataDic[@"Z"] = _nationArray26;

}
@end
