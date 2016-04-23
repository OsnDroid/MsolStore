//
//  BBHService.h
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "NetService.h"

@interface BBHService : NetService

//获取结对营业厅的列表
-(void)getList;

-(void)update:(NSString *) updateUsername;
@end
