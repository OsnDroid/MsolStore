//
//  Account.h
//  MsolStore
//
//  Created by IoCan on 16/4/20.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>


@property (nonatomic, assign) int level; // 等级
@property (nonatomic, strong) NSString *username; // 账号

@property (nonatomic, strong) NSString *password; // 密码
@property (nonatomic, strong) NSString *sell_name; // 营业厅名称
@property (nonatomic, strong) NSString *card; // 身份证号


@property (nonatomic, strong) NSString *city; // 地市
@property (nonatomic, strong) NSString *area;// 三级单元

@property (nonatomic, strong) NSString *area2;// 四级单元
@property (nonatomic, strong) NSString *address;// 地址
@property (nonatomic, strong) NSString *name;// 姓名

@property (nonatomic, strong) NSString *phone;// 手机号码
@property (nonatomic, strong) NSString *threeG; // 3G发展人编码
@property (nonatomic, strong) NSString *fourG; // 4G发展人编码

@property (nonatomic, strong) NSString *dz_flag; // 是否是队长
@property (nonatomic, strong) NSString *channel_id; //  渠道


@end
