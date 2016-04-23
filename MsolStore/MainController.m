//
//  MainController.m
//  MsolStore
//
//  Created by hlkj-mbpro on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "MainController.h"
#import "LoginService.h"
#import "LoginViewController.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"

@interface MainController ()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    self.hud.labelText = @"自动登录";
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    LoginService *loginService = [[LoginService alloc] init];
    loginService.delegate = self;
    [loginService login];

}

//登陆成功
-(void) onLoginSuccess:(BOOL) state tag:(int)tag{
    [self toast:self.view content:(state?@"登陆成功":@"登陆失败")];
}

// 登陆失败
-(void) onLoginFail:(id) responseObject{
    NSString *resultMsg = [responseObject objectForKey:@"message"];
    [self prop:resultMsg];

}
//网络异常
-(void) onError:(NSError *)error{
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message: [NSString isBlankString:param]?@"服务器返回空集合数据":param delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];

}

-(void) onFinish{
  [self.hud hide:YES];
}


-(void)prop:(NSString *) msg {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message: [NSString isBlankString:msg]?@"服务器返回空集合数据":msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [UserInfoManager clear];
    NSString *ctrStr = @"";
    if (ScreenWidth == 320 && ScreenHeight == 480) {
        ctrStr = @"LoginViewi4Controller";
    } else{
        ctrStr = @"LoginViewController";
    }
    MyLog(ctrStr,nil);
    
    LoginViewController *loginCtrl = [[LoginViewController alloc] initWithNibName:ctrStr bundle:nil];
    BaseNavigationController *sendNav = [[BaseNavigationController alloc] initWithRootViewController:loginCtrl];
    sendNav.navigationBar.barTintColor = MSBlue;
    sendNav.navigationBar.hidden = YES;
    AppDelegate *deleteview =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    deleteview.window.rootViewController = sendNav;
}

#pragma mark - 消息提示
-(void)toast:(UIView *) view content:(NSString *) param{
    MBProgressHUD *toast = [[MBProgressHUD alloc] initWithView:view];
    toast.labelText = param;
    toast.yOffset = ScreenHeight/2-100;
    toast.userInteractionEnabled = NO;
    toast.mode = MBProgressHUDModeText;
    [self.view addSubview:toast];
    [toast show:YES];
    [toast hide:YES afterDelay:2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}


@end
