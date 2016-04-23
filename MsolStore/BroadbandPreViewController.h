//
//  BroadbandPreViewController.h
//  MsolStore
//
//  Created by IoCan on 16/4/23.
//  Copyright © 2016年 IoCan. All rights reserved.
//

#import "BaseViewController.h"

@interface BroadbandPreViewController : BaseViewController<UIWebViewDelegate>
{
    
    NSString *_url;
}

-(id)initWithUrl:(NSString *)url;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)actionSubmit:(id)sender;


@end
