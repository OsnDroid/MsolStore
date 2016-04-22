//
//  ResetDelegate.h
//  MsolStore
//
//  Created by IoCan on 16/4/21.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResetDelegate <NSObject>

@optional
-(void) onResetSuccess:(BOOL) state;

@end
