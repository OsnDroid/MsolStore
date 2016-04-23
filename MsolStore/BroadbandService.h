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

@end
