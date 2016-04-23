//
//  LoginService.h
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginDelegate.h"


@interface LoginService : NSObject


@property (assign, nonatomic) id <LoginDelegate> delegate;

-(void)login;

@property (assign,nonatomic) int tag;

@end
