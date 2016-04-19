//
//  StoreViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "MbProgressHUD.h"

@interface StoreViewController : BaseViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

//加载提示
@property (nonatomic,strong) MBProgressHUD *toast;

@end
