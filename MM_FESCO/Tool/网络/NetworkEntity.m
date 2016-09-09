//
//  NetworkEntity.m
//  MM_FESCO
//
//  Created by Mortimey on 16/8/2.
//  Copyright © 2016年 Mortimey. All rights reserved.
//

#import "NetworkEntity.h"

@implementation NetworkEntity

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
    NSString * urlStr = [NSString stringWithFormat:@"%@/%@",[NetworkTool domain],@"login.json"];
    
    NSDictionary * dic = @{@"token":tokenkey,
                           
                           
                           };
    NSLog(@"url ------ %@, %@",urlStr,dic);
    
    
    [NetworkTool POST:urlStr params:dic success:success failure:failure];
}
@end
