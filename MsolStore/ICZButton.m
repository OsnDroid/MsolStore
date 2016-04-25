//
//  ICZButton.m
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "ICZButton.h"

@implementation ICZButton

- (void)qbfb_init
{
    
    self.borderColor = RGBA(55, 171, 244, 1.0);
    self.radius = 0.0;
    self.borderWidth = 0.0;
    self.icColor = RGBA(55, 171, 244, 1.0);
    self.icHightColor = RGBA(3, 45, 87, 1.0);
    self.layer.cornerRadius = self.radius;
    self.layer.borderWidth = self.borderWidth;
    self.backgroundColor = RGBA(55, 171, 244, 1.0);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self qbfb_init];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self qbfb_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    
    if (self) {
        [self qbfb_init];
    }
    
    return self;
}



- (void)setHighlighted:(BOOL)value
{
    [super setHighlighted:value];
    
    if (value) {
        self.backgroundColor = RGBA(25, 121, 202, 1.0);
    } else {
        self.backgroundColor = RGBA(55, 171, 244, 1.0);
    }
    
    
}



@end
