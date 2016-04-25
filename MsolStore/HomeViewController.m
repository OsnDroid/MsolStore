//
//  HomeViewController.m
//  MsolStore
//
//  Created by IoCan on 16/4/15.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "WebViewController.h"
#import "BusineshallViewController.h"
#import "BroadbandMainViewController.h"
#import "ProductListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"HomeCell"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"HomeItem" ofType:@"plist"];
    self.data = [[NSMutableArray  alloc] initWithContentsOfFile:plistPath];
    self.collectionView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth/4*3);
    
    

}


#pragma mark - Collection View Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth/4-0.5, 89);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{    
    static NSString *identify = @"HomeCell";
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[HomeCell alloc] initWithFrame:CGRectZero];
    }
    NSDictionary *items = [self.data objectAtIndex:indexPath.row];
    NSString *title = [items objectForKey:@"title"];
    if (title.length > 0) {
        cell.label.text = [items objectForKey:@"title"];
        [cell.btn setImage:[UIImage imageNamed:[items objectForKey:@"icon"]] forState:UIControlStateNormal];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [_collectionView deselectItemAtIndexPath:indexPath animated:YES];
    BaseViewController *vCtrl;
    switch (indexPath.row) {
        case 0:
            //融合套餐
            vCtrl = [[BroadbandMainViewController alloc] init];
           break;
        case 1:
            //号码办理
            [self prop];
            break;
        case 2:
            //itv加装
            vCtrl = [[WebViewController alloc] initWithUrl:@"http://ah.189.cn/itv.html?dev_code="];
            break;
        case 3:
            //3g升4g
            {
             
               vCtrl = [[WebViewController alloc] initWithUrl:[[NSBundle mainBundle]pathForResource:@"3up4" ofType:@"html"]];
            }
            break;
        case 4:
            //宽带提速
             vCtrl = [[WebViewController alloc] initWithUrl:@"http://ah.189.cn/cms/r/cms/ah/default/activity/broadBandSpeedRais/wap/index_view.html"];
            break;
        case 5:
            //资源查询
             vCtrl = [[WebViewController alloc] initWithUrl:[[NSBundle mainBundle]pathForResource:@"map" ofType:@"html"]];
            break;
        case 6:
            //快速查询
            [self prop];
            break;
        case 7:
            //结对营业厅
            vCtrl = [[BusineshallViewController alloc] init];
            break;
        case 8:
            //产品仓库
            vCtrl = [[ProductListViewController alloc] init];
            break;
        case 9:
            //实名制补录
            [self prop];
            break;
        
    }
    if (vCtrl) {
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vCtrl animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        vCtrl = nil;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
