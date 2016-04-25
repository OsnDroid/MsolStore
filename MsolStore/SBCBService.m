//
//  SBCBService.m
//  MsolStore
//
//  Created by IoCan on 16/4/25.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "SBCBService.h"
#import "AFHTTPRequestOperationManager.h"
#import "LoginService.h"

@interface SBCBService()

@property (nonatomic, strong) Account *account;

@end

@implementation SBCBService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.account = [UserInfoManager getAccount];
        self.tag = 0;
    }
    return self;
}


//提交订单
-(void)submitOrder:(int) productId
       productType:(NSString *)productType
              name:(NSString *)name
          linkeNum:(NSString *)linkeNum
              city:(NSString *)city
              area:(NSString *)area
           address:(NSString *)address
            cardId:(NSString *)cardId
          resmarks:(NSString *)resmarks{
    MyLog(@"username:%@\nproductId:%d\nproductType:%@\nname:%@\nlinkeNum:%@\ncity:%@\narea:%@\naddress:%@\ncardId:%@\nresmarks:%@",self.account.username,productId,productType,name,linkeNum,city,area,address,cardId,resmarks);
    
    NSDictionary *parameters = @{@"username": self.account.username,
                                 @"productType":productType,
                                 @"name":name,
                                 @"linkNum":linkeNum,
                                 @"city":city,
                                 @"area":area,
                                 @"id":[NSString stringWithFormat:@"%d",productId] ,
                                 @"address":address,
                                 @"cardId":cardId,
                                 @"resmarks":resmarks};
    [self post:@"msty_app/interface/submitOrder" parameters:parameters];
    
    
}


-(void)post:(NSString *) url parameters:(id) parameters {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:[SERVICEURL stringByAppendingString:url] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"====%@",responseObject,nil);
        NSString *code = [responseObject objectForKey:@"code"];
        if ([code isEqualToString:@"333"]) {
            //重登
            MyLog(@"重登陆...",nil);
            LoginService *loginService = [[LoginService alloc] init];
            loginService.tag = self.tag;
            loginService.delegate = self.delegate;
            [loginService login];
            //            if (self.delegate) {
            //                [self.delegate onFinish];
            //            }
            MyLog(@"%@",[responseObject objectForKey:@"message"],nil);
            
        } else if([code isEqualToString:@"001"] ||
                  [code isEqualToString:@"002"] ||
                  [code isEqualToString:@"003"] ||
                  [code isEqualToString:@"004"] ) {
            if (self.delegate) {
                [self.delegate onFinish];
                [self.delegate onLoginFail:responseObject];
            }
        }
        else {
            if (self.delegate) {
                [self.delegate onFinish];
                [self.delegate onResponse:responseObject tag:self.tag];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (self.delegate) {
            [self.delegate onError:error];
            [self.delegate onFinish];
        }
    }];
    
}


@end
