//
//  HomeCell.m
//  DatastreamBank
//
//  Created by OsnDroid on 15/10/21.
//  Copyright (c) 2015年 OsnDroid. All rights reserved.
//

#import "HomeCell.h"


@implementation HomeCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil][0];
        self.frame =  CGRectMake(0, 0, ScreenWidth/4, 89);
        [self addSubview:view];
        
    }
    return self;
}


-(void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundView.backgroundColor = RGBA(246, 246, 246, 1.0);
        
    } else {
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    
}

-(void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundView.backgroundColor = RGBA(246, 246, 246, 1.0);
        
    } else {
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    
}




-(void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame =CGRectMake(0, 0, ScreenWidth/4, 89);
    
//    self.frame =  CGRectMake(0, 0, ScreenWidth/4, 89);
//    self.contentView.frame =  CGRectMake(0, 0, ScreenWidth/4, 89);
//    NSLog(@"===%f",self.contentView.width);
////    self.contentView.width = ScreenWidth/4;
//    NSLog(@"---%f",self.contentView.width);
//    self.contentView.width = ScreenWidth/4;
//    self.contentView.height = 89;

//    // 初始化时加载collectionCell.xib文件
//    NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CollectionCell" owner:self options:nil];
//    
//    // 如果路径不存在，return nil
//    if (arrayOfViews.count < 1)
//    {
//        return nil;
//    }
//    // 如果xib中view不属于UICollectionViewCell类，return nil
//    if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
//    {
//        return nil;
//    }
//    // 加载nib
//    self = [arrayOfViews objectAtIndex:0];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
