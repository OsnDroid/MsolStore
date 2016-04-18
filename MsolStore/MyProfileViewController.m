//
//  MyProfileViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的资料";
         
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.automaticallyAdjustsScrollViewInsets = false;
    self.hidesBottomBarWhenPushed = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"MyProfileInfo" ofType:@"plist"];
    self.data = [[NSMutableArray  alloc] initWithContentsOfFile:plistPath];
    
}

#pragma mark -数据源方法
//这个方法用来告诉表格有几个分组
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.data count];
}

//这个方法告诉表格第section个分段有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.data objectAtIndex:section] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 8.0f;
    }else {
        return 10.0f;
    }
    
}

//这个方法用来告诉某个分组的某一行是什么数据，返回一个UITableViewCel
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *groupedTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:groupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:groupedTableIdentifier];
    }
    NSUInteger row = [indexPath row];
    NSArray *items = [self.data objectAtIndex:indexPath.section];
    NSDictionary *item = items[row];
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"desc"];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
