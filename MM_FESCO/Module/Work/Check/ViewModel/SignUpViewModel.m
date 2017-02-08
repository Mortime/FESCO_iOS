//
//  SignUpViewModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "SignUpViewModel.h"
#import "CheckListModel.h"
#import "FillListModel.h"

@implementation SignUpViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性
        
        _checkListArray = [NSMutableArray array];
        _fillListArray = [NSMutableArray array];
        
        _checkIndex = 1;
        _fillIndex = 1;

        
        
    }
    return self;
}
// 加载数据
- (void)networkRequestRefresh {
    
    _checkIndex = 1;
    _fillIndex = 1;
    NSInteger index = 0;
    
    if (_recodeType == RecodeTypeCheck) {
        
        index = _checkIndex;
        
        [NetworkEntity postSignUpListWithPageNum:index pageSize:10 success:^(id responseObject) {
            
            MMLog(@"signList ====== responseObject====%@",responseObject);
            if (responseObject == nil) {
                return ;
            }
            
            [_checkListArray removeAllObjects];
            NSArray *checkArray = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic in checkArray) {
                
                CheckListModel *checkModel = [CheckListModel yy_modelWithDictionary:dic];
                [_checkListArray addObject:checkModel];
            }
            
            [self successRefreshBlock];

            
            
        } failure:^(NSError *failure) {
            
            MMLog(@"signList ====== failure=========%@",failure);
            
        }];

    }
    if (_recodeType == RecodeTypeFill) {
        index = _fillIndex;
        
        [NetworkEntity postFillListWithSuccess:^(id responseObject) {
            
            MMLog(@"fillList ====== responseObject======%@",responseObject);
            
            
            if (responseObject == nil) {
                return ;
            }
            
            [_fillListArray removeAllObjects];
            NSArray *fillArray = [responseObject objectForKey:@"list"];
            
            for (NSDictionary *dic in fillArray) {
                
                FillListModel *fillModel = [FillListModel yy_modelWithDictionary:dic];
                [_fillListArray addObject:fillModel];
            }
            
            [self successRefreshBlock];

        } failure:^(NSError *failure) {
            
            MMLog(@"fillList ====== failure=======%@",failure);
        }];
        
        
    }
    
    
}
// 加载更多数据
- (void)networkRequestLoadMore{
    
    NSInteger index = 0;
    
    
    if (_recodeType == RecodeTypeCheck) {
        index = ++_checkIndex;
        
        [NetworkEntity postSignUpListWithPageNum:index pageSize:10 success:^(id responseObject) {
            
//            MMLog(@"signList ====== responseObject%@",responseObject);
            
            if ([[responseObject objectForKey:@"list"] count] == 0) {
                [self successLoadMoreBlockAndNoData];
            }
            
            
            NSArray *array = [responseObject objectForKey:@"list"];
            for (NSDictionary *dic in array) {
                CheckListModel *listModel = [CheckListModel yy_modelWithDictionary:dic];
                [_checkListArray addObject:listModel];
            }
            
        } failure:^(NSError *failure) {
            
            MMLog(@"signList ====== failure%@",failure);
            
        }];

    }
    if (_recodeType == RecodeTypeFill) {
        index = ++_fillIndex;
    }
    
    
    
}

@end
