//
//  BroadbandService.h
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "NetService.h"

@interface BroadbandService : NetService

//获取列表
-(void)getList:(NSString *) method;

//提交订单
-(void)submitOrder:(int) productId
       productType:(NSString *)productType
       name:(NSString *)name
       linkeNum:(NSString *)linkeNum
       city:(NSString *)city
       area:(NSString *)area
       address:(NSString *)address
       cardId:(NSString *)cardId
       resmarks:(NSString *)resmarks;



@end
