//
//  MineHeaderView.m
//  MsolStore
//
//  Created by IoCan on 16/4/18.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

/**
 *  初始化xib页面
 *
 *  @param frame 页面位置大小
 *
 *  @return UIView
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:self options:nil][0];
        self.frame =  CGRectMake(0, 0, ScreenWidth, 140);
        [self addSubview:view];
        
    }
    return self;
}


-(void)layoutSubviews{
    self.frame = CGRectMake(0, 0, ScreenWidth, 140);
    [super layoutSubviews];
}



@end
