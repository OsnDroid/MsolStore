//
//  WebViewController.m
//  DatastreamBank
//
//  Created by OsnDroid on 15/10/14.
//  Copyright (c) 2015年 OsnDroid. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h> 

static NSString *url1 = @"http://ah.189.cn/jsp/Change4GCard/wapPage/managerchangCard4Wap01.jsp?dev_code=%@&storeId=&hallName=&resource=2&tjrNbr=";
static NSString *url2 = @"http://ah.189.cn/jsp/Change4GCard/wapPage/activityCard4Wap.jsp?dev_code=%@&resource=2";

@interface WebViewController ()

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
        self.isBottm = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label_bottom.hidden = YES;
    if ([_url hasPrefix:@"http"]) {
        self.title = @"加载中...";
        NSURL *url = [NSURL URLWithString:_url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
         _webView.delegate = self;
        [_webView loadRequest:request];
    } else {
         [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        NSString *htmlString = [NSString stringWithContentsOfFile:_url encoding:NSUTF8StringEncoding error:nil];
        [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:_url]];
        _webView.delegate = self;
        self.title = @"加载中...";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.toast = [[MBProgressHUD alloc] initWithView:self.view];
        self.toast.labelText = @"正在加载";
        self.toast.mode = MBProgressHUDModeIndeterminate;
        [self.view addSubview:self.toast];
        [self.toast show:YES];

    });
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.toast hide:YES];
        
    });
    self.title = title;
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    //js调用iOS
    //第一种情况
    //其中test1就是js的方法名称，赋给是一个block 里面是iOS代码
    //此方法最终将打印出所有接收到的参数，js参数是不固定的 我们测试一下就知道
    context[@"goUrl1"] = ^() {
        MyLog([NSString stringWithFormat:url1,@"999"],nil);
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:url1,@"999"]];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    };
    context[@"goUrl2"] = ^() {
        MyLog([NSString stringWithFormat:url2,@"9991"],nil);
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:url2,@"9991"]];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    };
    
    
    context[@"goUrl3"] = ^() {
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:@"http://219.148.203.212/mstywap/jsp/checkIn/jump.jsp"];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    };
    context[@"goUrl4"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self prop];
        });
    };

//    self.label_bottom.hidden = self.isBottm;
}

-(void)dealloc {
    [_webView stopLoading];
    _webView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithUrl:(NSString *)url {
    self = [super self];
    if (self) {
        _url = url;
    }
    return self;
}

@end
