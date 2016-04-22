//
//  LoginViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "IcButton.h"

@interface LoginViewController : BaseViewController

@property (nonatomic, strong) UITextField *tf_phone;
@property (nonatomic, strong) UITextField *tf_pwd;
@property (nonatomic, strong) UITextField *tf_yzm;

@property (nonatomic, strong) IcButton *btn_code;
@property (nonatomic, strong) IcButton *btn_forgotPwd;
@property (nonatomic, strong) IcButton *btn_login;


@end
