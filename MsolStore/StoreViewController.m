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
#import "IcQRCode.h"
#import "KLCPopup.h"
#import "IcButton.h"
#import "UIImage+RoundedRectImage.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


static NSString *myurl = @"http://ln212.huilongkj.com/msty_app/?username=%@";
@interface StoreViewController ()

@property (strong, nonatomic) UIImageView *imgVQRCode;
@property (strong,nonatomic) NSString *loadurl;

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
    Account *account = [UserInfoManager getAccount];
    self.loadurl = [NSString stringWithFormat:myurl,account.username];
    NSURL *url = [NSURL URLWithString:self.loadurl];
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
    if (![tmpurl isEqualToString:self.loadurl]) {
        WebViewController *webView = [[WebViewController alloc] initWithUrl:tmpurl];
        webView.isShare = YES;
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
 
    [self layoutUI];
 
}

-(void)shareAction {
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"share_img"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
}


- (void)layoutUI {
    CGFloat v_space = 20;
    CGFloat contentWidth = ScreenWidth*2/3;
    CGFloat btnWidth = (contentWidth - v_space*3)/2;
    CGFloat btnHeight = 36;
    CGFloat imgLength = contentWidth - v_space*2;
    
    self.imgVQRCode= [[UIImageView alloc] initWithFrame:CGRectMake(v_space, v_space, imgLength, imgLength)];
    //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
    CIImage *imgQRCode = [IcQRCode createQRCodeImage:self.loadurl];
  
    //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
    UIImage *imgAdaptiveQRCode = [IcQRCode resizeQRCodeImage:imgQRCode
                                                    withSize:self.imgVQRCode.frame.size.width];
    //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
    UIImage *imgIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"share_img"]
                                              withSize:CGSizeMake(50, 50)
                                            withRadius:10];
    //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
    imgAdaptiveQRCode = [IcQRCode addIconToQRCodeImage:imgAdaptiveQRCode
                                              withIcon:imgIcon
                                          withIconSize:imgIcon.size];
    
    //    imgAdaptiveQRCode = [IcQRCode addIconToQRCodeImage:imgAdaptiveQRCode
    //                                              withIcon:imgIcon
    //                                             withScale:3];
    
   
    self.imgVQRCode.image = imgAdaptiveQRCode;
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth,contentWidth + v_space +btnHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 6;
//    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentView addSubview:self.imgVQRCode];
    
    IcButton *okBtn = [[IcButton alloc] initWithFrame:CGRectMake(v_space, contentWidth, btnWidth, btnHeight)];
    [okBtn addTarget:self action:@selector(okButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    okBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [okBtn setTitle:@"保存" forState:UIControlStateNormal];
    [contentView addSubview:okBtn];
    
    IcButton *dismissBtn = [[IcButton alloc] initWithFrame:CGRectMake(v_space*2 + btnWidth, contentWidth, btnWidth, btnHeight)];
    [dismissBtn addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    dismissBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [dismissBtn setTitle:@"取消" forState:UIControlStateNormal];
    [contentView addSubview:dismissBtn];
    
//    NSDictionary *views = NSDictionaryOfVariableBindings(contentView,imgVQRCode,okBtn);
//    
//    
//    [contentView addConstraints:
//     @[[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(16)-[imgVQRCode]-(10)-[okBtn]-(24)-|"
//                                             options:NSLayoutFormatAlignAllCenterX
//                                             metrics:nil
//                                               views:views],
//    [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(16)-[imgVQRCode]-(10)-[dismissBtn]-(24)-|"
//                                            options:NSLayoutFormatAlignAllCenterX
//                                            metrics:nil
//                                              views:views],
//     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(36)-[okBtn(dismissBtn)]-(10)-[dismissBtn]-(36)-|"
//        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(36)-[imgVQRCode]-(36)-|"
//                                             options:0
//                                             metrics:nil
//                                               views:views]]];
    
    
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeGrowIn
                                         dismissType:KLCPopupDismissTypeShrinkOut
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
   [popup show];
}


- (void)dismissButtonPressed:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
}

- (void)okButtonPressed:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
    int author = [ALAssetsLibrary authorizationStatus];
    if(author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied) {
        // The user has explicitly denied permission for media capture.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在iPhone的\"设置-隐私-照片\"中允许\"码上天翼\"访问照片。"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imgVQRCode.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"保存失败";
    if (!error) {
        message = @"保存成功";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
    [self toast:self.view content:message];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
