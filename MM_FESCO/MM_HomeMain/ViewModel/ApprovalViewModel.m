
//
//  OverTimeViewModel.m
//  MM_FESCO
//
//  Created by Mortimey on 16/9/13.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "ApprovalViewModel.h"
#import "OverTimeListModel.h"
#import "SignUpApprovalListModel.h"
#import "LeaveApprovalListModel.h"

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
    
    // 加班审批列表
    if ( _approvalType == overTimeApprovalType) {
        
        
        [NetworkEntity postGetOverTimeApproalListSuccess:^(id responseObject) {
            
//            MMLog(@"OverTimeList ====== responseObject====%@",responseObject);
            [_overTimeListArray removeAllObjects];
            if (! [[responseObject objectForKey:@"list"] count]) {
                return ;
            }
            
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
    
    
    // 签到审批列表
    if (_approvalType == signUpApprovalType) {
        [NetworkEntity postSignUpApproalListSuccess:^(id responseObject) {
            
            MMLog(@"SignUpApproalList ====== responseObject====%@",responseObject);
            
            [_signUpListArray removeAllObjects];
            if (! [[responseObject objectForKey:@"list"] count]) {
                return ;
            }
            
            for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                SignUpApprovalListModel *model = [SignUpApprovalListModel yy_modelWithDictionary:dic];
                [_signUpListArray addObject:model];
                
            }
            [self successRefreshBlock];
            
        } failure:^(NSError *failure) {
            
            MMLog(@"SignUpApproalList ====== failure=========%@",failure);
            
        }];
        
        [self successRefreshBlock];
    }
    // 请假审批列表
    if (_approvalType == leaveApprovalType) {
        [NetworkEntity postLeaveApproalListSuccess:^(id responseObject) {
            
//             MMLog(@"LeaveApproalList ====== responseObject====%@",responseObject);
            
            [_LeaveListArray removeAllObjects];
            if (! [[responseObject objectForKey:@"list"] count]) {
                return ;
            }
            
            for (NSDictionary *dic in [responseObject objectForKey:@"list"]) {
                LeaveApprovalListModel *model = [LeaveApprovalListModel yy_modelWithDictionary:dic];
                [_LeaveListArray addObject:model];
                
            }
            [self successRefreshBlock];

        } failure:^(NSError *failure) {
            
            MMLog(@"LeaveApproalList ====== failure=========%@",failure);
        }];
        
    }
    
    
}

@end
