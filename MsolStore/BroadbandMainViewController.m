//
//  BroadbandMainViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/22.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BroadbandMainViewController.h"
#import "BroadbandListViewController.h"

@interface BroadbandMainViewController ()

@end

@implementation BroadbandMainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"融合套餐";
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)action1:(id)sender {
    BroadbandListViewController *ctrl = [[BroadbandListViewController alloc] init];
    ctrl.method = @"fusionCombo";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (IBAction)action2:(id)sender {
    BroadbandListViewController *ctrl = [[BroadbandListViewController alloc] init];
    ctrl.method = @"broadband";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}
@end
