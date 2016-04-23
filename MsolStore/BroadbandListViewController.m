//
//  BroadbandListViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BroadbandListViewController.h"
#import "BroadbandCell.h"
#import "UIImageView+WebCache.h"
#import "BroadbandPreViewController.h"

@interface BroadbandListViewController ()

@end

@implementation BroadbandListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.method isEqualToString:@"broadband"]) {
        self.title = @"单宽带";
    } else {
        self.title = @"融合套餐";
    }
    [self loadNetData];
    
}


-(void)loadNetData {
    [self showProgress:self.view content:@"加载列表"];
    BroadbandService *broadbandService = [[BroadbandService alloc] init];
    broadbandService.delegate = self;
    [broadbandService getList:self.method];
}

-(void)onResponse:(id)responseObject tag:(int)tag{
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        self.data =  [responseObject objectForKey:[self.method isEqualToString:@"broadband"]?@"broadbandinfo":@"fusioncomboinfo"];
        [self.tableView reloadData];
    } else {
        NSString *resultMsg = [responseObject objectForKey:@"message"];
        [self prop:resultMsg];
    }
    
}

-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginSuccess:(BOOL)state tag:(int)tag{
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
    return 1;
}

//这个方法用来告诉某个分组的某一行是什么数据，返回一个UITableViewCel
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"BroadbandCell";
    BroadbandCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[BroadbandCell alloc] initWithFrame:CGRectZero];
    }
    NSDictionary *dic = self.data[indexPath.row];
    if ([self.method isEqualToString:@"broadband"]) {
        cell.label_name.text = [dic objectForKey:@"product_name"];
        cell.label_price.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"current_price"],nil];
        [cell.iv_pic sd_setImageWithURL:[NSURL URLWithString:[SERVICEURL_PIC stringByAppendingString:[dic objectForKey:@"product_img"]]] placeholderImage:[UIImage imageNamed:@"ic_default_adimage.jpg"]];
    } else {
        cell.label_name.text = [dic objectForKey:@"name"];
        cell.label_price.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"current_price"],nil];
        [cell.iv_pic sd_setImageWithURL:[NSURL URLWithString:[SERVICEURL_PIC stringByAppendingString:[dic objectForKey:@"product_img"]]] placeholderImage:[UIImage imageNamed:@"ic_default_adimage.jpg"]];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中高亮
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    NSDictionary *dic = self.data[indexPath.row];
    if ([self.method isEqualToString:@"broadband"]) {
        
        BroadbandPreViewController *ctrl = [[BroadbandPreViewController alloc] initWithUrl:[NSString stringWithFormat:kd_url,[dic objectForKey:@"id"]]];
        [self.navigationController pushViewController:ctrl animated:YES];
    } else {
        
        BroadbandPreViewController *ctrl = [[BroadbandPreViewController alloc] initWithUrl:[NSString stringWithFormat:rh_url,[dic objectForKey:@"id"]]];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
