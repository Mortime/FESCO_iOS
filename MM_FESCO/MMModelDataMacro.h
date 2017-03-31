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

#define t_userIconUrl  @"t_userIconUrl" // 用户头像数据库表


// 通知
#define t_purchaseRecord   @"t_purchaseRecord" // 添加消费记录

#define kTonkenChangeNotifition  @"TonkenChangeNotifition" // tonkey改变的通知

#define kDateChangeNotifition @"DateChangeNotifition"  // 日期改变的通知

#define kGetReimburseRecordNotifition  @"GetReimburseRecordNotifition"  // 加载消费记录的通知

#define  kAddNOBookNotifition @"AddNOBookNotifition"  // 添加未制单消费通知

#define kPicUpSuccessNotifition  @"kPicUpSuccessNotifition"  // 图片上传成功通知


#define kTimeTypeChangeNotifition @"kTimeTypeChangeNotifition" // 日期改变的通知;


// Key标识符
#define kSingNumber  @"SingNumber"  //  存储签到次数
#define kSignDate    @"SignDate"    // 记录签到日期,用于次日签到数据清0
#define kSignStatisticDate @"SignStatisticDate"   // 签到统计日期记录
#define kUsreIcon     @"UsreIcon" // 保存用户头像
#define kReimburseRecordList  @"ReimburseRecordList"  // 本地保存消费记录
#define kNetworkRecordList @"NetworkRecordList"       // 网络消费记录
#define kNOBookRecordList @"NOBookRecordList"         // 未制单消费记录
#define kGroupName @"GroupName"     // 本地保存组名
#define kGroupID @"GroupID"     // 本地保存组名
#define kPicUpSuccessID  @"PicUpSuccessID"  // 图片上传成功存储的ID
#define kHttpsCerKey  @"zrfesco"
#define kEmpIdKey @"EmpIdKey" // 签到成功后保存empId, 防止一个手机一天内打多次卡
#define kSignUpTime @"SignUpTime" // 签到成功时间
#define KAvtarUrlVersion  @"AvtarUrlVersion" // 保存头像的版本号,用于服务器更新头像








typedef NS_ENUM(NSUInteger,RecodeType){
    
    RecodeTypeCheck,   // 考勤记录
    RecodeTypeFill     // 补签记录
};


typedef NS_ENUM(NSUInteger,ApprovalType){
    
    overTimeApprovalType,   // 加班审批
    signUpApprovalType,     // 签到审批
    leaveApprovalType ,    // 请假审批
    reimburseApprovalType  // 报销 审批
};

typedef NS_ENUM(NSUInteger,popViewType){
    
    moban,   // 弹出模板
    shenpiren     // 弹出审批人
   
};
typedef NS_ENUM(NSUInteger,RePurchaseBookType){
    
    newReimburseBook,   // 新建报销单
    editReimburseBook,    // 编辑报销单
    
    noBookPurchase,         // 未制单消费记录模块在一笔
    NOBookPurchaseEdit,   // 未制单消费记录模块编辑
    
    
    PurchaseNetworkEdit,  // 添加报销单后的网络消费记录编辑
    PurchaseBenDiEdit,  // 添加报销单后的本地消费记录编辑
    PurchaseNOBookEdit,  // 添加报销单后的未制单消费记录编辑
    
    
    
    NOPassEdit     // 审核未通过后消费记录再编辑
    
};

typedef NS_ENUM(NSUInteger,chooseDataType){
    
    nation,   // 民族
    country     // 国家
    
};
typedef NS_ENUM(NSUInteger,upPictureType){
    
    userPhone,   // 照片
    cardPositive,    // 身份证正面
    cardReverse        // 身份证反面
    
    
};



#endif /* MMModelDataMacro_h */
