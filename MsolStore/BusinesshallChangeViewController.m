//
//  BusinesshallChangeViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/22.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BusinesshallChangeViewController.h"
#import "BusinesshallCell.h"

@interface BusinesshallChangeViewController ()

@property (nonatomic,strong) UITableViewCell *selCell;

@end

@implementation BusinesshallChangeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"结对营业厅";
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self loadNetData];
}

-(void)loadNetData {
    [self showProgress:self.view content:@"正在查询"];
    BBHService *bbhService = [[BBHService alloc] init];
    bbhService.delegate = self;
    bbhService.tag = 10;
    [bbhService getList];
}


-(void)onResponse:(id)responseObject tag:(int)tag{
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        if (tag == 10) {
            self.data =  [responseObject objectForKey:@"info"];
            [self.tableView reloadData];
        }else if (tag == 20) {
            [self.delegate onCompleteSuccess];
            [self.navigationController popViewControllerAnimated:YES];
        }
       
    } else {
        NSString *resultMsg = [responseObject objectForKey:@"msg"];
        [self prop:resultMsg];
    }
   
}

-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginSuccess:(BOOL)state tag:(int)tag{
    if (tag == 10) {
        [self loadNetData];
    }
    if (tag == 20) {
        [self update];
    }
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
    static NSString *identify = @"BusinesshallCell";
    BusinesshallCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[BusinesshallCell alloc] initWithFrame:CGRectZero];
    }
    NSDictionary *dic = self.data[indexPath.row];
    cell.label_name.text = [dic objectForKey:pch_sellName];
    cell.resetUsrname = [dic objectForKey:pch_username];
    cell.label_num.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"num"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 取消选中高亮
    // 取消选中高亮
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    if ([_selCell isEqual:[tableView cellForRowAtIndexPath:indexPath]]) {
        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        _selCell = nil;
    } else {
        _selCell = [tableView cellForRowAtIndexPath:indexPath];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)actionReset:(id)sender {
    if (self.selCell) {
        [self update];
    } else {
        [self toast:self.view content:@"您没有选择要更换的营业厅"];
    }
}

-(void)update {
    [self showProgress:self.view content:@"正在更换"];
    BusinesshallCell * precell = (BusinesshallCell *)_selCell;
    BBHService *bbhService = [[BBHService alloc] init];
    bbhService.tag = 20;
    bbhService.delegate = self;
    [bbhService update:precell.resetUsrname];
}


@end
