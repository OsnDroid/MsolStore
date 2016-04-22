//
//  BaseViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UIAlertViewDelegate>

-(void)prop;

-(void)prop:(NSString *) msg;

-(void)prop:(NSString *) msg delegate:(id) delegate;

//提示toast
-(void)toast:(UIView *) view content:(NSString *) param;
//成功带图标的提示
-(void)toastsucess:(UIView *) view content:(NSString *) param;
//加载进度
-(void)showProgress:(UIView *) view content:(NSString *) param;
-(void)closeProgress;

//加载提示
@property (nonatomic,strong) MBProgressHUD *toast;

@end
