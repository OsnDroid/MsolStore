//
//  LoginViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "LoginViewController.h"
#import "ResetPasswordViewController.h"
#import "BaseNavigationController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MainController.h"
#import "AppDelegate.h"

#define lightGray RGBA(204,204,204,1.0)
int secondsCountDown;


@interface LoginViewController ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tf_phone = [self.view viewWithTag:10];
    self.tf_pwd = [self.view viewWithTag:11];
    self.tf_yzm = [self.view viewWithTag:12];
    self.btn_forgotPwd = [self.view viewWithTag:14];
    self.btn_code = [self.view viewWithTag:13];
    self.btn_login = [self.view viewWithTag:15];
    [self.btn_forgotPwd addTarget:self action:@selector(actionForgotPwd:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_code addTarget:self action:@selector(actionCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_login addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    //
    
    self.tf_phone.text = @"18055199998";
    self.tf_pwd.text = @"000000";
    self.tf_yzm.text = @"123456";
   
}



- (void)actionForgotPwd:(id)sender {
    ResetPasswordViewController *vctr = [[ResetPasswordViewController alloc] init];
    [self.navigationController pushViewController:vctr animated:YES];
}

- (void)actionCode:(id)sender {
    NSString *phone = [self.tf_phone text];
    if (![NSString isMobileNumber:phone]) {
        [self prop:@"请输入正确的手机号"];
        return;
    }
    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView:self.view];
    toast.labelText = @"正在发送";
    toast.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:toast];
    [toast show:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"phone": phone};
    NSString *url = [SERVICEURL stringByAppendingString:@"msty/send"];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [toast hide:YES];
        MyLog(@"%@",responseObject,nil);
        NSString *result = [responseObject objectForKey:@"code"];
        if ([result isEqualToString:@"000"]) {
            [self toast:self.view content:@"短信发送成功"];
            secondsCountDown = 60;
            [_btn_code setEnabled:NO];
            [_btn_code setBackgroundColor:lightGray];
            [ _btn_code setTitle:@"(60)重新获取" forState:UIControlStateNormal];
            [_btn_code setBackgroundColor:[UIColor lightGrayColor]];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        } else {
            NSString *resultMsg = [responseObject objectForKey:@"message"];
            [self toast:self.view content:resultMsg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [toast hide:YES];
        MyLog(@"%@",error,nil);
        NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
        [self prop:param];
    }];

}


- (void)actionLogin:(id)sender {
    NSString *phone = [self.tf_phone text];
    NSString *pwd = [self.tf_pwd text];
    NSString *yzm = [self.tf_yzm text];
    if (![NSString isMobileNumber:phone]) {
        [self prop:@"请输入正确的手机号"];
        return;
    }
    if ([NSString isBlankString:pwd]) {
        [self prop:@"请输入密码"];
        return;
    }
    if (![NSString isSixCodeNumber:yzm]) {
        [self prop:@"请输入正确的验证码"];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parameters = @{@"phone": phone,
                                 @"password":pwd,
                                 @"verificationcode":yzm};
    
    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView:self.view];
    toast.labelText = @"正在登录";
    toast.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:toast];
    [toast show:YES];
    
    [manager POST:[SERVICEURL stringByAppendingString:@"msty/loginByVcode"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [toast hide:YES];
//        MyLog(@"%@",responseObject,nil);
        NSString *result = [responseObject objectForKey:@"code"];
        if ([result isEqualToString:@"000"]) {
            NSDictionary *account = [responseObject objectForKey:UserInfo];
            NSString *username = [account objectForKey:@"username"];
            NSString *name = [account objectForKey:@"name"];
            NSString *city = [account objectForKey:@"city"];
            NSString *area = [account objectForKey:@"area"];
            NSString *area2 = [account objectForKey:@"area2"];
            NSString *channel_id = [account objectForKey:@"channel_id"];
            NSString *sell_name = [account objectForKey:@"sell_name"];
            
            NSString *dz_flag = [account objectForKey:@"dz_flag"];
            NSString *fourg = [account objectForKey:@"fourg"];
            NSString *threeg = [account objectForKey:@"threeg"];
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
            BOOL isSavesuccess = [UserInfoManager saveAccount:localAcount];
            if (isSavesuccess) {
                Account *sc = [UserInfoManager getAccount];
                MyLog(@"%@",sc.name,nil);
                MyLog(@"%@",sc.username,nil);
                MyLog(@"%@",sc.city,nil);
                MyLog(@"%@",sc.channel_id,nil);
                MyLog(@"%@",sc.dz_flag,nil);
                
                MyLog(@"%@",sc.fourG,nil);
                MyLog(@"%@",sc.threeG,nil);
                MyLog(@"%@",[NSString isBlankString:sc.card]?@"1111":@"22222",nil);
                MyLog(@"%@",sc.address,nil);
                MyLog(@"%@",sc.password,nil);
                
                MyLog(@"%@",sc.sell_name,nil);
                MyLog(@"%@",sc.area,nil);
                MyLog(@"%@",sc.area2,nil);
                MyLog(@"%@",sc.phone,nil);
                MyLog(@"%d",sc.level,nil);
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MainController *mctrl = [story instantiateInitialViewController];
                AppDelegate *deleteview =  (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                [UIView transitionFromView:deleteview.window.rootViewController.view
                                    toView:mctrl.view
                                  duration:1.0
                                   options:UIViewAnimationOptionTransitionCurlUp
                                completion:^(BOOL finished)
                 {
                     deleteview.window.rootViewController  = mctrl;
                     
                 }];
//                 [self toast:self.view content:@"登陆成功"];

//                [UserInfoManager clear];
//                sc = [UserInfoManager getAccount];
//                MyLog(@"%@",sc?@"-------":@"======");
            } else {
            
                [self toast:self.view content:@"登录失败，请重试！"];
            }
            
        } else {
            NSString *resultMsg = [responseObject objectForKey:@"message"];
            [self prop:resultMsg];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [toast hide:YES];
        NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
        [self prop:param];
    }];

}


- (void)updateTimer {
    [ _btn_code setTitle:[NSString stringWithFormat:@"(%d)重新获取",secondsCountDown] forState:UIControlStateNormal];
    secondsCountDown--;
    if(secondsCountDown == 0){
        [_btn_code setTitle:@"重发" forState:UIControlStateNormal];
        [self.timer invalidate];
        [_btn_code setEnabled:YES];
        [_btn_code setBackgroundColor:MSBlue];
    }
}


#pragma mark －生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
       
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
