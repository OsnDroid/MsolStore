//
//  FeedBackViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "UIPlaceholderTextView.h"
#import "LoginDelegate.h"

@interface FeedBackViewController : BaseViewController<LoginDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tv_link;
@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *tv_content;


- (IBAction)submit:(id)sender;
@end
