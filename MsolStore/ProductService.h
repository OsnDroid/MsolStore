//
//  ProductService.h
//  MsolStore
//
//  Created by IoCan on 16/4/24.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "NetService.h"

@interface ProductService : NetService


//获取自己的产品
-(void)getOwnProducts;

//删除自己产品
-(void)deleleProducts:(id)products;

//增加自己产品
-(void)addProducts:(id)products;

//获取可增加的其它产品列表
-(void)getAllProducts;

@end
