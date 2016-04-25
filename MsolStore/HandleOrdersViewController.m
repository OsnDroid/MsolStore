//
//  HandleOrdersViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "HandleOrdersViewController.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"
#import "KLCPopup.h"
#import "CityAreaCell.h"


@interface HandleOrdersViewController ()

@property (nonatomic,strong) UITableViewCell *selCell;
@property (nonatomic,assign) BOOL isF;

@end

@implementation HandleOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"融合套餐";
    self.tv_msg.placeholder = @"请输入您的留言";
    self.label_productname.text = self.productName;
    self.label_productprice.text = self.proudctPrice;
    [self.iv_pic sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:[UIImage imageNamed:@"ic_default_adimage.jpg"]];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"CityAreas" ofType:@"plist"];
    self.data = [[NSMutableArray  alloc] initWithContentsOfFile:plistPath];
    self.citys = [[NSMutableArray alloc] init];
    self.areas = [[NSMutableArray alloc] init];
    for (int i=0; i<[self.data count]; i++) {
        NSDictionary *dic = [self.data objectAtIndex:i];
        for (NSString *key in dic) {
            [self.citys addObject:key];
            if ([key isEqualToString:@"合肥市"]) {
                self.areas = [dic objectForKey:key];
            }
            break;
        }
    }
  
    Account *account = [UserInfoManager getAccount];
    if (![NSString isBlankString:account.city] && ![NSString isBlankString:account.area]) {
        [self.btn_city setTitle:account.city forState:UIControlStateNormal];
        [self.btn_area setTitle:account.area forState:UIControlStateNormal];
    } else {
        [self.btn_city setTitle:_citys[0] forState:UIControlStateNormal];
        [self.btn_area setTitle:_areas[0] forState:UIControlStateNormal];
    }
    
   

}

#pragma mark - LoginDelegate Methods
-(void)onResponse:(id)responseObject tag:(int)tag{
    NSString *result = [responseObject objectForKey:@"code"];
    if ([result isEqualToString:@"000"]) {
        NSString *orderId = [responseObject objectForKey:@"orderId"];
        NSString *url = [[NSBundle mainBundle]pathForResource:@"success" ofType:@"html"];
        WebViewController *vCtrl = [[WebViewController alloc] initWithUrl:url];
        vCtrl.orderId = orderId;
        [self.navigationController pushViewController:vCtrl animated:YES];
    } else {
        NSString *resultMsg = [responseObject objectForKey:@"result"];
        [self prop:resultMsg];
    }
}

-(void)onError:(NSError *)error {
    NSString *param = [NSString stringWithFormat:@"请求错误码：%ld,%@",(long)error.code, [error.userInfo objectForKey:@"NSLocalizedDescription"]];
    [self prop:param];
}

-(void)onLoginSuccess:(BOOL)state tag:(int)tag{
    [self submit];
}

// 登陆失败
-(void) onLoginFail:(id) responseObject{
    NSString *resultMsg = [responseObject objectForKey:@"message"];
    [self prop:resultMsg delegate:self];
    
}

-(void)onFinish {
    [self closeProgress];
}



-(void)propCity{
    CGFloat w = ScreenWidth*3/4;
    CGFloat h = ScreenHeight*3/4;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    contentView.backgroundColor = [UIColor whiteColor];
 
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.backgroundColor = MSBlue;
    label.text = @"地市选择";
    [contentView addSubview:label];
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, w, h-42)];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;

    }
    [contentView addSubview:_cityTableView];
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeGrowIn
                                         dismissType:KLCPopupDismissTypeShrinkOut
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup show];
}

-(void)propArea{
    CGFloat w = ScreenWidth*3/4;
    CGFloat h = ScreenHeight*3/4;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, 40)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.backgroundColor = MSBlue;
    label.text = @"地市选择";
    [contentView addSubview:label];
    if (!_areaTableView) {
        _areaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, w, h-42)];
        _areaTableView.delegate = self;
        _areaTableView.dataSource = self;
        
    }else{
        [_areaTableView reloadData];
    }
    [contentView addSubview:_areaTableView];
    KLCPopup* popup = [KLCPopup popupWithContentView:contentView
                                            showType:KLCPopupShowTypeGrowIn
                                         dismissType:KLCPopupDismissTypeShrinkOut
                                            maskType:KLCPopupMaskTypeDimmed
                            dismissOnBackgroundTouch:YES
                               dismissOnContentTouch:NO];
    
    [popup show];
}



#pragma mark - action
- (IBAction)mapAction:(id)sender {
    WebViewController *ctrl = [[WebViewController alloc] initWithUrl:@"http://219.148.203.212/mstywap/jsp/checkIn/jumpIOS.jsp"];
    ctrl.addressDelegate = self;
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (IBAction)cityAction:(id)sender {
    //地区
    [self propCity];

}

- (IBAction)areaAction:(id)sender {
    
    [self propArea];
}

- (IBAction)submitAction:(id)sender {
    [self submit];
}

-(void)submit {
   
    NSString *name = self.tf_name.text;
    NSString *phone = self.tf_phone.text;
    NSString *cardId = self.tf_cardid.text;
    NSString *address = self.tf_address.text;
    NSString *city = self.btn_city.currentTitle;
    NSString *area = self.btn_area.currentTitle;
    NSString *msg = self.tv_msg.text;
    if ([NSString isBlankString:name]) {
        [self prop:@"请先输入姓名"];
        return;
    }
    if (![NSString isMobileNumber:phone]) {
        [self prop:@"请先输入正确的手机号"];
        return;
    }
    if ([NSString isBlankString:cardId]) {
        [self prop:@"请先输入您的身份证号"];
        return;
    }
    if ([NSString isBlankString:address]) {
        [self prop:@"请先输入您的装机地址"];
        return;
    }
    if ([NSString isBlankString:city] || [city containsString:@"请选择"]) {
        [self prop:@"请先选择市(地区)"];
        return;
    }
    if ([NSString isBlankString:area]|| [area containsString:@"请选择"]) {
        [self prop:@"请先选择区(县)"];
        return;
    }
    [self showProgress:self.view content:@"正在提交"];
    SBCBService *broadbandService = [[SBCBService alloc] init];
    broadbandService.delegate = self;
    [broadbandService submitOrder:self.proudctId
                      productType:self.prudctType
                             name:name
                         linkeNum:phone
                             city:city
                             area:area
                          address:address
                           cardId:cardId
                         resmarks:msg];
}


#pragma mark -数据源方法
//这个方法用来告诉某个分组的某一行是什么数据，返回一个UITableViewCel
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"CityAreaCell";
    CityAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[CityAreaCell alloc] initWithFrame:CGRectZero];
    }
    if ([tableView isEqual:_areaTableView]) {
        cell.labelStr.text = [self.areas objectAtIndex:indexPath.row];
    }else {
        cell.labelStr.text = [self.citys objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_areaTableView]) {
        return self.areas.count;
    }
    return self.citys.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_selCell isEqual:[tableView cellForRowAtIndexPath:indexPath]]) {
        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        _selCell = nil;
    } else {
        _selCell = [tableView cellForRowAtIndexPath:indexPath];
    }
    if ([tableView isEqual:_areaTableView]) {
        [self.btn_area setTitle:_areas[indexPath.row] forState:UIControlStateNormal];
    } else {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        for (NSString *key in dic) {
            self.areas = [dic objectForKey:key];
            break;
        }
        [self.btn_city setTitle:_citys[indexPath.row] forState:UIControlStateNormal];
        [self.btn_area setTitle:_areas[0] forState:UIControlStateNormal];
    }
   [tableView dismissPresentingPopup];
}


-(void)address:(NSString *)adddres{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tf_address.text = adddres;
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
