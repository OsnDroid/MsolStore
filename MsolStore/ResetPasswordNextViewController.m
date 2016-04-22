//
//  ResetPasswordNextViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ResetPasswordNextViewController.h"
#import "ResetPasswordSuccessViewController.h"
#import "AccountService.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface ResetPasswordNextViewController ()

@end

@implementation ResetPasswordNextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"重置密码";
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//     self.navigationController.navigationBar.hidden = NO;
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)action_next:(id)sender {
    [self reset];
}

-(void)reset{
    NSString *pwd = self.tf_pwd.text;
    NSString *pwd2 = self.tf_pwd_again.text;
    if (![NSString isSixCodeNumber:pwd]) {
        [self prop:@"密码必须6位纯数字！"];
        return;
    }
    if (![pwd isEqualToString:pwd2]) {
        [self prop:@"两次密码不一样！"];
        return;
    }
    [self showProgress:self.view content:@"正在修改"];
    AccountService *accountService = [[AccountService alloc] init];
    accountService.delegate = self;
    [accountService resetPassword:self.resetPhone newPwd:pwd code:self.resetCode];
}


-(void)onResponse:(id)responseObject {
    NSString *code = [responseObject objectForKey:@"code"];
    if ([@"000" isEqualToString:code]) {
        //成功
        [self.delegate onResetSuccess:YES];
        ResetPasswordSuccessViewController *ctrl = [[ResetPasswordSuccessViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:ctrl animated:YES];
        [self.navigationController dismissViewControllerAnimated:NO completion:^{
            
        }];
       
    }else{
        [self prop:[responseObject objectForKey:@"message"]];
    }
}

-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginSuccess:(BOOL)state {
    [self reset];
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


@end
