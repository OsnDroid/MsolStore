//
//  SBCBService.h
//  MsolStore 
//
//  Created by IoCan on 16/4/25.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "NetService.h"
#import "LoginDelegate.h"


@interface SBCBService : NSObject

//网络协议
@property (assign, nonatomic) id <LoginDelegate> delegate;

@property (assign,nonatomic) int tag;

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
