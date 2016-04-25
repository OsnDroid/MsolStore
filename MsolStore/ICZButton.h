//
//  ICZButton.h
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICZButton : UIButton

@property (nonatomic, strong) UIColor *icColor;
@property (nonatomic, strong) UIColor *icHightColor;
@property (nonatomic, strong) UIColor *borderColor;


@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat borderWidth;

@end
