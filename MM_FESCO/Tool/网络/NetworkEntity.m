//
//  NetworkEntity.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NetworkEntity.h"
#import "NewPurchaseRecordModel.h"


@implementation NetworkEntity

/**
 *   注册 获取验证码
 */

+ (void)postRegisterCodeNumberWithMail:(NSString *)mail success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    if (!mail) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"user/preRegister.json"];
    NSLog(@"mainHomeUrlstr  %@",urlStr);
    
    
    NSDictionary * dic = @{@"email":mail
                           
                           };

        
    
    NSLog(@"mainHomeUrlstrdic  %@",dic);
    [NetworkTool POST:urlStr params:dic success:success failure:failure];

}
/**
 *   注册 注册
 */


+ (void)postRegisterNumberWithMail:(NSString *)mail  userName:(NSString *)userName password:(NSString *)password  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    if (!mail) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"user/register.json"];
    NSLog(@"mainHomeUrlstr  %@",urlStr);
    
    
    
    NSDictionary * dic = @{@"email":mail,
                           @"login_name":userName,
                           @"login_password":password
                           
                           };
    
    
    NSLog(@"mainHomeUrlstrdic  %@",dic);
    [NetworkTool POST:urlStr params:dic success:success failure:failure];
}




/**
 *   首页标签信息
 */
+ (void)postHomeMainListWithParamMD5:(NSString *)paramMD5  menthodname:(NSString *)menthodname tokenkeyID:(NSString *)tokenkey secret:(NSString *)secret success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    if (!paramMD5) {
                return [NetworkTool missParagramerCallBackFailure:failure];
    }
        NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"getMenu.json"];
    NSLog(@"mainHomeUrlstr  %@",urlStr);
    
    
    NSString *str = @"{'methodname':'getMenu'}";
    
    NSDictionary * dic = @{@"sign":paramMD5,
                           
                           @"jsonParam":str,
                           
                           @"tokenkey":tokenkey
                           
                           };

    
    NSLog(@"mainHomeUrlstrdic  %@",dic);
    [NetworkTool POST:urlStr params:dic success:success failure:failure];

}


/**
 *  用户登录 
 *
 *  @param photoNumber （req）  手机号
 *  @param password     (req)  密码 MD5加密后
 *  @param deviceId （req）  设备唯一标识
 *  @param deviceType     (req)  设备类型 (iOS : 1 ,android : 0);
 
 */

+ (void)postLoginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password deviceId:(NSString *)deviceId deviceType:(NSString *)deviceType   success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
    {
        if (!photoNumber || !password) {
            return [NetworkTool missParagramerCallBackFailure:failure];
        }
        NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"login.json"];
        
        NSDictionary * dic = @{@"login_Name":photoNumber,
                               @"password":password,
                               @"deviceId":deviceId,
                               @"deviceType":deviceType
                               
                               };
        NSLog(@"url ------ %@, %@",urlStr,dic);
        

[NetworkTool POST:urlStr params:dic success:success failure:failure];
    }
    

/**
 *   加载个人信息
 */
+ (void)postPersonMessageWithCustId:(NSString *)custid emptId:(NSString *)emptId tokenkeyID:(NSString *)tokenkey   sign:(NSString *)sign  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure
{
    if (!custid || !emptId) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/loadEmpInfo.json"];
    
    
    NSDictionary *jsonParam = @{@"cust_Id":custid,
                                @"emp_Id":emptId,
                                @"methodname":@"emp/loadEmpInfo.json"};
    
    NSString *resultStr =  [NSString jsonToJsonStingWith:jsonParam];
    
    
    NSDictionary * dic = @{@"jsonParam":resultStr,
                           
                           @"sign":sign,
                           
                           @"tokenkey":tokenkey
                           

                           };
    NSLog(@"url ------ %@, %@",resultStr,dic);
    
    
    [NetworkTool POST:urlStr params:dic success:success failure:failure];
}

/**
 *   HomeMain ======== 个人信息修改
 
 *  @param emptId     (req)  员工id
 
 */

+ (void)postSubmitPersonMessageWithEmpId:(NSString *)empId empName:(NSString *)empName  gender:(NSString *)gender mobile:(NSString *)mobile phone:(NSString *)phone weixinid:(NSString *)weixinid email:(NSString *)email address:(NSString *)address zipcode:(NSString *)zipcode  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    if (!empId ) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSLog(@"%@",address);
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/updateEmpInfo.json"];
    
    
    NSString *sexTag = @"";
    if ([gender isEqualToString:@"男"]) {
        sexTag = @"1";
    }
    if ([gender isEqualToString:@"女"]) {
        sexTag = @"2";
    }
    NSDictionary *param  = @{@"emp_Name":empName,
                                 @"emp_Id":empId,
                                 @"methodname":@"emp/updateEmpInfo.json",
                                 @"gender":sexTag,
                                 @"phone":phone,
                                 @"mobile":mobile,
                                 @"email":email,
                                 @"weixinid":weixinid,
                                 @"address":address,
                                 @"zipcode":zipcode
                                };
    NSString *sign = [NSString sortKeyWith:param];
    NSString *jsonParamStr = [NSString jsonToJsonStingWith:param];
    
    MMLog(@"MMMMsign ====%@       MMMjsonParamStr ===== =======%@",sign,jsonParamStr);
    
    
    

    
    NSDictionary * dic = @{@"jsonParam":jsonParamStr,
                           
                           @"sign":sign,
                           
                           @"tokenkey":[UserInfoModel defaultUserInfo].token
                           
                           };
    NSLog(@"url ------ %@",dic);
    
    
    [NetworkTool POST:urlStr params:dic success:success failure:failure];

}
+ (void)postPhoneNumberListWithCustId:(NSString *)custid  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    if (!custid ) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSDictionary *dic = @{@"cust_Id":custid,
                          @"methodname":@"emp/getAllPhoneNumber.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"emp/getAllPhoneNumber.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                           
                           @"sign":sign,
                           
                           @"tokenkey":[UserInfoModel defaultUserInfo].token
                           
                           
                           };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}

/**
 *   签到
 */
+ (void)postSignUpTypeWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude type:(NSInteger)type memo:(NSString *)memo  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{@"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"longitude":[NSString stringWithFormat:@"%f",longitude],
                          @"latitude":[NSString stringWithFormat:@"%f",latitude],
                          @"type":[NSString stringWithFormat:@"%lu",type],
                          @"memo":memo,
                          @"methodname":@"kq/sign.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/sign.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

    
}
/**
 *   考勤记录
 */
+ (void)postSignUpListWithPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"pageNum":[NSString stringWithFormat:@"%lu",pageNum],
                          @"pageSize":[NSString stringWithFormat:@"%lu",pageSize],
                          @"methodname":@"kq/getCedList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getCedList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}
/**
 *   补签记录
 */
+ (void)postFillListWithSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/getSignLaterList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getSignLaterList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
/**
 *    获取审批人列表
 */

+ (void)postApplyPeopleListWithSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/getApprovalMans.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getApprovalMans.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

/**
 *   提交审批  emp_Id,cust_Id,check_Type,cust_Addr,check_Time(String),memo,approval_Man(long)
 */
+ (void)postCommitApplyWithCheckType:(NSInteger)checkType  address:(NSString *)address time:(NSString *)time memo:(NSString *)memo  applyPeople:(NSString *)applyPeople Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    
    
    // 取出审批人多对应的id
    NSString *ID = @"";
    NSDictionary *dataBaseDic = [MMDataBase allDatalistWithTname:t_applySignup];
//            MMLog(@"数据库返回数据: %@",dataBaseDic);
    NSArray *paramArray = [dataBaseDic objectForKey:@"approvalManList"];
    if (paramArray.count) {
        for (NSDictionary *dic in paramArray) {
             NSString *name = [dic objectForKey:@"emp_Name"];
            if ([name isEqualToString:applyPeople]) {
                ID = [dic objectForKey:@"emp_Id"];
            }
            
        }
    }
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"check_Type":[NSString stringWithFormat:@"%lu",checkType],
                          @"cust_Addr":address,
                          @"check_Time":time,
                          @"memo":memo,
                          @"approval_Man":ID,
                          @"methodname":@"kq/saveSignLater.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/saveSignLater.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}



+ (void)postCheckStatisticWithYear:(NSString *)year month:(NSString *)month  success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"year":year,
                          @"month":month,
                          @"methodname":@"kq/getCheckListForEmp.json"}; 
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getCheckListForEmp.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
/**
 *   打卡记录
 */

+ (void)postCheckCheckWithDate:(NSString *)dateStr success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"dateStr":dateStr,
                          @"methodname":@"kq/getCheckDetailForEmp.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getCheckDetailForEmp.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}
/**
 *   剩余假期
 */

+ (void)postHolidayNumberSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                         @"methodname":@"kq/getRestHolidays.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getRestHolidays.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}
/**
 *   验证旧密码
 */

+ (void)postVerificationOldPasswordWithOld:(NSString *)oldPswd   Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    if (!oldPswd) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"oldPswd":oldPswd,
                          @"methodname":@"user/validatePswd.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"user/validatePswd.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    
}

/**
 *   保存新密码
 */
+ (void)postCommitNewPasswordWithOld:(NSString *)newPswd   Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    if (!newPswd) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"newPswd":newPswd,
                          @"methodname":@"user/modifyPswd.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"user/modifyPswd.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}
/**
 *   获取新的tokenkey
 */
+ (void)postGetNewTokenkey:(NSString *)tokenkey   Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    if (!tokenkey) {
        return [NetworkTool missParagramerCallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"getNewToken.json"];
    
    NSDictionary * dic = @{@"token":tokenkey,
                           
                           };
    NSLog(@"url ------ %@, %@",urlStr,dic);
    
    
    [NetworkTool POST:urlStr params:dic success:success failure:failure];
}
/**
 *   获取加班审批列表
 */
+ (void)postGetOverTimeApproalListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"methodname":@"kq/workExamList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/workExamList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
/**
 *   获取加班审批信息
 */
+ (void)postOverTimeApproalMessageWithApply:(NSInteger)applyid Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{  // {'methodname':'kq/getExtraWorkApply.json','emp_Id':'','cust_Id':'','apply_Id':''}
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"apply_Id":[NSString stringWithFormat:@"%lu",applyid],
                          @"methodname":@"kq/getExtraWorkApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getExtraWorkApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}

/**
 *   提交加班审批
 */
+ (void)postCommitOverTimeWithApply:(NSInteger)applyid isPass:(NSInteger)isPass nextApprovalManId:(NSString *)nextApprovalManId  memo:(NSString *)memo Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"apply_Id":[NSString stringWithFormat:@"%lu",applyid],
                          @"is_Pass":[NSString stringWithFormat:@"%lu",isPass],
                          @"next_Approval_Man":nextApprovalManId,
                          @"memo":memo,
                          @"methodname":@"kq/saveExtraWorkExamStep.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/saveExtraWorkExamStep.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}

/**
 *   获取签到审批列表
 */
+ (void)postSignUpApproalListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"methodname":@"kq/signLaterExamList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/signLaterExamList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}

/**
 *   获取签到审批信息
 */
+ (void)postSignUpApproalMessageWithApply:(NSInteger)applyid Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"apply_Id":[NSString stringWithFormat:@"%lu",applyid],
                          @"methodname":@"kq/getSignLaterExamInfo.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getSignLaterExamInfo.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
/**
 *   提交签到审批
 */
+ (void)postCommitSignUpApproalWithApply:(NSInteger)applyid isPass:(NSInteger)isPass nextApprovalManId:(NSString *)nextApprovalManId  memo:(NSString *)memo Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"apply_Id":[NSString stringWithFormat:@"%lu",applyid],
                          @"is_Pass":[NSString stringWithFormat:@"%lu",isPass],
                          @"next_Approval_Man":nextApprovalManId,
                          @"memo":memo,
                          @"methodname":@"kq/saveSignLaterExamStep.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/saveSignLaterExamStep.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}

/**
 *   获取请假审批列表
 */
+ (void)postLeaveApproalListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"methodname":@"kq/holExamList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/holExamList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

/**
 *   请假审批信息
 */
+ (void)postLeaveApproalMessageWithApply:(NSInteger)holEmpExamId Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"holEmpExamId":[NSString stringWithFormat:@"%lu",holEmpExamId],
                          @"methodname":@"kq/getHolEmpExam.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getHolEmpExam.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    
}
/**
 *   请假审批
 */
+ (void)postCommitLeaveApproalWithApply:(NSInteger)holEmpExamId isPass:(NSInteger)isPass nextApprovalManId:(NSString *)nextApprovalManId  memo:(NSString *)memo Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"holEmpExamId":[NSString stringWithFormat:@"%lu",holEmpExamId],
                          @"type":[NSString stringWithFormat:@"%lu",isPass],
                          @"next_Approval_Man":nextApprovalManId,
                          @"momo":memo,
                          @"methodname":@"kq/saveHolEmpExamStep.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/saveHolEmpExamStep.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    
}

/**
 *   获取休假申请信息
 */
+ (void)postLeaveApplyMessageSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/holApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/holApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
/**
 *   提交休假申请  'hol_Set_Id':'','hol_Begin':'','hol_End':'','hol_Begin_Apm':'','hol_End_Apm':'','hol_Num':'','momo':'','approval_Man':'','hol_Unit
 */
+ (void)postCommitLeaveApplyWihtHolSetId:(NSInteger)holSetId holUnit:(NSInteger)holUnit holNum:(NSString *)holNum  beginTime:(NSString *)beginTime endTime:(NSString *)endTime   holBeginApm:(NSString *)holBeginApm holEndApm:(NSString *)holEndApm reason:(NSString *)reason approvalMan:(NSInteger )approvalManID holName:(NSString *)holName Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"hol_Set_Id":[NSString stringWithFormat:@"%lu",holSetId],
                          @"hol_Unit":[NSString stringWithFormat:@"%lu",holUnit],
                          @"hol_Num":holNum,
                          @"hol_Begin_Apm":holBeginApm,
                          @"hol_End_Apm":holEndApm,
                          @"hol_Begin":beginTime,
                          @"hol_End":endTime,
                          @"momo":reason,
                          @"approval_Man":[NSString stringWithFormat:@"%lu",approvalManID],
                          @"hol_Name":holName,
                          @"methodname":@"kq/saveHolApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/saveHolApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    

}
/**
 *   休假记录
 */
+ (void)postLeaveRecordListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/getEmpHol.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getEmpHol.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}
/**
 *   休假删除
 */
+ (void)postDelLeaveRecordWithHolEmpExamId:(NSString *)holEmpExamId Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"holEmpExamId":holEmpExamId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/delHolApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/delHolApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}

/**
 *   获取加班申请信息
 */
+ (void)postOverTimeApplyMessageSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/workApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/workApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    
}
/**
 *   提交加班申请
 */
+ (void)postCommitOverTimeApplyWihtTimeUnit:(NSInteger)timeUnit workDuration:(NSString *)workDuration beginTime:(NSString *)beginTime endTime:(NSString *)endTime reason:(NSString *)reason approvalMan:(NSInteger )approvalManID Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    
    
    
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"time_Unit":[NSString stringWithFormat:@"%lu",timeUnit],
                          @"work_Duration":workDuration,
                          @"begin_Time":beginTime,
                          @"end_Time":endTime,
                          @"reason":reason,
                          @"approval_Man":[NSString stringWithFormat:@"%lu",approvalManID],
                          @"methodname":@"kq/saveWorkApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/saveWorkApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    
    
}
/**
 *   加班记录
 */
+ (void)postOverTimeRecordListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/getEmpWorkList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getEmpWorkList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

// 迟到排行
+ (void)postLaterTimeStatisticSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                        
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/getCedRanking.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getCedRanking.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
// 加班排行
+ (void)postOverTimeStatisticSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    NSDictionary *dic = @{
                          
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"kq/getWorkRanking.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"kq/getWorkRanking.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

#pragma ================== 报销 =====================

//  加载报销列表
+ (void)postReimburseListSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,  
                          @"methodname":@"expense/getExpenseApplyList.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/getExpenseApplyList.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

//  加载消费记录
+ (void)postPurchaseRecordSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"methodname":@"expense/getExpenseRecords.json"};  
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/getExpenseRecords.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

//  加载编辑报销单
+ (void)postEditReimburseBookSuccess:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"methodname":@"expense/loadAddApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/loadAddApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
//  保存报销申请
+ (void)postPreserveReimburseApplyWithMemo:(NSString *)memo  title:(NSString *)title type:(NSUInteger)type applyDate:(NSString *)applyDate groupId:(NSUInteger)groupId accountId:(NSUInteger)accountId purchaseRecordModelArray:(NSArray *)newPurchaseRecordModelArray networkModelArray:(NSArray *)networkModelArray rePurchaseBookType:(NSInteger)rePurchaseBookType detailid:(NSInteger)detailid applyID:(NSInteger)applyID Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
   NSString *applyJsonArray = @"";
    // 申请jsonArray
    NSDictionary *applyDic = @{@"memo":memo,
                               @"type":[NSString stringWithFormat:@"%lu",type],
                               @"apply_Date":applyDate,
                               @"group_Id":[NSString stringWithFormat:@"%lu",groupId],
                               @"account_Id":[NSString stringWithFormat:@"%lu",accountId],
                               @"title":title,
                               @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                               @"cust_Id":[UserInfoModel defaultUserInfo].custId
                               };
    if (rePurchaseBookType == editReimburseBook) {
        
        applyDic = @{@"memo":memo,
                     @"type":[NSString stringWithFormat:@"%lu",type],
                     @"apply_Date":applyDate,
                     @"group_Id":[NSString stringWithFormat:@"%lu",groupId],
                     @"account_Id":[NSString stringWithFormat:@"%lu",accountId],
                     @"title":title,
                     @"apply_Id":[NSString stringWithFormat:@"%lu",applyID],
                     @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                     @"cust_Id":[UserInfoModel defaultUserInfo].custId
                     };
        
    }

    applyJsonArray = [NSString jsonToJsonArrayWith:applyDic];
    applyJsonArray = [NSString stringWithFormat:@"[%@]",applyJsonArray];
    MMLog(@"applyJsonArray ============ %@",applyJsonArray);
    
    // 描述jsonArray
    
    NSString *detailJsonArray = @"";
    
    if (rePurchaseBookType == editReimburseBook) {
        // 编辑报销单
        if (networkModelArray.count) {
            // 编辑时从服务器获取的消费记录
            for (NewPurchaseRecordModel *model in networkModelArray) {
                // 可能为空的字段
                // 1. 消费描述
                NSString *spendMemo = @" ";
                if (model.spendMemo) {
                    spendMemo = model.spendMemo;
                }
                // 2. 开始时间
                NSString *spendStart = @" ";
                if (model.spendBegin) {
                    spendStart = model.spendBegin;
                }
                
                // 3. 结束时间
                NSString *spendEnd = @" ";
                if (model.spendEnd) {
                    spendEnd = model.spendEnd;
                }
                // 4. 消费城市
                NSString *spendCity = @" ";
                if (model.cityName) {
                    spendCity = model.cityName;
                }
                
                // 5. 图片Url
                NSString *picUrl = @" ";
                if (model.picUrl) {
                    picUrl = model.picUrl;
                }
                
                // 6. 图片memo
                NSString *picMemo = @" ";
                if (model.picMemo) {
                    picMemo = model.picMemo;
                }
                
                // 当编辑消费记录时,如果消费记录已经存在要传 detail_Id, 如果是新添加的不用传 detail_Id.
                
                MMLog(@"%@=%@=%@=%@=%@=%@=%@=%@=%@=%@",[NSString stringWithFormat:@"%lu",model.spendId],[NSString stringWithFormat:@"%lu",model.moneyAmount],[NSString stringWithFormat:@"%lu",model.billNum],picUrl,spendMemo,spendStart,picMemo,spendEnd,spendCity,[NSString stringWithFormat:@"%lu",model.detailId]);
                
                NSDictionary *detailDic = @{@"spend_Type":[NSString stringWithFormat:@"%lu",model.spendId],
                                            @"money_Amount":[NSString stringWithFormat:@"%lu",model.moneyAmount],
                                            @"bill_Num":[NSString stringWithFormat:@"%lu",model.billNum],
                                            @"pic_Url":picUrl,
                                            @"detail_Memo":spendMemo,
                                            @"spend_Begin":spendStart,
                                            @"pic_Desc":picMemo,
                                            @"spend_End":spendEnd,
                                            @"spend_City":spendCity,
                                            @"detail_Id":[NSString stringWithFormat:@"%lu",model.detailId]
                                            
                                            };
                
                NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
                detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
            }
            // 去掉开始时的,
            NSString *resultStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
            
            
            // 拼接本地新增的消费记录
            NSString *newStr = @"";
            if (newPurchaseRecordModelArray.count != 0) {
                //  本地数据库的消费记录为空
                for (NSArray *mightarray in newPurchaseRecordModelArray) {
                    // 可能为空的字段
                    // 1. 消费描述
                    NSString *spendMemo = @"";
                    if (mightarray[6]) {
                        spendMemo = mightarray[6];
                    }
                    // 2. 开始时间
                    NSString *spendStart = @"";
                    if (mightarray[1]) {
                        spendStart = mightarray[1];
                    }
                    
                    // 3. 结束时间
                    NSString *spendEnd = @"";
                    if (mightarray[2]) {
                        spendEnd = mightarray[2];
                    }
                    // 4. 消费城市
                    NSString *spendCity = @"";
                    if (mightarray[7]) {
                        spendCity = mightarray[7];
                    }
                    
                    
                    
                    NSDictionary *detailDic = @{@"spend_Type":mightarray[8],
                                                @"money_Amount":mightarray[0],
                                                @"bill_Num":mightarray[3],
                                                @"pic_Url":mightarray[4],
                                                @"detail_Memo":spendMemo,
                                                @"spend_Begin":spendStart,
                                                @"pic_Desc":mightarray[5],
                                                @"spend_End":spendEnd,
                                                @"spend_City":spendCity
                                                
                                                };
                    
                    NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
                    detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
                }
                // 去掉开始时的,
                newStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
                resultStr = [NSString stringWithFormat:@"%@,%@",resultStr,newStr];
                
            }
            
            
            detailJsonArray = [NSString stringWithFormat:@"[%@]",resultStr];
            
            MMLog(@"networkModelArray ===detailJsonArray ============%@",detailJsonArray);
        }
        
        
    }else{
        
        // 新增消费记录
        if (newPurchaseRecordModelArray.count == 0) {
            detailJsonArray = @"'[ ]'";
        }else{
            for (NSArray *mightarray in newPurchaseRecordModelArray) {
                // 可能为空的字段
                // 1. 消费描述
                NSString *spendMemo = @"";
                if (mightarray[6]) {
                    spendMemo = mightarray[6];
                }
                // 2. 开始时间
                NSString *spendStart = @"";
                if (mightarray[1]) {
                    spendStart = mightarray[1];
                }
                
                // 3. 结束时间
                NSString *spendEnd = @"";
                if (mightarray[2]) {
                    spendEnd = mightarray[2];
                }
                // 4. 消费城市
                NSString *spendCity = @"";
                if (mightarray[7]) {
                    spendCity = mightarray[7];
                }
                
                
                
                NSDictionary *detailDic = @{@"spend_Type":mightarray[8],
                                            @"money_Amount":mightarray[0],
                                            @"bill_Num":mightarray[3],
                                            @"pic_Url":mightarray[4],
                                            @"detail_Memo":spendMemo,
                                            @"spend_Begin":spendStart,
                                            @"pic_Desc":mightarray[5],
                                            @"spend_End":spendEnd,
                                            @"spend_City":spendCity
                                            
                                            };
                
                NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
                detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
            }
            // 去掉开始时的,
            NSString *resultStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
            
            detailJsonArray = [NSString stringWithFormat:@"[%@]",resultStr];
        }
        
        
        MMLog(@"New ===detailJsonArray ============%@",detailJsonArray);
        
    }
    
    
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"apply":applyJsonArray,
                          @"details":detailJsonArray,
                          @"methodname":@"expense/saveExpenseApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStringArrayWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/saveExpenseApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
    
    
//    // 描述jsonArray
//
//    NSString *detailJsonArray = @"";
//    if (newPurchaseRecordModelArray.count == 0) {
//        detailJsonArray = @"'[ ]'";
//    }else{
//
//    for (NSArray *mightarray in newPurchaseRecordModelArray) {
//        // 可能为空的字段
//        // 1. 消费描述
//        NSString *spendMemo = @"";
//        if (mightarray[6]) {
//            spendMemo = mightarray[6];
//        }
//        // 2. 开始时间
//        NSString *spendStart = @"";
//        if (mightarray[1]) {
//            spendStart = mightarray[1];
//        }
//        
//        // 3. 结束时间
//        NSString *spendEnd = @"";
//        if (mightarray[2]) {
//            spendEnd = mightarray[2];
//        }
//        // 4. 消费城市
//        NSString *spendCity = @"";
//        if (mightarray[7]) {
//            spendCity = mightarray[7];
//        }
//        
//        MMLog(@"pic_Url == pic_Url %@",mightarray[4]);
//        
//        NSDictionary *detailDic = @{@"spend_Type":mightarray[8],
//                                    @"money_Amount":mightarray[0],
//                                    @"bill_Num":mightarray[3],
//                                    @"pic_Url":mightarray[4],
//                                    @"detail_Memo":spendMemo,
//                                    @"spend_Begin":spendStart,
//                                    @"pic_Desc":mightarray[5],
//                                    @"spend_End":spendEnd,
//                                    @"spend_City":spendCity
//                                    
//                                    };
//        NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
//        detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
//    }
//   // 去掉开始时的,
//    NSString *resultStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
//   
//    detailJsonArray = [NSString stringWithFormat:@"[%@]",resultStr];
//    
//    }
//    
//    MMLog(@"===detailJsonArray ============%@",detailJsonArray);
//    
//    NSDictionary *dic = @{
//                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
//                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
//                          @"apply":applyJsonArray,
//                          @"details":detailJsonArray,
//                          @"methodname":@"expense/saveExpenseApply.json"};
//    
//    NSString *jsonParam =  [NSString jsonToJsonStringArrayWith:dic];
//    
//    NSString *sign = [NSString sortKeyWith:dic];
//    
//    NSLog(@"%@%@",jsonParam,sign);
//    
//    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/saveExpenseApply.json"];
//    
//    NSDictionary *param = @{@"jsonParam":jsonParam,
//                            
//                            @"sign":sign,
//                            
//                            @"tokenkey":[UserInfoModel defaultUserInfo].token
//                            
//                            
//                            };
//    
//    
//    [NetworkTool POST:urlStr params:param success:success failure:failure];
}

// 提交报销单
+ (void)postCommitReimburseApplyWithMemo:(NSString *)memo  title:(NSString *)title type:(NSUInteger)type applyDate:(NSString *)applyDate groupId:(NSUInteger)groupId accountId:(NSUInteger)accountId purchaseRecordModelArray:(NSArray *)newPurchaseRecordModelArray networkModelArray:(NSArray *)networkModelArray applyMan:(NSInteger)manID rePurchaseBookType:(NSInteger)rePurchaseBookType detailid:(NSInteger)detailid applyID:(NSInteger)applyID Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    
    
    NSString *applyJsonArray = @"";
    // 申请jsonArray
    NSDictionary *applyDic = @{@"memo":memo,
                               @"type":[NSString stringWithFormat:@"%lu",type],
                               @"apply_Date":applyDate,
                               @"group_Id":[NSString stringWithFormat:@"%lu",groupId],
                               @"account_Id":[NSString stringWithFormat:@"%lu",accountId],
                               @"title":title,
                               @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                               @"cust_Id":[UserInfoModel defaultUserInfo].custId
                               };

    if (rePurchaseBookType == editReimburseBook) {
        
        applyDic = @{@"memo":memo,
                     @"type":[NSString stringWithFormat:@"%lu",type],
                     @"apply_Date":applyDate,
                     @"group_Id":[NSString stringWithFormat:@"%lu",groupId],
                     @"account_Id":[NSString stringWithFormat:@"%lu",accountId],
                     @"title":title,
                     @"apply_Id":[NSString stringWithFormat:@"%lu",applyID],
                     @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                     @"cust_Id":[UserInfoModel defaultUserInfo].custId
                     };

    }
    applyJsonArray = [NSString jsonToJsonArrayWith:applyDic];
    applyJsonArray = [NSString stringWithFormat:@"[%@]",applyJsonArray];
    MMLog(@"applyJsonArray ============ %@",applyJsonArray);
    
    
    /*
     
     (
     100,
     "2016-11-20",
     "2016-11-22",
     1,
     "F://expensePics/9/5/20161122121357IMG_0002.JPG",
     "\U56fe\U7247900",
     ceshi,
     "\U5b89\U9633",
     17,
     "\U957f\U9014-\U7070\U673a"
     )
     
     */
    
    // 描述jsonArray
    
    NSString *detailJsonArray = @"";
    
    if (rePurchaseBookType == editReimburseBook) {
        // 编辑报销单
        if (networkModelArray.count) {
            // 编辑时从服务器获取的消费记录
            for (NewPurchaseRecordModel *model in networkModelArray) {
                // 可能为空的字段
                // 1. 消费描述
                NSString *spendMemo = @" ";
                if (model.spendMemo) {
                    spendMemo = model.spendMemo;
                }
                // 2. 开始时间
                NSString *spendStart = @" ";
                if (model.spendBegin) {
                    spendStart = model.spendBegin;
                }
                
                // 3. 结束时间
                NSString *spendEnd = @" ";
                if (model.spendEnd) {
                    spendEnd = model.spendEnd;
                }
                // 4. 消费城市
                NSString *spendCity = @" ";
                if (model.cityName) {
                    spendCity = model.cityName;
                }
                
                // 5. 图片Url
                NSString *picUrl = @" ";
                if (model.picUrl) {
                    picUrl = model.picUrl;
                }
                
                // 6. 图片memo
                NSString *picMemo = @" ";
                if (model.picMemo) {
                    picMemo = model.picMemo;
                }
                
                // 当编辑消费记录时,如果消费记录已经存在要传 detail_Id, 如果是新添加的不用传 detail_Id.
                
                MMLog(@"%@=%@=%@=%@=%@=%@=%@=%@=%@=%@",[NSString stringWithFormat:@"%lu",model.spendId],[NSString stringWithFormat:@"%lu",model.moneyAmount],[NSString stringWithFormat:@"%lu",model.billNum],picUrl,spendMemo,spendStart,picMemo,spendEnd,spendCity,[NSString stringWithFormat:@"%lu",model.detailId]);
                
                NSDictionary *detailDic = @{@"spend_Type":[NSString stringWithFormat:@"%lu",model.spendId],
                                            @"money_Amount":[NSString stringWithFormat:@"%lu",model.moneyAmount],
                                            @"bill_Num":[NSString stringWithFormat:@"%lu",model.billNum],
                                            @"pic_Url":picUrl,
                                            @"detail_Memo":spendMemo,
                                            @"spend_Begin":spendStart,
                                            @"pic_Desc":picMemo,
                                            @"spend_End":spendEnd,
                                            @"spend_City":spendCity,
                                            @"detail_Id":[NSString stringWithFormat:@"%lu",model.detailId]
                                            
                                            };
                
                NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
                detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
            }
            // 去掉开始时的,
            NSString *resultStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
            
            
      // 拼接本地新增的消费记录
            NSString *newStr = @"";
                    if (newPurchaseRecordModelArray.count != 0) {
                        //  本地数据库的消费记录为空
                        for (NSArray *mightarray in newPurchaseRecordModelArray) {
                            // 可能为空的字段
                            // 1. 消费描述
                            NSString *spendMemo = @"";
                            if (mightarray[6]) {
                                spendMemo = mightarray[6];
                            }
                            // 2. 开始时间
                            NSString *spendStart = @"";
                            if (mightarray[1]) {
                                spendStart = mightarray[1];
                            }
                            
                            // 3. 结束时间
                            NSString *spendEnd = @"";
                            if (mightarray[2]) {
                                spendEnd = mightarray[2];
                            }
                            // 4. 消费城市
                            NSString *spendCity = @"";
                            if (mightarray[7]) {
                                spendCity = mightarray[7];
                            }
                            
                            
                            
                            NSDictionary *detailDic = @{@"spend_Type":mightarray[8],
                                                        @"money_Amount":mightarray[0],
                                                        @"bill_Num":mightarray[3],
                                                        @"pic_Url":mightarray[4],
                                                        @"detail_Memo":spendMemo,
                                                        @"spend_Begin":spendStart,
                                                        @"pic_Desc":mightarray[5],
                                                        @"spend_End":spendEnd,
                                                        @"spend_City":spendCity
                                                        
                                                        };
                            
                            NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
                            detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
                        }
                        // 去掉开始时的,
                       newStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
                        resultStr = [NSString stringWithFormat:@"%@,%@",resultStr,newStr];
                        
                    }
            
            
            detailJsonArray = [NSString stringWithFormat:@"[%@]",resultStr];
            
            MMLog(@"networkModelArray ===detailJsonArray ============%@",detailJsonArray);
        }
        
        
    }else{
        
        // 新增消费记录
        if (newPurchaseRecordModelArray.count == 0) {
            detailJsonArray = @"'[ ]'";
        }else{
            for (NSArray *mightarray in newPurchaseRecordModelArray) {
                // 可能为空的字段
                // 1. 消费描述
                NSString *spendMemo = @"";
                if (mightarray[6]) {
                    spendMemo = mightarray[6];
                }
                // 2. 开始时间
                NSString *spendStart = @"";
                if (mightarray[1]) {
                    spendStart = mightarray[1];
                }
                
                // 3. 结束时间
                NSString *spendEnd = @"";
                if (mightarray[2]) {
                    spendEnd = mightarray[2];
                }
                // 4. 消费城市
                NSString *spendCity = @"";
                if (mightarray[7]) {
                    spendCity = mightarray[7];
                }
                
                
                
                NSDictionary *detailDic = @{@"spend_Type":mightarray[8],
                                            @"money_Amount":mightarray[0],
                                            @"bill_Num":mightarray[3],
                                            @"pic_Url":mightarray[4],
                                            @"detail_Memo":spendMemo,
                                            @"spend_Begin":spendStart,
                                            @"pic_Desc":mightarray[5],
                                            @"spend_End":spendEnd,
                                            @"spend_City":spendCity
                                            
                                            };
                
                NSString *mightStr = [NSString jsonToJsonArrayWith:detailDic];
                detailJsonArray = [NSString stringWithFormat:@"%@,%@",detailJsonArray,mightStr];
            }
            // 去掉开始时的,
            NSString *resultStr = [detailJsonArray substringFromIndex:1];//截取掉下标0之后的字符串
            
            detailJsonArray = [NSString stringWithFormat:@"[%@]",resultStr];
        }
        
        
        MMLog(@"New ===detailJsonArray ============%@",detailJsonArray);

    }
    
    
    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"cust_Id":[UserInfoModel defaultUserInfo].custId,
                          @"apply":applyJsonArray,
                          @"details":detailJsonArray,
                          @"approval_Man":[NSString stringWithFormat:@"%lu",manID],
                          @"methodname":@"expense/submitExpenseApply.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStringArrayWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/submitExpenseApply.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
// 保存消费记录
+ (void)postPreservePurchaseRecordWithSpendType:(NSUInteger )spendType moneyAmount:(NSString *)moneyAmount  billNum:(NSString *)billNum detailMemo:(NSString *)detailMemo picUrl:(NSString *)picUrl picDesc:(NSString *)picDesc spendBegin:(NSString *)spendBegin spendEnd:(NSString *)spendEnd spendCity:(NSString *)spendCity  Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{

    
    NSDictionary *dic = @{
                          @"emp_Id":[UserInfoModel defaultUserInfo].empId,
                          @"spend_Type":[NSString stringWithFormat:@"%lu",spendType],
                          @"money_Amount":moneyAmount,
                          @"bill_Num":billNum,
                          @"detail_Memo":detailMemo,
                          @"pic_Url":picUrl,
                          @"pic_Desc":picDesc,
                          @"spend_Begin":spendBegin,
                          @"spend_End":spendEnd,
                          @"spend_City":spendCity,
                          @"methodname":@"expense/saveExpenseRecord.json"};
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/saveExpenseRecord.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];

}
// 删除消费记录
+ (void)postDeleReimburseRecordWithDetailId:(NSInteger )detailId Success:(NetworkSuccessBlock)success failure:(NetworkFailureBlock)failure{
    NSDictionary *dic = @{
                          @"detail_Id":[NSString stringWithFormat:@"%lu",detailId],
                           @"methodname":@"expense/deleteRecord.json"
                          };
    
    NSString *jsonParam =  [NSString jsonToJsonStingWith:dic];
    
    NSString *sign = [NSString sortKeyWith:dic];
    
    NSLog(@"%@%@",jsonParam,sign);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"expense/deleteRecord.json"];
    
    NSDictionary *param = @{@"jsonParam":jsonParam,
                            
                            @"sign":sign,
                            
                            @"tokenkey":[UserInfoModel defaultUserInfo].token
                            
                            
                            };
    
    
    [NetworkTool POST:urlStr params:param success:success failure:failure];
}
@end
