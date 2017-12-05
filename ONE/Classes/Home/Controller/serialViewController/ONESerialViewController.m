//
//  ONESerialViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONESerialViewController.h"

@interface ONESerialViewController ()
{
    int flag;
}

@end

@implementation ONESerialViewController

- (void)viewWillAppear:(BOOL)animated{
    
    flag = 0;
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self.navigationController setNavigationBarHidden:NO animated:nil];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"连载";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.model = [[ONESerialModel alloc] init];
    _model.urlString = _urlString;
    [_model getSerialDetails];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSerial:) name:[NSString stringWithFormat:@"%@getSerial", _urlString] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSerialComment:) name:[NSString stringWithFormat:@"%@getSerialComment", _urlString] object:nil];
    
}

- (void)setSerial:(NSNotification *)notification {
    if (flag == 0) {
        self.serialView = [[ONESerialView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _serialView.title = [notification.userInfo objectForKey:@"title"];
    _serialView.author = [NSString stringWithFormat:@"作者：%@", [notification.userInfo objectForKey:@"author"]];
    _serialView.webString = [notification.userInfo objectForKey:@"serial"];
//    NSLog(@"%@", notification.userInfo);
    [_serialView.webView loadHTMLString:_serialView.webString baseURL:nil];
    if (flag == 1) {
        [self.view addSubview:_serialView];
    }
    flag = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@getSerial", _urlString] object:nil];
}

- (void)setSerialComment:(NSNotification *)notification {
    if (flag == 0) {
        self.serialView = [[ONESerialView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _serialView.commentArray = [notification.userInfo objectForKey:@"comment"];
//    NSLog(@"%@", _serialView.commentArray);
    if (flag == 1) {
        [self.view addSubview:_serialView];
    }
    flag = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@getSerialComment", _urlString] object:nil];
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
