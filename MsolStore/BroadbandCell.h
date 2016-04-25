//
//  BroadbandCell.h
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BroadbandCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iv_pic;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_price;


@property (strong,nonatomic) NSString *productType;
@property (assign,nonatomic) int productId;

@end
