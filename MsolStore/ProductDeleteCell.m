//
//  ProductDeleteCell.m
//  MsolStore
//
//  Created by IoCan on 16/4/25.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ProductDeleteCell.h"

@implementation ProductDeleteCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"ProductDeleteCell" owner:self options:nil][0];
        self.frame =  CGRectMake(0, 0, ScreenWidth, 100);
        [self addSubview:view];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, ScreenWidth, 100);
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//     self.btn_check.selected = selected;
}

@end
