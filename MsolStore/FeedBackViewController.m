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
// 
//    self.tv_link.textColor = [UIColor lightGrayColor];
    self.tv_link.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.tv_link.layer.borderWidth = 0.4;
    self.tv_link.layer.cornerRadius = 6;
    self.tv_link.layer.masksToBounds = YES;
  
    
 
    self.tv_content.textColor = RGBA(170, 170, 170, 0.6);
    self.tv_content.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.tv_content.layer.borderWidth = 0.4;
    self.tv_content.layer.cornerRadius = 6;
    self.tv_content.layer.masksToBounds = YES;
    self.tv_content.placeholder = @"请留下您宝贵的意见或建议，一旦被采纳，您将有机会获得惊喜奖品";

    
}

//#pragma mark -  txt代理实现
//-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    self.tv_content.text=@"";
//    self.tv_content.textColor = [UIColor blackColor];
//    return YES;
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)submit:(id)sender {
}
@end
