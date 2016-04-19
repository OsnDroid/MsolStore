//
//  MineViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface MineViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *data;//数据源

//加载提示
@property (nonatomic,strong) MBProgressHUD *toast;

@end
