//
//  ResetPasswordViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "IcButton.h"
#import "ResetDelegate.h"

@interface ResetPasswordViewController : BaseViewController<ResetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_phone;

@property (weak, nonatomic) IBOutlet UITextField *tf_yzm;

@property (weak, nonatomic) IBOutlet IcButton *btn_code;

- (IBAction)actionOk:(id)sender;

- (IBAction)actionCode:(id)sender;


@end
