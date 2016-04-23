//
//  BroadbandService.m
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BroadbandService.h"

@implementation BroadbandService


-(void)getList:(NSString *) method {
    NSDictionary *parameters = @{};
    [self post:[NSString stringWithFormat:@"msty/%@",method,nil] parameters:parameters];
}


@end
