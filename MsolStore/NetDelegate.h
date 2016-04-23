//
//  NetDelegate.h
//  MsolStore
//
//  Created by IoCan on 16/4/21.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetDelegate <NSObject>

@optional

//服务器返回
-(void) onResponse:(id) responseObject tag:(int) tag;
//网络异常
-(void) onError:(NSError *)error;
// 完成
-(void) onFinish;

@end
