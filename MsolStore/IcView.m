//
//  IcView.m
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "IcView.h"

@implementation IcView

- (void)qbfb_init
{
    
    self.layer.cornerRadius = 0;
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
   
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



@end
