//
//  ProductDeleteCell.h
//  MsolStore
//
//  Created by IoCan on 16/4/25.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDeleteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iv_pic;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_price;

@property (weak, nonatomic) IBOutlet UIButton *btn_check;

@end
