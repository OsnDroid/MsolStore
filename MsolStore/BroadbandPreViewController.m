//
//  BroadbandPreViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BroadbandPreViewController.h"
#import "HandleOrdersViewController.h"

@interface BroadbandPreViewController ()

@end

@implementation BroadbandPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加载中...";
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];
    [self showProgress:self.view content:@"正在加载"];
   }


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self closeProgress];
    self.title = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc {
    [_webView stopLoading];
    _webView = nil;
}


-(id)initWithUrl:(NSString *)url {
    self = [super self];
    if (self) {
        _url = url;
    }
    return self;
}


- (IBAction)actionSubmit:(id)sender {
    
    HandleOrdersViewController *ctrl = [[HandleOrdersViewController alloc] init];
    ctrl.proudctId = self.proudctId;
    ctrl.picUrl = _picUrl;
    ctrl.productName = _productName;
    ctrl.prudctType = _prudctType;
    ctrl.proudctPrice = _proudctPrice;
    [self.navigationController pushViewController:ctrl animated:YES];
}
@end
