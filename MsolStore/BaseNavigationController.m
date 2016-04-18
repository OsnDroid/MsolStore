//
//  BaseNavigationController.m
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barStyle = UIBaselineAdjustmentNone;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//
//    MyLog(@"push ....",nil);
//    self.hidesBottomBarWhenPushed = YES;
//    [super pushViewController:viewController animated:animated];
//    self.hidesBottomBarWhenPushed = YES;
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
