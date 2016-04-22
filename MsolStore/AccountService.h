//
//  AccountService.h
//  MsolStore
//
//  Created by IoCan on 16/4/21.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetService.h"

@interface AccountService : NetService

//查询个人信息
-(void)queryUserInfo;

//提交反馈意见
-(void)submitOpinion:(NSString *) phone content:(NSString *) content;

//重置密码
-(void)resetPassword:(NSString *) phone newPwd:(NSString *) newPwd code:(NSString *) code;

@end
