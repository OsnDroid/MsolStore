//
//  AppDelegate.m
//  MsolStore
//
//  Created by hlkj-mbpro on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "LoginViewController.h"
#import "NSString+Phone.h"
#import "UserInfoManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "BaseNavigationController.h"
#import "SDImageCache.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"

//10d931fa097c2
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [application setStatusBarStyle:UIStatusBarStyleLightContent];//设置全局状态栏颜色
    [application setStatusBarHidden:NO]; //启动的时候设置显示, 启动后要打开
    
    
    NSString *bundledPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"IoCanImages"];
    [[SDImageCache sharedImageCache] addReadOnlyCachePath:bundledPath];
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:50 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"10d931fa097c2"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformSubTypeWechatSession),
                            @(SSDKPlatformSubTypeWechatTimeline),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformSubTypeQZone),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformSubTypeQQFriend),
                            @(SSDKPlatformTypeSMS)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
            default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"2450713256"
                                           appSecret:@"9f56ec5bd43229c59b354bb33054fe5f"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxc2aaa358aa9d2e25"
                                       appSecret:@"f390756aff0661fc288a875e6f8b0844"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105320532"
                                      appKey:@"KEYh2kwlBMktTU19uBF"
                                    authType:SSDKAuthTypeBoth];
                 break;
            default:
                 break;
         }
     }];
    
    Account *sc = [UserInfoManager getAccount];

    if (sc) {
        //主页面
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainController *tab = [story instantiateInitialViewController];
        self.window.rootViewController = tab;
        [self.window makeKeyAndVisible];
    } else {
        //登录页面
        NSString *ctrStr = @"";
        if (ScreenWidth == 320 && ScreenHeight == 480) {
            ctrStr = @"LoginViewi4Controller";
        } else{
            ctrStr = @"LoginViewController";
        }
        LoginViewController *loginCtrl = [[LoginViewController alloc] initWithNibName:ctrStr bundle:nil];
        BaseNavigationController *sendNav = [[BaseNavigationController alloc] initWithRootViewController:loginCtrl];
        sendNav.navigationBar.barTintColor = MSBlue;
        sendNav.navigationBar.hidden = YES;
        AppDelegate *deleteview =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        deleteview.window.rootViewController = sendNav;
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
