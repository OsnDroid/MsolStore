//
//  FeedBackViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedBackViewController : BaseViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tv_link;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;


- (IBAction)submit:(id)sender;
@end
