//
//  StoreViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "StoreViewController.h"
#import "WebViewController.h"
#import "MBProgressHUD.h"

static NSString *myurl = @"http://ln212.huilongkj.com/msty_app/?username=AAAAAC";
@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺";
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 24, 24);
    [button setImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(qrcodeAction) forControlEvents:UIControlEventTouchUpInside];
 
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIButton *button2 = [[UIButton alloc] init];
    button2.frame = CGRectMake(0, 0, 24, 24);
    [button2 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = backItem2;
    
    
    self.navigationItem.title = @"加载中...";
    NSURL *url = [NSURL URLWithString:myurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];
    self.toast = [[MBProgressHUD alloc] initWithView:self.view];
    self.toast.labelText = @"正在加载";
    self.toast.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:self.toast];
    [self.toast show:YES];
   
    

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *tmpurl = request.URL.absoluteString;
    if (![tmpurl isEqualToString:myurl]) {
        WebViewController *webView = [[WebViewController alloc] initWithUrl:tmpurl];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webView animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        return false;
    }
    MyLog(request.URL.absoluteString,nil);
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title =  title;
    [self.toast hide:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self.toast hide:YES];
}

-(void)dealloc {
    [_webView stopLoading];
    _webView = nil;
}

-(void)qrcodeAction {

    MyLog(@"qrcode..",nil);
 
}

-(void)shareAction {
    MyLog(@"share..",nil);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
