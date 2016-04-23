//
//  BroadbandListViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "BroadbandService.h"

@interface BroadbandListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LoginDelegate>

@property(strong,nonatomic) NSString * method;

@property (strong, nonatomic) NSMutableArray *data;//数据源

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
