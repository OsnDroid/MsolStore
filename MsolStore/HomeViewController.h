//
//  HomeViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *data;//数据源

@end
