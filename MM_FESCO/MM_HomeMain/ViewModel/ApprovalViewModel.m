
//
//  OverTimeViewModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ApprovalViewModel.h"
#import "OverTimeListModel.h"

@implementation ApprovalViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性
        
        _overTimeListArray = [NSMutableArray array];
        _signUpListArray = [NSMutableArray array];
        _LeaveListArray = [NSMutableArray array];
        
        
        
        
    }
    return self;
}
// 加载数据
- (void)networkRequestRefresh {
    
    if ( _approvalType == overTimeApprovalType) {
        
        
        [NetworkEntity postGetOverTimeApproalListSuccess:^(id responseObject) {
            
//            MMLog(@"OverTimeList ====== responseObject====%@",responseObject);
            if (! [[responseObject objectForKey:@"list"] count]) {
                return ;
            }
            [_overTimeListArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                OverTimeListModel *model = [OverTimeListModel yy_modelWithDictionary:dic];
                [_overTimeListArray addObject:model];
                
            }
            [self successRefreshBlock];
            

        } failure:^(NSError *failure) {
            MMLog(@"OverTimeList ====== failure=========%@",failure);
        }];
        
        
        
        
//        [NetworkEntity postSignUpListWithPageNum:index pageSize:10 success:^(id responseObject) {
//            
//            MMLog(@"signList ====== responseObject====%@",responseObject);
//            if (responseObject == nil) {
//                return ;
//            }
//            
//            [_checkListArray removeAllObjects];
//            NSArray *checkArray = [responseObject objectForKey:@"list"];
//            
//            for (NSDictionary *dic in checkArray) {
//                
//                CheckListModel *checkModel = [CheckListModel yy_modelWithDictionary:dic];
//                [_checkListArray addObject:checkModel];
//            }
//            
//            [self successRefreshBlock];
//            
//            
//            
//        } failure:^(NSError *failure) {
//            
//            MMLog(@"signList ====== failure=========%@",failure);
//            
//        }];
//        
//    }
//    if (_recodeType == RecodeTypeFill) {
//        index = _fillIndex;
//        
//        [NetworkEntity postFillListWithSuccess:^(id responseObject) {
//            
//            MMLog(@"fillList ====== responseObject======%@",responseObject);
//            
//            
//            if (responseObject == nil) {
//                return ;
//            }
//            
//            [_fillListArray removeAllObjects];
//            NSArray *fillArray = [responseObject objectForKey:@"list"];
//            
//            for (NSDictionary *dic in fillArray) {
//                
//                FillListModel *fillModel = [FillListModel yy_modelWithDictionary:dic];
//                [_fillListArray addObject:fillModel];
//            }
//            
//            [self successRefreshBlock];
//            
//        } failure:^(NSError *failure) {
//            
//            MMLog(@"fillList ====== failure=======%@",failure);
//        }];
//        
//        
    }
    
    
}

@end
