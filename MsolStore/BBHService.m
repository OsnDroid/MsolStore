//
//  BBHService.m
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BBHService.h"

@interface BBHService()


@property (nonatomic, strong) Account *account;

@end

@implementation BBHService


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.account = [UserInfoManager getAccount];
    }
    return self;
}

-(void)getList{
    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"mstyapp/product/twins" parameters:parameters];
}

-(void)update:(NSString *) updateUsername {
    NSDictionary *parameters = @{@"username": [self.account.username stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
                                 @"twin":[updateUsername stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [self post:@"mstyapp/product/cgtwins" parameters:parameters];

}


@end
