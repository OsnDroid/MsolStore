//
//  HandleOrdersViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "WebViewController.h"
#import "UIPlaceholderTextView.h"
#import "SBCBService.h"

@interface HandleOrdersViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,AddressDelegate,LoginDelegate>

- (IBAction)mapAction:(id)sender;

- (IBAction)cityAction:(id)sender;

- (IBAction)areaAction:(id)sender;

- (IBAction)submitAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *iv_pic;

@property (weak, nonatomic) IBOutlet UILabel *label_productprice;

@property (weak, nonatomic) IBOutlet UILabel *label_productname;

@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@property (weak, nonatomic) IBOutlet UITextField *tf_phone;

@property (weak, nonatomic) IBOutlet UITextField *tf_cardid;

@property (weak, nonatomic) IBOutlet UIButton *btn_city;

@property (weak, nonatomic) IBOutlet UIButton *btn_area;

@property (weak, nonatomic) IBOutlet UITextField *tf_address;

@property (weak, nonatomic) IBOutlet UIPlaceholderTextView *tv_msg;


@property (strong,nonatomic) NSString *picUrl;
@property (assign,nonatomic) int proudctId;
@property (strong,nonatomic) NSString *productName;
@property (strong,nonatomic) NSString *prudctType;
@property (strong,nonatomic) NSString *proudctPrice;

@property (strong,nonatomic) NSMutableArray *citys;
@property (strong,nonatomic) NSMutableArray *areas;
@property (strong,nonatomic) NSMutableArray *data;

@property (strong,nonatomic) UITableView *cityTableView ;
@property (strong,nonatomic) UITableView *areaTableView ;


@end
