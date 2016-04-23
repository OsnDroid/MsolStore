//
//  NetService.m
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "NetService.h"
#import "LoginService.h"
#import "AFHTTPRequestOperationManager.h"

@interface NetService()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation NetService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPRequestOperationManager manager];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.tag = 0;
    }
    return self;
}


-(void)post:(NSString *) url parameters:(id) parameters {
    
    [self.manager POST:[SERVICEURL stringByAppendingString:url] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MyLog(@"%@",responseObject,nil);
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
