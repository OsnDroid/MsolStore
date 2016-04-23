//
//  BusineshallViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/22.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BusineshallViewController.h"


@interface BusineshallViewController ()

@end

@implementation BusineshallViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"结对营业厅";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNetData];
}

-(void)loadNetData {
    [self showProgress:self.view content:@"正在查询"];
    AccountService *accountService = [[AccountService alloc] init];
    accountService.delegate = self;
    [accountService queryUserInfo];
}


-(void)onResponse:(id)responseObject tag:(int)tag{
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        NSDictionary *account = [responseObject objectForKey:@"info"];
        NSString *username = [account objectForKey:@"username"];
        NSString *name = [account objectForKey:@"name"];
        NSString *city = [account objectForKey:@"city"];
        NSString *area = [account objectForKey:@"area"];
        NSString *area2 = [account objectForKey:@"area2"];
        NSString *channel_id = [account objectForKey:@"channel_id"];
        NSString *sell_name = [account objectForKey:@"sell_name"];
        
        NSString *dz_flag = [account objectForKey:@"dz_flag"];
        NSString *fourg = [account objectForKey:@"fourG"];
        NSString *threeg = [account objectForKey:@"threeG"];
        NSString *card = [account objectForKey:@"card"];
        NSString *phone = [account objectForKey:@"phone"];
        
        NSString *password = [account objectForKey:@"password"];
        NSString *address = [account objectForKey:@"address"];
        int level = (int)[account objectForKey:@"level"];
        
        Account *localAcount = [[Account alloc] init];
        localAcount.name = name;
        localAcount.username = username;
        localAcount.city = city;
        localAcount.area = area;
        localAcount.channel_id = channel_id;
        
        localAcount.dz_flag = dz_flag;
        localAcount.fourG = ([NSString isBlankString:fourg]? DEFAULT_FOURG : fourg);
        localAcount.threeG = ([NSString isBlankString:threeg]? DEFAULT_THREEG : threeg);
        localAcount.card = [NSString isBlankString:card]?@"":card;
        localAcount.phone = phone;
        
        localAcount.sell_name = sell_name;
        localAcount.area2 = area2;
        localAcount.address = address;
        localAcount.password = password;
        localAcount.level = level;
        [UserInfoManager saveAccount:localAcount];
        [self toast:self.view content:@"查询成功"];
        
        NSString *content = @"甩单营业厅：%@\n负责人明明：%@\n联系电话：%@\n所属地市：%@\n所属三级单元：%@\n所属四级单元：%@\n详细地址：%@";
        self.label_content.text = [NSString stringWithFormat:content,localAcount.sell_name
                                   ,localAcount.name,localAcount.phone,localAcount.city,localAcount.area
                                   ,localAcount.area2,localAcount.address,nil];
        
    } else {
        NSString *resultMsg = [responseObject objectForKey:@"msg"];
        [self prop:resultMsg];
    }
}

-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginSuccess:(BOOL)state tag:(int)tag{
    [self loadNetData];
}

// 登陆失败
-(void) onLoginFail:(id) responseObject{
    NSString *resultMsg = [responseObject objectForKey:@"message"];
    [self prop:resultMsg delegate:self];
    
}

-(void)onFinish {
    [self closeProgress];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionReset:(id)sender {
    self.hidesBottomBarWhenPushed = YES;
    BusinesshallChangeViewController *ctrl = [[BusinesshallChangeViewController alloc] init];
    ctrl.delegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
}

-(void)onCompleteSuccess {
    [self loadNetData];
}
@end
