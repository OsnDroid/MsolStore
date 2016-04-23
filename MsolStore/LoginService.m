//
//  LoginService.m
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "LoginService.h"
#import "Account.h"
#import "UserInfoManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "NSString+Phone.h"

@implementation LoginService


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tag = 0;
    }
    return self;
}

-(void)login {
    Account *account = [UserInfoManager getAccount];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"username": account.phone,
                                 @"password":account.password};
    MyLog(@"%@---%@",account.phone,account.password,nil);
    [manager POST:[SERVICEURL stringByAppendingString:@"msty/login"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        MyLog(@"%@",responseObject,nil);
        if (self.delegate) {
            [self.delegate onFinish];
        }
        NSString *result = [responseObject objectForKey:@"code"];
        if ([result isEqualToString:@"000"]) {
            NSDictionary *account = [responseObject objectForKey:UserInfo];
            NSString *username = [account objectForKey:@"username"];
            NSString *name = [account objectForKey:@"name"];
            NSString *city = [account objectForKey:@"city"];
            NSString *area = [account objectForKey:@"area"];
            NSString *area2 = [account objectForKey:@"area2"];
            NSString *channel_id = [account objectForKey:@"channel_id"];
            NSString *sell_name = [account objectForKey:@"sell_name"];
            
            NSString *dz_flag = [account objectForKey:@"dz_flag"];
            NSString *fourg = [account objectForKey:@"fourg"];
            NSString *threeg = [account objectForKey:@"threeg"];
            NSString *card = [account objectForKey:@"card"];
            NSString *phone = [account objectForKey:@"phone"];
            
            NSString *password = [account objectForKey:@"password"];
            NSString *address = [account objectForKey:@"address"];
            int level = (int)[account objectForKey:@"level"];
            
            Account *localAcount = [[Account alloc] init];
            localAcount.name = name;
            localAcount.username = username;
            localAcount.city = city;
            localAcount.area = area;
            localAcount.channel_id = channel_id;
            
            localAcount.dz_flag = dz_flag;
            localAcount.fourG = ([NSString isBlankString:fourg]? DEFAULT_FOURG : fourg);
            localAcount.threeG = ([NSString isBlankString:threeg]? DEFAULT_THREEG : threeg);
            localAcount.card = [NSString isBlankString:card]?@"":card;
            localAcount.phone = phone;
            
            localAcount.sell_name = sell_name;
            localAcount.area2 = area2;
            localAcount.address = address;
            localAcount.password = password;
            localAcount.level = level;
            BOOL isSavesuccess = [UserInfoManager saveAccount:localAcount];
            MyLog(@"登陆成功",nil);
            if (self.delegate) {
               [self.delegate onLoginSuccess:isSavesuccess tag:self.tag];
            }
            
        } else {
            if (self.delegate) {
                [self.delegate onLoginFail:responseObject];
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
