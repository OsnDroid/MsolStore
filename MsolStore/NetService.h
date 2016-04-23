//
//  NetService.h
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDelegate.h"

@interface NetService : NSObject

//网络协议
@property (assign, nonatomic) id <LoginDelegate> delegate;


//Post请求
-(void)post:(NSString *) url parameters:(id) parameters;

@property (assign,nonatomic) int tag;

@end
