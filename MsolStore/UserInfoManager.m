//
//  UserInfoManager.m
//  DatastreamBank
//
//  Created by OsnDroid on 15/10/31.
//  Copyright (c) 2015年 OsnDroid. All rights reserved.
//

#import "UserInfoManager.h"
#import "NSString+Phone.h"

@implementation UserInfoManager


+(BOOL)clear {
    NSUserDefaults *userInfoManager = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = userInfoManager.dictionaryRepresentation;
    NSArray * keys = [dic allKeys];
    for(int i = 0;i < [keys count];i ++) {
        [userInfoManager removeObjectForKey:[keys objectAtIndex:i]];
    }
    return [userInfoManager synchronize];
}

//是否第一次登陆

+(BOOL)isFirstLoad {
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLoad"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstLoad"];
        return YES;
    } else {
        return NO;
    }
}

//创建一个NSUserDefaults对象用以保存数据
+(BOOL)saveAccount:(Account *)account {
    NSUserDefaults *userInfoManager = [NSUserDefaults standardUserDefaults];
    if (account == Nil) {
        return NO;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:data forKey:@"account"];
    return [userInfoManager synchronize];
}

+(Account *)getAccount {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"account"];
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return account;
}

//读取任意字段数据
+(id)readObjectByKey:(NSString *)key {
    NSUserDefaults *userInfoManager = [NSUserDefaults standardUserDefaults];
    return [userInfoManager objectForKey:key];
}

//读取整个用户数据
+(NSDictionary *)readUserInfo {
    NSUserDefaults *userInfoManager = [NSUserDefaults standardUserDefaults];
    return [userInfoManager dictionaryRepresentation];
}


//更改某项数据

+(BOOL)updateWithObject:(id)obj forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    return  [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)addObject:(id)obj forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    return  [[NSUserDefaults standardUserDefaults] synchronize];
}
 

+(BOOL)updateWithBool:(BOOL)boolValue forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:boolValue  forKey:key];
    return  [[NSUserDefaults standardUserDefaults] synchronize];
}


+(BOOL)updateWithFloat:(float)floatValue forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setFloat:floatValue  forKey:key];
    return  [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)updateWithInteger:(NSInteger)intValue forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setInteger:intValue  forKey:key];
    return  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
