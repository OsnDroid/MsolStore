//
//  ProductService.m
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ProductService.h"


@interface ProductService()


@property (nonatomic, strong) Account *account;

@end

@implementation ProductService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.account = [UserInfoManager getAccount];
    }
    return self;
}


//获取自己的产品
-(void)getOwnProducts{
    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"type":[@"全部" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"mstyapp/product/get" parameters:parameters];
}

//删除自己产品
-(void)deleleProducts:(id)products{
    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"info":products};
    MyLog(@"删除数据：%@",parameters,nil);
    [self post:@"mstyapp/product/del" parameters:parameters];
}

//增加自己产品
-(void)addProducts:(id)products{
    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"info":products};
    [self post:@"mstyapp/product/hold" parameters:parameters];
}

//获取可增加的其它产品列表
-(void)getAllProducts{
    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"type":[@"全部" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"mstyapp/product/pentHol" parameters:parameters];
}


@end
