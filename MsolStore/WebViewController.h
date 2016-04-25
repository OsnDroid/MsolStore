//
//  WebViewController.h
//  DatastreamBank
//
//  Created by OsnDroid on 15/10/14.
//  Copyright (c) 2015年 OsnDroid. All rights reserved.
//

#import "BaseViewController.h"
@protocol AddressDelegate <NSObject>

@optional

-(void) address:(NSString *)adddres;

@end

@interface WebViewController : BaseViewController<UIWebViewDelegate>
{
    
    NSString *_url;
}

-(id)initWithUrl:(NSString *)url;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UILabel *label_bottom;


@property (nonatomic,assign) BOOL isBottm;

@property (nonatomic,assign) BOOL isShare;

@property (nonatomic,assign) id<AddressDelegate> addressDelegate;

@property (nonatomic,strong) NSString *orderId;

@end
