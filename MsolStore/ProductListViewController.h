//
//  ProductListViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductService.h"
#import "ProductDelegate.h"

@interface ProductListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ProductDelegate,LoginDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *data;//数据源

@end
