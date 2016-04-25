//
//  ProductListViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ProductListViewController.h"
#import "BroadbandCell.h"
#import "UIImageView+WebCache.h"
#import "WebViewController.h"
#import "KLCPopup.h"
#import "ICZButton.h"
#import "ProductListAddViewController.h"
#import "ProductDeleteViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品仓库";
    [self loadNetData];
    UIButton *button2 = [[UIButton alloc] init];
    button2.frame = CGRectMake(0, 0, 32, 6);
    [button2 setImage:[UIImage imageNamed:@"btn_more"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = backItem2;

    
}


-(void)loadNetData {
    [self showProgress:self.view content:@"加载列表"];
    ProductService *productService = [[ProductService alloc] init];
    productService.delegate = self;
    [productService getOwnProducts];
}

-(void)onResponse:(id)responseObject tag:(int)tag{
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        self.data =  [responseObject objectForKey:@"info"];
        [self.tableView reloadData];
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
    cell.label_name.text = [dic objectForKey:@"productName"];
    cell.label_price.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"price"],nil];
    [cell.iv_pic sd_setImageWithURL:[NSURL URLWithString:[SERVICEURL_PIC stringByAppendingString:[dic objectForKey:@"img"]]] placeholderImage:[UIImage imageNamed:@"ic_default_adimage.jpg"]];
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
    NSString *type = [dic objectForKey:@"productType"];
    if ([type isEqualToString:@"宽带"]) {
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:kd_url,[dic objectForKey:@"id"]]];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    } else {
        
        WebViewController *ctrl = [[WebViewController alloc] initWithUrl:[NSString stringWithFormat:rh_url,[dic objectForKey:@"id"]]];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


-(void)moreAction{
    CGFloat btnH = 40;
    CGFloat btnW = 100;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, btnW, btnH*2 + 2)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    ICZButton *btn1 = [[ICZButton alloc] initWithFrame:CGRectMake(0, 1, btnW, btnH)];
    [btn1 addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn1 setImage:[UIImage imageNamed:@"product_icon_del"] forState:UIControlStateNormal];
    [btn1 setTitle:@"删除" forState:UIControlStateNormal];
    [contentView addSubview:btn1];
    
    ICZButton *btn2 = [[ICZButton alloc] initWithFrame:CGRectMake(0, btnH + 2, btnW, btnH)];
    [btn2 addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 setImage:[UIImage imageNamed:@"product_icon_add"] forState:UIControlStateNormal];
    [btn2 setTitle:@"增加" forState:UIControlStateNormal];
    [contentView addSubview:btn2];
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeGrowIn
                                         dismissType:KLCPopupDismissTypeShrinkOut
                                            maskType:KLCPopupMaskTypeNone
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup showAtCenter:CGPointMake(ScreenWidth-btnW/2, 64 + btnH + 1) inView:self.view];
}

-(void)addAction:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
    ProductListAddViewController *ctrl = [[ProductListAddViewController alloc] init];
    ctrl.deletegate = self;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}

-(void)deleteAction:(id)sender {
    if ([sender isKindOfClass:[UIView class]]) {
        [(UIView*)sender dismissPresentingPopup];
    }
    ProductDeleteViewController *ctrl = [[ProductDeleteViewController alloc] init];
    ctrl.deletegate = self;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctrl animated:YES];
}

-(void)onProductAddSuccess {
    [self loadNetData];
    [self toast:self.view content:@"添加成功"];
}

-(void)onProductDeleteSuccess {
    [self loadNetData];
    [self toast:self.view content:@"删除成功"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
