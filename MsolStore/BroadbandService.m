//
//  BroadbandService.m
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BroadbandService.h"



@interface BroadbandService()


@property (nonatomic, strong) Account *account;

@end

@implementation BroadbandService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.account = [UserInfoManager getAccount];
    }
    return self;
}

-(void)getList:(NSString *) method {
    NSDictionary *parameters = @{};
    [self post:[NSString stringWithFormat:@"msty/%@",method,nil] parameters:parameters];
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
    

    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"productType":[productType stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"name":[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"linkeNum":[linkeNum stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"city":[city stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"area":[area stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"id":[[NSString stringWithFormat:@"%d",productId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"address":[address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"cardId":[cardId stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"resmarks":[resmarks stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"msty_app/interface/submitOrder" parameters:parameters];


}

@end
