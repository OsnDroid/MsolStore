//
//  LoginDelegate.h
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetDelegate.h"

@protocol LoginDelegate <NSObject,NetDelegate>

@optional

//登陆成功
-(void) onLoginSuccess:(BOOL) state tag:(int) tag;
//登陆密码帐号错误
-(void) onLoginFail:(id) responseObject;
//登陆session实效
-(void) onLoginInvalid;


@end
