//
//  NetworkEntity.h
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkTool.h"
#import "AFNetworking.h"

@interface NetworkEntity : NSObject

#pragma ================== 注册 登录 =====================
/**
 *  用户注册  获取验证码
 *
 *  @param email （req） 用于接受验证码的邮箱
 */

+ (void)postRegisterCodeNumberWithMail:(NSString *)mail success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *  用户注册  注册
 *
 *  @param email （req） 邮箱
 
 *  @param userName （req） 用户名
 
 *  @param password （req） 密码
 */

+ (void)postRegisterNumberWithMail:(NSString *)mail  userName:(NSString *)userName password:(NSString *)password  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;



+ (void)postHomeMainListWithParamMD5:(NSString *)paramMD5  menthodname:(NSString *)menthodname tokenkeyID:(NSString *)tokenkey secret:(NSString *)secret success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *  用户教练登录 返回信息描述见 获取用户详情
 *
 *  @param photoNumber （req）  手机号
 *  @param password     (req)  密码 MD5加密后
 *  @param deviceId （req）  设备唯一标识
 *  @param deviceType     (req)  设备类型 (iOS : 1 ,android : 0);
 
 */
+ (void)postLoginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password deviceId:(NSString *)deviceId deviceType:(NSString *)deviceType   success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;


/**
 *   HomeMain ======== 加载个人信息
 
 *  @param custid （req）  公司id
 *  @param emptId     (req)  员工id

 */
+ (void)postPersonMessageWithCustId:(NSString *)custid emptId:(NSString *)emptId tokenkeyID:(NSString *)tokenkey   sign:(NSString *)sign  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;



/**
 *   HomeMain ======== 个人信息修改
 
 *  @param emp_Id    (req)  员工id
 
  *  @param emp_Name     (req)  员工姓名
 
  *  @param gender     (req)  员工性别
 
  *  @param mobile     (req)  员工电话
 
 *  @param phone     (req)  员工手机
 
  *  @param weixinid     (req)  员工微信号
 
  *  @param email     (req)  员工邮箱
 
 *  @param address     (req)  员工地址
 
 *  @param zipcode     (req)  员工邮编
 
 emp_Id, emp_Name, gender, mobile, phone, weixinid, email, address, zipcode
 
 */

+ (void)postSubmitPersonMessageWithEmpId:(NSString *)empId empName:(NSString *)empName  gender:(NSString *)gender mobile:(NSString *)mobile phone:(NSString *)phone weixinid:(NSString *)weixinid email:(NSString *)email address:(NSString *)address zipcode:(NSString *)zipcode  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;




/**
 *    加载员工通讯录
 
 *  @param cust_Id （req）  公司id
 
 */
+ (void)postPhoneNumberListWithCustId:(NSString *)custid  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

#pragma ================== 考勤 =====================
/**
 *    签到
 
 *  @param cust_Id （req）  公司id
 
 *  @param emp_Id （req）  员工id
 
 *  @param longitude （req） ,latitude  经纬度  ,  memo (外勤时说明内容)
 
 *  @param type （req）  type  (type=1为签到，2为签退，3为外勤）
 
 */
+ (void)postSignUpTypeWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude type:(NSInteger)type memo:(NSString *)memo  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    考勤记录
 
 *  @param emp_Id （req）  员工id
 
 *  @param pageNum （req） 页码
 
 *  @param pageSize （req）  每页条数
 
 */
+ (void)postSignUpListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;


/**
 *    补签记录
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postFillListWithSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    获取审批人列表
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postApplyPeopleListWithSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    提交审批  emp_Id,cust_Id,check_Type,cust_Addr,check_Time(String),memo,approval_Man(long)
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param check_Type （req）  签到类型 (type=1为签到，2为签退，3为外勤）
 
 *  @param cust_Addr （req）  签到地点
 
 *  @param check_Time （req） 签到时间
 
 *  @param memo （req）  补签原因
 
 *  @param approval_Man （req） 审批人
 
 
 */
+ (void)postCommitApplyWithCheckType:(NSInteger)checkType  address:(NSString *)address time:(NSString *)time memo:(NSString *)memo  applyPeople:(NSString *)applyPeople Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    签到统计
 
 *  @param cust_Id （req）  公司id
 
 *  @param emp_Id （req）  员工id
 
 *  @param year （req）
 
 *  @param month （req）
 
 */

+ (void)postCheckStatisticWithYear:(NSString *)year month:(NSString *)month  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

#pragma ================== 密码 =====================
/**
 *    验证旧密码  emp_Id, oldPswd
 
 *  @param emp_Id （req）  员工id
 
 *  @param oldPswd （req） 旧密码
 
 */
+ (void)postVerificationOldPasswordWithOld:(NSString *)oldPswd   Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    保存新密  emp_Id, newPswd
 
 *  @param emp_Id （req）  员工id
 
 *  @param newPswd （req） 新密码
 
 */
+ (void)postCommitNewPasswordWithOld:(NSString *)newPswd   Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;
/**
 *    获取新的tonkey
 
 *  @param tokenkey  旧的tokenkey
 
 */
+ (void)postGetNewTokenkey:(NSString *)tokenkey   Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

#pragma ================== 加班审批 =====================
/**
 *    获取加班审批列表
 
 *  @param emp_Id  员工id
 
 */
+ (void)postGetOverTimeApproalListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;
/**
 *    获取加班审批信息  
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param apply_Id （req）  申请id
 
 */
+ (void)postOverTimeApproalMessageWithApply:(NSInteger)applyid Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    提交加班审批
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param apply_Id （req）  申请id
 
 *  @param is_Pass （req）  是否通过  0 不通过 , 1 通过
 
 *  @param next_Approval_Man （req） 下次审批人
 
 *  @param memo （req）  说明
 
 */
+ (void)postCommitOverTimeWithApply:(NSInteger)applyid isPass:(NSInteger)isPass nextApprovalManId:(NSString *)nextApprovalManId  memo:(NSString *)memo Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;



#pragma ================== 签到审批 =====================
/**
 *    获取签到审批列表
 
 *  @param emp_Id  员工id
 
 */
+ (void)postSignUpApproalListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;


/**
 *    获取签到审批信息
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param apply_Id （req）  申请id
 
 */
+ (void)postSignUpApproalMessageWithApply:(NSInteger)applyid Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    提交签到审批  kq/saveSignLaterExamStep.json','emp_Id':'','cust_Id':'','apply_Id':'','is_Pass':'','next_Approval_Man':'','memo':''
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param apply_Id （req）  申请id
 
 *  @param is_Pass （req）  是否通过  0 不通过 , 1 通过
 
 *  @param next_Approval_Man （req） 下次审批人
 
 *  @param memo （req）  说明
 
 */
+ (void)postCommitSignUpApproalWithApply:(NSInteger)applyid isPass:(NSInteger)isPass nextApprovalManId:(NSString *)nextApprovalManId  memo:(NSString *)memo Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;



#pragma ================== 请假审批 =====================
/**
 *    获取请假审批列表
 
 *  @param emp_Id  员工id
 
 */
+ (void)postLeaveApproalListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    获取签到审批信息
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param apply_Id （req）  申请id
 
 */
+ (void)postLeaveApproalMessageWithApply:(NSInteger)holEmpExamId Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    提交签到审批
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param apply_Id （req）  申请id
 
 *  @param is_Pass （req）  是否通过  0 不通过 , 1 通过
 
 *  @param next_Approval_Man （req） 下次审批人
 
 *  @param memo （req）  说明
 
 */
+ (void)postCommitLeaveApproalWithApply:(NSInteger)holEmpExamId isPass:(NSInteger)isPass nextApprovalManId:(NSString *)nextApprovalManId  memo:(NSString *)memo Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

#pragma ================== 休假申请、记录 =====================

/**
 *    获取休假申请信息
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postLeaveApplyMessageSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    提交休假申请    'hol_Set_Id':'','hol_Begin':'','hol_End':'','hol_Begin_Apm':'','hol_End_Apm':'','hol_Num':'','momo':'','approval_Man':'','hol_Unit

 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param time_Unit （req）  时间单位
 
 *  @param work_Duration （req）  时间段
 
 *  @param begin_Time （req）  开始时间
 
 *  @param end_Time （req）  结束时间
 
 *  @param approval_Man （req） 审批人
 
 *  @param reason （req）  原因
 
 */
+ (void)postCommitLeaveApplyWihtHolSetId:(NSInteger)holSetId holUnit:(NSInteger)holUnit holNum:(NSString *)holNum  beginTime:(NSString *)beginTime endTime:(NSString *)endTime   holBeginApm:(NSString *)holBeginApm holEndApm:(NSString *)holEndApm reason:(NSString *)reason approvalMan:(NSInteger )approvalManID Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *   休假记录
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postLeaveRecordListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *   休假删除
 
 *  @param holEmpExamId （req） 假期id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postDelLeaveRecordWithHolEmpExamId:(NSString *)holEmpExamId Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;


#pragma ================== 加班申请、记录 =====================
/**
 *    获取加班申请信息
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postOverTimeApplyMessageSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    提交加班申请
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 *  @param time_Unit （req）  时间单位   1 天 , 2 小时, 3 半天
 
 *  @param work_Duration （req）  时间段
 
 *  @param begin_Time （req）  开始时间
 
 *  @param end_Time （req）  结束时间
 
 *  @param approval_Man （req） 审批人
 
 *  @param reason （req）  原因
 
 */
+ (void)postCommitOverTimeApplyWihtTimeUnit:(NSInteger)timeUnit workDuration:(NSString *)workDuration beginTime:(NSString *)beginTime endTime:(NSString *)endTime reason:(NSString *)reason approvalMan:(NSInteger )approvalManID Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *   加班记录
 
 *  @param emp_Id （req）  员工id
 
 *  @param cust_Id （req） 公司id
 
 
 */
+ (void)postOverTimeRecordListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;
@end
