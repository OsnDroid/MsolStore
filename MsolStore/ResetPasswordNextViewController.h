//
//  ResetPasswordNextViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/19.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "ResetDelegate.h"
#import "LoginDelegate.h"

@interface ResetPasswordNextViewController : BaseViewController<LoginDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_pwd;


@property (weak, nonatomic) IBOutlet UITextField *tf_pwd_again;

@property (nonatomic,strong) NSString *resetPhone;
@property (nonatomic,strong) NSString *resetCode;
@property (assign, nonatomic) id <ResetDelegate> delegate;

- (IBAction)action_next:(id)sender;

@end
