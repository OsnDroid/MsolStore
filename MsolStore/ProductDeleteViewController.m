//
//  ProductDeleteViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ProductDeleteViewController.h"
#import "ProductDeleteCell.h"
#import "UIImageView+WebCache.h"

@interface ProductDeleteViewController ()

@end

@implementation ProductDeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品仓库";
    [self loadNetData];
}


-(void)loadNetData {
    [self showProgress:self.view content:@"加载列表"];
    ProductService *productService = [[ProductService alloc] init];
    productService.delegate = self;
    productService.tag = 1;
    self.chkdata = [[NSMutableArray alloc] init];
    [productService getOwnProducts];
}

-(void)onResponse:(id)responseObject tag:(int)tag{
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        if (tag == 1) {
            self.data =  [responseObject objectForKey:@"info"];
            for (int i=0; i<self.data.count; i++) {
                [self.chkdata addObject:@"1"];
            }
            [self.tableView reloadData];
        } else if(tag == 2){
        
            if (self.deletegate) {
                [self.navigationController popViewControllerAnimated:YES];
                [self.deletegate onProductDeleteSuccess];
            }
            
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
    if (tag == 1) {
       [self loadNetData];
    } else if(tag == 2) {
       [self delete];
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
    static NSString *identify = @"ProductDeleteCell";
    ProductDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[ProductDeleteCell alloc] initWithFrame:CGRectZero];
    }
    NSDictionary *dic = self.data[indexPath.row];
    cell.label_name.text = [dic objectForKey:@"productName"];
    cell.label_price.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"price"],nil];
    [cell.iv_pic sd_setImageWithURL:[NSURL URLWithString:[SERVICEURL_PIC stringByAppendingString:[dic objectForKey:@"img"]]] placeholderImage:[UIImage imageNamed:@"ic_default_adimage.jpg"]];
    cell.btn_check.selected = [self.chkdata[indexPath.row] isEqualToString:@"0"];
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
    NSString *tmp = [self.chkdata objectAtIndex:indexPath.row];
    if ([tmp isEqualToString:@"1"]) {
        [self.chkdata replaceObjectAtIndex:indexPath.row withObject:@"0"];
    } else {
        [self.chkdata replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    NSArray *arrya = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:arrya withRowAnimation:UITableViewRowAnimationNone];
        
    // 取消选中高亮
//    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
//    [tableView cellForRowAtIndexPath:indexPath];
//    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
//    if ([_selCell isEqual:[tableView cellForRowAtIndexPath:indexPath]]) {
//        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
//        _selCell = nil;
//    } else {
//        _selCell = [tableView cellForRowAtIndexPath:indexPath];
//    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionDelete:(id)sender {
    [self delete];
}

-(void)delete {
    NSMutableArray *deleteInfo = [[NSMutableArray alloc] init];
    for (int k = 0; k<self.chkdata.count; k++) {
        if ([self.chkdata[k] isEqualToString:@"0"]) {
            NSDictionary *dic = self.data[k];
            NSMutableDictionary *deldic = [[NSMutableDictionary alloc] init];
            [deldic setObject:[dic objectForKey:@"id"] forKey:@"id"];
            [deldic setObject:[[dic objectForKey:@"productType"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"type"];
            [deleteInfo addObject:deldic];
        }
    }
    if (deleteInfo.count == 0) {
        [self toast:self.view content:@"请选择要删除的产品"];
        return;
    }
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:deleteInfo options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    MyLog(@"%@",jsonString,nil);
    [self showProgress:self.view content:@"正在删除"];
    ProductService *productService = [[ProductService alloc] init];
    productService.delegate = self;
    productService.tag = 2;
    [productService deleleProducts:deleteInfo];

}

@end
