//
//  MyProfileViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MyProfileViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;//数据源

@end
