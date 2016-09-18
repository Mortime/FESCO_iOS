//
//  MMModelDataMacro.h
//  MM_FESCO
//
//  Created by Mortimey on 16/9/6.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#ifndef MMModelDataMacro_h
#define MMModelDataMacro_h


#define t_phoneList   @"t_phoneList"  // 通讯录表数据库表

#define t_applySignup @"t_applySignup"  // 补签申请数据库表

#define kTonkenChangeNotifition  @"TonkenChangeNotifition" // tonkey改变的通知




typedef NS_ENUM(NSUInteger,RecodeType){
    
    RecodeTypeCheck,   // 考勤记录
    RecodeTypeFill     // 补签记录
};


typedef NS_ENUM(NSUInteger,ApprovalType){
    
    overTimeApprovalType,   // 加班审批
    signUpApprovalType,     // 签到审批
    leaveApprovalType     // 请假审批
};



#endif /* MMModelDataMacro_h */
