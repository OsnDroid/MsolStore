//
//  ResetPasswordSuccessViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ResetPasswordSuccessViewController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"

@interface ResetPasswordSuccessViewController ()

@end

@implementation ResetPasswordSuccessViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"重置密码";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
}


- (IBAction)action_ok:(id)sender {
    
    Account *account = [UserInfoManager getAccount];
    if (account) {
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
        
    } else {
        [self.navigationController dismissViewControllerAnimated:NO completion:^{
            
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
