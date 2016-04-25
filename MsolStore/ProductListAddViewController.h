//
//  ProductListAddViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductService.h"
#import "UIScrollView+EmptyDataSet.h"
#import "ProductDelegate.h"


@interface ProductListAddViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LoginDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionAdd:(id)sender;

@property (strong, nonatomic) NSMutableArray *data;//数据源
@property (nonatomic,assign) id<ProductDelegate> deletegate;
@property (strong, nonatomic) NSMutableArray *chkdata;//数据源

@end
