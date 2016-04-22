//
//  FeedBackViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AccountService.h"

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
  
    self.tv_content.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.tv_content.layer.borderWidth = 0.4;
    self.tv_content.layer.cornerRadius = 6;
    self.tv_content.layer.masksToBounds = YES;
    self.tv_content.placeholder = @"请留下您宝贵的意见或建议，一旦被采纳，您将有机会获得惊喜奖品";

    
}


- (IBAction)submit:(id)sender {
    [self submit];
}

-(void)submit {
    [self.tv_link resignFirstResponder];
    [self.tv_content resignFirstResponder];
    NSString *phone = [self.tv_link text];
    NSString *content = [self.tv_content text];
    if ([NSString isBlankString:phone]) {
        [self prop:@"请输入联系方式!"];
        return;
    }
    
    if ([NSString isBlankString:content]) {
        [self prop:@"请输入您的建议或意见!"];
        return;
    }
    [self showProgress:self.view content:@"正在提交"];
    AccountService *accountService = [[AccountService alloc] init];
    accountService.delegate = self;
    [accountService submitOpinion:phone content:content];
}

-(void)onFinish {
    [self closeProgress];
}

-(void)onResponse:(id)responseObject {
    NSString *resultMsg = [responseObject objectForKey:@"message"];
    NSString *code = [responseObject objectForKey:@"code"];
    if ([code isEqualToString:@"000"]) {
        self.tv_link.text = @"";
        self.tv_content.text = @"";
    }
    [self toast:self.view content:resultMsg];
}


-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginFail:(id)responseObject{
    NSString *resultMsg = [responseObject objectForKey:@"message"];
    [self prop:resultMsg delegate:self];
}

-(void)onLoginSuccess:(BOOL)state {
    [self submit];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
