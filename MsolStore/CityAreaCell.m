//
//  CityAreaCell.m
//  MsolStore
//
//  Created by IoCan on 16/4/25.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "CityAreaCell.h"

@implementation CityAreaCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"CityAreaCell" owner:self options:nil][0];
        self.frame =  CGRectMake(0, 0, ScreenWidth*3/4, 50);
        [self addSubview:view];
        
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, ScreenWidth*3/4, 50);
    
}


- (void)awakeFromNib {
    // Initialization code
    //     self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.btnChk.selected = selected;
}


@end
