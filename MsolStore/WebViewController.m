//
//  WebViewController.m
//  DatastreamBank
//
//  Created by OsnDroid on 15/10/14.
//  Copyright (c) 2015年 OsnDroid. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h> 
#import "UIScrollView+EmptyDataSet.h"

static NSString *url1 = @"http://ah.189.cn/jsp/Change4GCard/wapPage/managerchangCard4Wap01.jsp?dev_code=%@&storeId=&hallName=&resource=2&tjrNbr=";
static NSString *url2 = @"http://ah.189.cn/jsp/Change4GCard/wapPage/activityCard4Wap.jsp?dev_code=%@&resource=2";

@interface WebViewController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, getter=didFailLoading) BOOL failedLoading;

@end

@implementation WebViewController

-(id)initWithUrl:(NSString *)url {
    self = [super self];
    if (self) {
        _url = url;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
        self.isBottm = YES;
        self.isShare = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.emptyDataSetSource = self;
    self.webView.scrollView.emptyDataSetDelegate = self;
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
    
    if (self.isShare) {
        UIButton *button2 = [[UIButton alloc] init];
        button2.frame = CGRectMake(0, 0, 24, 24);
        [button2 setImage:[UIImage imageNamed:@"btn_share"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
        self.navigationItem.rightBarButtonItem = backItem2;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.toast = [[MBProgressHUD alloc] initWithView:self.view];
        self.toast.labelText = @"正在加载";
        self.toast.mode = MBProgressHUDModeIndeterminate;
        [self.view addSubview:self.toast];
        [self.toast show:YES];

    });
    
}

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.webView.isLoading || !self.didFailLoading) {
        return nil;
    }
    
    NSString *text = @"页面无法打开，请检查网络";
    UIColor *textColor = RGBA(125, 127, 127, 1.0);
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 2.0;
    
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"placeholder_remote"];
}


#pragma mark - UIWebViewDelegate methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.failedLoading = NO;
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    self.failedLoading = YES;
    
    [self.webView.scrollView reloadEmptyDataSet];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.toast hide:YES];
        
    });
    self.title = title;
    if (self.orderId) {
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('p_orderid').innerText='%@'",self.orderId,nil]];
    }
    
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    Account *account = [UserInfoManager getAccount];
    //js调用iOS
    //第一种情况
    //其中test1就是js的方法名称，赋给是一个block 里面是iOS代码
    //此方法最终将打印出所有接收到的参数，js参数是不固定的 我们测试一下就知道
    context[@"goUrl1"] = ^() {
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:url1,account.fourG]];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    };
    
    context[@"goUrl2"] = ^() {
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:url2,account.fourG]];
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
    
    context[@"getAddress"] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            MyLog(@"%@",obj,nil);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *address = [NSString stringWithFormat:@"%@",obj,nil];
                if (self.addressDelegate) {
                    [self.addressDelegate address:address];
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
           
            break;
        }
    };
    

//    self.label_bottom.hidden = self.isBottm;
}


-(void)shareAction {
    MyLog(@"share..",nil);
    
}


-(void)dealloc {
    [_webView stopLoading];
    _webView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
