//
//  BaseViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@property (nonatomic,strong) MBProgressHUD *hud;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
        
    }
}


-(void) prop {
    [self prop:@"功能开发中，敬请期待..."];
}

-(void)prop:(NSString *) msg {
    [self prop:msg delegate:nil];
}

-(void)prop:(NSString *) msg delegate:(id) delegate {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message: [NSString isBlankString:msg]?@"服务器返回空集合数据":msg delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
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
    _toast = [[MBProgressHUD alloc] initWithView:view];
    _toast.labelText = param;
    _toast.mode = MBProgressHUDModeText;
    _toast.yOffset = ScreenHeight/2-100;
    [self.view addSubview:_toast];
    [_toast show:YES];
    [_toast hide:YES afterDelay:2];
}

-(void)toastsucess:(UIView *) view content:(NSString *) param{
    _toast = [[MBProgressHUD alloc] initWithView:view];
    _toast.labelText = param;
    _toast.mode = MBProgressHUDModeCustomView;
    _toast.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    _toast.labelText = param;
    [self.view addSubview:_toast];
    [_toast show:YES];
    [_toast hide:YES afterDelay:2];
}

-(void)showProgress:(UIView *) view content:(NSString *) param{
    if (self.hud && !self.hud.isHidden) {
        return;
    }
    self.hud = [[MBProgressHUD alloc] initWithView:view];
    self.hud.labelText = param;
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}

-(void)closeProgress {
    if (self.hud) {
        [self.hud hide:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
