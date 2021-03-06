//
//  NetworkDataTool.m
//  MM_FESCO
//
//  Created by Mortimey on 2016/12/22.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NetworkDataTool.h"

@implementation NetworkDataTool

+ (NSString *)MM_initWithModel:(NSArray *)noBookArray{
    // 无论新增还是编辑,都有能添加未制单消费
    NSString *noBookDetailStr =  @"";
    //  未制单消费添加
    if (noBookArray.count) {
        // 编辑时从服务器获取的消费记录
        for (NOBookChooseModel *model in noBookArray) {
            // 可能为空的字段
            // 1. 消费描述
            NSString *spendMemo = @"";
            if (model.detailMemo) {
                spendMemo = model.detailMemo;
            }
            // 2. 开始时间
            NSString *spendStart = @"";
            if (model.spendBegin) {
                spendStart = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:model.spendBegin];
            }
            
            // 3. 结束时间
            NSString *spendEnd = @"";
            if (model.spendEnd) {
                spendEnd = [NSDate dateFromSSWithDateType:@"yyyy-MM-dd" ss:model.spendEnd];
            }
            // 4. 消费城市
            NSString *spendCity = @"";
            if (model.cityName) {
                spendCity = model.cityName;
            }
            
            // 5. 图片ID
            NSString *picID = @"";
            NSString *resultPicId = @"";
            MMLog(@"%@",model.picArray);
            for (NSDictionary *dic in model.picArray) {
                
                if (![[dic objectForKey:@"id"]  isKindOfClass:[NSNull class]]) {
                    picID = [NSString stringWithFormat:@"%@,%lu",picID,[[dic objectForKey:@"id"] integerValue]];
                }
                
            }
            if (![picID isEqualToString:@""]) {
                resultPicId = [picID substringFromIndex:1];
            }else{
                resultPicId = @"";
            }
            
            NSDictionary *detailDic = @{@"spend_Type":[NSString stringWithFormat:@"%lu",model.spendType],
                                        @"money_Amount":[NSString stringWithFormat:@"%.2f",model.moneyAmount],
                                        @"bill_Num":[NSString stringWithFormat:@"%lu",model.billNum],
                                        @"pic_Ids":resultPicId,
                                        @"detail_Memo":spendMemo,
                                        @"spend_Begin":spendStart,
                                        @"spend_End":spendEnd,
                                        @"spend_City":spendCity,
                                        @"detail_Id":@"",
                                        @"detail_Id_Before_Imported":[NSString stringWithFormat:@"%lu",model.detailId]
                                        
                                        };
            
            NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
            noBookDetailStr = [NSString stringWithFormat:@"%@,%@",noBookDetailStr,mightStr];
        }
        
    }
    
    // 去掉开始时的,
    noBookDetailStr = [noBookDetailStr substringFromIndex:1];//截取掉下标0之后的字符串
    return noBookDetailStr;
}


+ (NSString *)MM_initWithEditMessageModelArray:(NSArray *)networkModelArray{
    
     NSString *detailJsonArray = @"";
    // 编辑时从服务器获取的消费记录
    for (EditMessageModel *model in networkModelArray) {
        // 可能为空的字段
        // 1. 消费描述
        NSString *spendMemo = @"";
        if (model.detailMemo) {
            spendMemo = model.detailMemo;
        }
        // 2. 开始时间
        NSString *spendStart = @"";
        if (model.spendBegin) {
            spendStart = model.spendBegin;
        }
        
        // 3. 结束时间
        NSString *spendEnd = @"";
        if (model.spendEnd) {
            spendEnd = model.spendEnd;
        }
        // 4. 消费城市
        NSString *spendCity = @"";
        if (model.cityName) {
            spendCity = model.cityName;
        }
        
        // 5. 图片ID
        NSString *picID = @"";
        NSString *resultPicId = @"";
        MMLog(@"%@",model.picArray);
        for (NSDictionary *dic in model.picArray) {
            
            if (![[dic objectForKey:@"id"]  isKindOfClass:[NSNull class]]) {
                picID = [NSString stringWithFormat:@"%@,%lu",picID,[[dic objectForKey:@"id"] integerValue]];
            }
            
        }
        if (![picID isEqualToString:@""]) {
            resultPicId = [picID substringFromIndex:1];
        }else{
            resultPicId = @"";
        }
        
        
        // 当编辑消费记录时,如果消费记录已经存在要传 detail_Id, 如果是新添加的不用传 detail_Id.
        
        MMLog(@"%@=%@=%@=%@=%@=%@=%@=%@=%@",[NSString stringWithFormat:@"%lu",model.spendId],[NSString stringWithFormat:@"%.2f",model.moneyAmount],[NSString stringWithFormat:@"%lu",model.billNum],resultPicId,spendMemo,spendStart,spendEnd,spendCity,[NSString stringWithFormat:@"%lu",model.detailId]);
        
        NSDictionary *detailDic = @{@"spend_Type":[NSString stringWithFormat:@"%lu",model.spendId],
                                    @"money_Amount":[NSString stringWithFormat:@"%.2f",model.moneyAmount],
                                    @"bill_Num":[NSString stringWithFormat:@"%lu",model.billNum],
                                    @"pic_Ids":resultPicId,
                                    @"detail_Memo":spendMemo,
                                    @"spend_Begin":spendStart,
                                    @"spend_End":spendEnd,
                                    @"spend_City":spendCity,
                                    @"detail_Id":[NSString stringWithFormat:@"%lu",model.detailId]
                                    
                                    };
        
        NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
        detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
    }
    // 去掉开始时的,
    NSString *resultStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
    return resultStr;
}

+ (NSString *)MM_initWithNewPurchaseRecordModelArray:(NSArray *)newPurchaseRecordModelArray{
    
    NSString *newStr = @"";
    //  本地数据库的消费记录为空
    for (NSDictionary *dic in newPurchaseRecordModelArray) {
        // 可能为空的字段
        /*
         
         @"moneyAmount":_moneyNumber,
         @"spendBegin":_startTime,
         @"spendEnd":_endTime,
         @"billNum":_billNumber,
         @"picUrl":_picUrl,
         @"picDesc":_picStr,
         @"detailMemo":_memo,
         @"spendCity":_cityName
         
         */
        
        
        
        // 1. 消费描述
        NSString *spendMemo = @"";
        if ([dic objectForKey:@"detailMemo"]) {
            spendMemo = [dic objectForKey:@"detailMemo"];
        }
        // 2. 开始时间
        NSString *spendStart = @"";
        if ([dic objectForKey:@"spendBegin"]) {
          spendStart = [dic objectForKey:@"spendBegin"];
        }
        
        // 3. 结束时间
        NSString *spendEnd = @"";
        if ([dic objectForKey:@"spendEnd"]) {
         spendEnd = [dic objectForKey:@"spendEnd"];
        }
        // 4. 消费城市
        NSString *spendCity = @"";
        if ([dic objectForKey:@"spendCity"]) {
        spendCity = [dic objectForKey:@"spendCity"];
        }
        
        NSDictionary *detailDic = @{@"spend_Type":[dic objectForKey:@"ID"],
                                    @"money_Amount":[dic objectForKey:@"moneyAmount"],
                                    @"bill_Num":[dic objectForKey:@"billNum"],
                                    @"pic_Ids":[dic objectForKey:@"picUrl"],
                                    @"detail_Memo":spendMemo,
                                    @"spend_Begin":spendStart,
                                    @"spend_End":spendEnd,
                                    @"spend_City":spendCity
                                    
                                    };
        
        NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
        newStr = [NSString stringWithFormat:@"%@,%@",newStr,mightStr];
    }
    // 去掉开始时的,
    newStr = [newStr substringFromIndex:1];//截取掉下标0之后的字符串
    return newStr;
}
@end
