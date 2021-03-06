//
//  MineViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "IcButton.h"
#import "MyProfileViewController.h"
#import "FeedBackViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "UserInfoManager.h"
#import "ResetPasswordViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"mineitem" ofType:@"plist"];
    self.data = [[NSMutableArray  alloc] initWithContentsOfFile:plistPath];
    self.tableView.tableHeaderView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
   
    IcButton *btnLogout = [IcButton buttonWithType:UIButtonTypeCustom];
    btnLogout.frame = CGRectMake(30, 20, ScreenWidth - 60, 46);
    btnLogout.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [btnLogout setTitle:@"安全退出" forState:UIControlStateNormal];
    [btnLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    [view addSubview:btnLogout];
    self.tableView.tableFooterView = view;
    

}

#pragma mark -数据源方法
//这个方法用来告诉表格有几个分组
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data count];
}

//这个方法告诉表格第section个分段有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.data objectAtIndex:section] count];
}


//这个方法用来告诉某个分组的某一行是什么数据，返回一个UITableViewCel
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *groupedTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:groupedTableIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSArray *items = [self.data objectAtIndex:indexPath.section];
    NSDictionary *item = items[row];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.imageView.image = [UIImage imageNamed:[item objectForKey:@"icon"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中高亮
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    long section = indexPath.section;
    long row = indexPath.row;
    NSString *selabel = [self getVauleForDicByGroup:section selectRow:row];
    BaseViewController *viewCtrl = nil;
    if ([[self getVauleForDicByGroup:0 selectRow:0] isEqualToString:selabel]) {
        //我的资料
        viewCtrl =  [[MyProfileViewController alloc] init];
    }
    if ([[self getVauleForDicByGroup:0 selectRow:1] isEqualToString:selabel]) {
        //账号绑定
    }
    if ([[self getVauleForDicByGroup:1 selectRow:0] isEqualToString:selabel]) {
        //我的酬金
    }
    if ([[self getVauleForDicByGroup:2 selectRow:0] isEqualToString:selabel]) {
        //修改密码
        viewCtrl = [[ResetPasswordViewController alloc] init];
    }
    if ([[self getVauleForDicByGroup:2 selectRow:1] isEqualToString:selabel]) {
        //我要反馈
        viewCtrl = [[FeedBackViewController alloc] init];
    }
    
    if (viewCtrl) {
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    
    
}

-(id)getVauleForDicByGroup:(long) section selectRow:(long) row {
    return [[self.data objectAtIndex:section][row] objectForKey:@"title"];
}


//注销
-(void)logout:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"注销后将会移除本地缓存历史数据，下次登录将会加载最新数据。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"注销" otherButtonTitles:nil, nil];
    actionSheet.tag = 200;
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

}

#pragma mark -UIActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 200) {
        if (buttonIndex == 0) {
            [self toast:self.view content:@"注销成功"];
            [UserInfoManager clear];          
            NSString *ctrStr = @"";
            if (ScreenWidth == 320 && ScreenHeight == 480) {
                ctrStr = @"LoginViewi4Controller";
            } else{
                ctrStr = @"LoginViewController";
            }
            MyLog(ctrStr,nil);
           
            LoginViewController *loginCtrl = [[LoginViewController alloc] initWithNibName:ctrStr bundle:nil];
            BaseNavigationController *sendNav = [[BaseNavigationController alloc] initWithRootViewController:loginCtrl];
            sendNav.navigationBar.barTintColor = MSBlue;
            sendNav.navigationBar.hidden = YES;
            AppDelegate *deleteview =  (AppDelegate *)[UIApplication sharedApplication].delegate;
            deleteview.window.rootViewController = sendNav;
        }
        if (buttonIndex == 1) {
            
        }
    }
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
