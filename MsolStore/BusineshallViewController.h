//
//  BusineshallViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/22.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountService.h"
#import "BusinesshallChangeViewController.h"

@interface BusineshallViewController : BaseViewController<LoginDelegate,CompleteDelegate>



- (IBAction)actionReset:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *label_content;

@end
