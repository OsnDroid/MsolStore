//
//  AccountService.m
//  MsolStore
//
//  Created by IoCan on 16/4/21.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "AccountService.h"

@interface AccountService ()

@property (nonatomic, strong) Account *account;


@end


@implementation AccountService


- (instancetype)init {
    self = [super init];
    if (self) {
        self.account = [UserInfoManager getAccount];
    }
    return self;
}


-(void)queryUserInfo {
    NSDictionary *parameters = @{@"username": [self.account.phone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"mstyapp/product/info" parameters:parameters];
}


-(void)submitOpinion:(NSString *) phone content:(NSString *) content {
 
    NSDictionary *parameters = @{@"phone": [phone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"opinion":[content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"msty/opinion" parameters:parameters];
}

-(void)resetPassword:(NSString *) phone newPwd:(NSString *) newPwd code:(NSString *) code {
    NSDictionary *parameters = @{@"username": [phone stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"newpassword":[newPwd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"verificationcode":[code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"msty/resetPassWord" parameters:parameters];
}


@end
