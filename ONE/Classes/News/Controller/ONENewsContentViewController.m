//
//  ONENewsContentViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/11.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONENewsContentViewController.h"

#import <Masonry.h>

@interface ONENewsContentViewController ()

@end

@implementation ONENewsContentViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:_webString]];
    [_webView loadRequest:request];
    NSLog(@"%@", _webString);
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
