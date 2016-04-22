//
//  MyProfileViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "MyProfileViewController.h"


@interface MyProfileViewController ()


@end

@implementation MyProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的资料";
         
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.automaticallyAdjustsScrollViewInsets = false;
    self.hidesBottomBarWhenPushed = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"MyProfileInfo" ofType:@"plist"];
    self.data = [[NSMutableArray  alloc] initWithContentsOfFile:plistPath];
    [self loadLocalData];
    [self loadNetData];
}

-(void)loadNetData {
    [self showProgress:self.view content:@"校验数据"];
    AccountService *accountService = [[AccountService alloc] init];
    accountService.delegate = self;
    [accountService queryUserInfo];
}

-(void)loadLocalData {
    Account *account = [UserInfoManager getAccount];
    [[[self.data objectAtIndex:0] objectAtIndex:0] setValue:account.name forKey:@"desc"];
    [[[self.data objectAtIndex:0] objectAtIndex:1] setValue:account.card forKey:@"desc"];
    [[[self.data objectAtIndex:0] objectAtIndex:2] setValue:account.phone forKey:@"desc"];
    
    [[[self.data objectAtIndex:1] objectAtIndex:0] setValue:account.city forKey:@"desc"];
    [[[self.data objectAtIndex:1] objectAtIndex:1] setValue:account.area forKey:@"desc"];
    [[[self.data objectAtIndex:1] objectAtIndex:2] setValue:account.area2 forKey:@"desc"];
    
    [[[self.data objectAtIndex:2] objectAtIndex:0] setValue:account.channel_id forKey:@"desc"];
    [[[self.data objectAtIndex:2] objectAtIndex:1] setValue:account.sell_name forKey:@"desc"];
    [[[self.data objectAtIndex:2] objectAtIndex:2] setValue:account.dz_flag forKey:@"desc"];
    
    [[[self.data objectAtIndex:3] objectAtIndex:0] setValue:account.threeG forKey:@"desc"];
    [[[self.data objectAtIndex:3] objectAtIndex:1] setValue:account.fourG forKey:@"desc"];

}

-(void)onResponse:(id)responseObject {
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        NSDictionary *account = [responseObject objectForKey:@"info"];
        NSString *username = [account objectForKey:@"username"];
        NSString *name = [account objectForKey:@"name"];
        NSString *city = [account objectForKey:@"city"];
        NSString *area = [account objectForKey:@"area"];
        NSString *area2 = [account objectForKey:@"area2"];
        NSString *channel_id = [account objectForKey:@"channel_id"];
        NSString *sell_name = [account objectForKey:@"sell_name"];
        
        NSString *dz_flag = [account objectForKey:@"dz_flag"];
        NSString *fourg = [account objectForKey:@"fourG"];
        NSString *threeg = [account objectForKey:@"threeG"];
        NSString *card = [account objectForKey:@"card"];
        NSString *phone = [account objectForKey:@"phone"];
        
        NSString *password = [account objectForKey:@"password"];
        NSString *address = [account objectForKey:@"address"];
        int level = (int)[account objectForKey:@"level"];
        
        Account *localAcount = [[Account alloc] init];
        localAcount.name = name;
        localAcount.username = username;
        localAcount.city = city;
        localAcount.area = area;
        localAcount.channel_id = channel_id;
        
        localAcount.dz_flag = dz_flag;
        localAcount.fourG = ([NSString isBlankString:fourg]? DEFAULT_FOURG : fourg);
        localAcount.threeG = ([NSString isBlankString:threeg]? DEFAULT_THREEG : threeg);
        localAcount.card = [NSString isBlankString:card]?@"":card;
        localAcount.phone = phone;
        
        localAcount.sell_name = sell_name;
        localAcount.area2 = area2;
        localAcount.address = address;
        localAcount.password = password;
        localAcount.level = level;
        [UserInfoManager saveAccount:localAcount];
        [self loadLocalData];
        [self.tableView reloadData];
        [self toast:self.view content:@"校验成功"];
        
    } else {
        NSString *resultMsg = [responseObject objectForKey:@"msg"];
        [self prop:resultMsg];
    }
}

-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginSuccess:(BOOL)state {
    [self loadNetData];
}

// 登陆失败
-(void) onLoginFail:(id) responseObject{
    NSString *resultMsg = [responseObject objectForKey:@"message"];
    [self prop:resultMsg delegate:self];
    
}

-(void)onFinish {
    [self closeProgress];
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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8.0f;
    }else {
        return 10.0f;
    }
    
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
    cell.detailTextLabel.text = [item objectForKey:@"desc"];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
