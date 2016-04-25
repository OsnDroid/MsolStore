//
//  ProductDeleteViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductService.h"
#import "ProductDelegate.h"

@interface ProductDeleteViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LoginDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)actionDelete:(id)sender;
@property (strong, nonatomic) NSMutableArray *data;//数据源

@property (strong, nonatomic) NSMutableArray *chkdata;//数据源

@property (nonatomic,assign) id<ProductDelegate> deletegate;

@end
