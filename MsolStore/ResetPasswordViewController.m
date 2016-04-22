//
//  ResetPasswordViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPasswordNextViewController.h"
#import "AFHTTPRequestOperationManager.h"
#define lightGray RGBA(204,204,204,1.0)


@interface ResetPasswordViewController ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, assign) int secondsCountDown;

@end

@implementation ResetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"重置密码";
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    Account *account = [UserInfoManager getAccount];
    if (account) {
        self.tf_phone.text = account.phone;
        [self.tf_phone setEnabled:false];
    }
}

-(void) onResetSuccess:(BOOL) state {
   [self.navigationController dismissViewControllerAnimated:NO completion:^{
       
   }];
}

- (IBAction)actionOk:(id)sender {
    NSString *phone = self.tf_phone.text;
    NSString *code = self.tf_yzm.text;
    if (![NSString isMobileNumber:phone]) {
        [self prop:@"请输入正确的手机号"];
        return;
    }
    if (![NSString isSixCodeNumber:code]) {
        [self prop:@"请输入正确的验证码"];
        return;
    }
    ResetPasswordNextViewController *ctrl = [[ResetPasswordNextViewController alloc] init];
    ctrl.resetPhone = phone;
    ctrl.resetCode = code;
    ctrl.delegate = self;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctrl animated:YES];
    
}

- (IBAction)actionCode:(id)sender {
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
            self.secondsCountDown = 60;
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

- (void)updateTimer {
    [ _btn_code setTitle:[NSString stringWithFormat:@"(%d)重新获取",self.secondsCountDown] forState:UIControlStateNormal];
    self.secondsCountDown--;
    if(self.secondsCountDown == 0){
        [_btn_code setTitle:@"重发" forState:UIControlStateNormal];
        [self.timer invalidate];
        [_btn_code setEnabled:YES];
        [_btn_code setBackgroundColor:MSBlue];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
