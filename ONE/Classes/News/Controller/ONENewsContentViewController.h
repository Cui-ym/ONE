//
//  ONENewsContentViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/11.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ONENewsContentViewController : UIViewController

@property (nonatomic, copy) NSString *webString;
@property (nonatomic, strong)WKWebView *webView;

@end
