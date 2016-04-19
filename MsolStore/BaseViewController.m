//
//  BaseViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}


-(void) prop {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能开发中，敬请期待..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
    
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

@end
