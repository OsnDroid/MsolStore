//
//  FeedBackViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@end

@implementation FeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"意见反馈";
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.tv_link.textColor = [UIColor lightGrayColor];
    self.tv_link.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.tv_link.layer.borderWidth = 0.4;
    self.tv_link.layer.cornerRadius = 6;
    self.tv_link.layer.masksToBounds = YES;
  
    
    self.tv_content.delegate = self;
    self.tv_content.textColor = [UIColor lightGrayColor];
    self.tv_content.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.tv_content.layer.borderWidth = 0.4;
    self.tv_content.layer.cornerRadius = 6;
    self.tv_content.layer.masksToBounds = YES;


    
}

#pragma mark -  txt代理实现
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.tv_content.text=@"";
    self.tv_content.textColor = [UIColor blackColor];
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submit:(id)sender {
}
@end
