//
//  ProductDelegate.h
//  MsolStore
//
//  Created by IoCan on 16/4/25.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProductDelegate <NSObject>

@optional

-(void) onProductDeleteSuccess;

-(void) onProductAddSuccess;

@end
