//
//  SignUpViewModel.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "MMBaseViewModel.h"

@interface SignUpViewModel : MMBaseViewModel


@property (nonatomic, assign) RecodeType recodeType;

@property (nonatomic, strong) NSMutableArray *checkListArray;

@property (nonatomic, strong) NSMutableArray *fillListArray;

@property (nonatomic, assign) NSInteger checkIndex;
@property (nonatomic, assign) NSInteger fillIndex;

@end
