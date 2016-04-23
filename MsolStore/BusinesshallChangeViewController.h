//
//  BusinesshallChangeViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/22.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"
#import "BBHService.h"
@protocol CompleteDelegate <NSObject>

@optional
// 完成
-(void) onCompleteSuccess;

@end

@interface BusinesshallChangeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,LoginDelegate>

@property (strong, nonatomic) NSMutableArray *data;//数据源

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionReset:(id)sender;

@property (assign, nonatomic) id <CompleteDelegate> delegate;

@end
