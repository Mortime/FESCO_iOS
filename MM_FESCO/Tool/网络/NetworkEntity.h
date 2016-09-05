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


/**
 *    签到
 
 *  @param cust_Id （req）  公司id
 
 *  @param emp_Id （req）  员工id
 
 *  @param longitude （req） ,latitude  经纬度  ,  memo (外勤时说明内容)
 
 *  @param type （req）  type  (type=1为签到，2为签退，3为外勤）
 
 */
+ (void)postSignUpTypeWithLongitude:(NSInteger)longitude latitude:(NSInteger)latitude type:(NSInteger)type memo:(NSString *)memo  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;

/**
 *    考勤记录
 
 *  @param emp_Id （req）  员工id
 
 *  @param pageNum （req） 页码
 
 *  @param pageSize （req）  每页条数
 
 */
+ (void)postSignUpListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure;
@end
