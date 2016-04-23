//
//  BusinesshallCell.h
//  MsolStore
//
//  Created by IoCan on 16/4/22.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinesshallCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_name;

@property (weak, nonatomic) IBOutlet UILabel *label_num;

@property (weak, nonatomic) IBOutlet UIButton *btnCheck;

@property (strong,nonatomic) NSString *resetUsrname;

@end
