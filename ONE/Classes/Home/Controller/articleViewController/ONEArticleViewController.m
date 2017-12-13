//
//  ONEArticleViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/2.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEArticleViewController.h"

@interface ONEArticleViewController () <WKNavigationDelegate>
{
    int flag;
}

@end

@implementation ONEArticleViewController

- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
//    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航栏
    [self.navigationController setNavigationBarHidden:NO animated:nil];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"ONE STORY";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ONEArticleModel *model = [[ONEArticleModel alloc] init];
    model.urlString = _urlString;
    [model getArticleDetails];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setArticle:) name:[NSString stringWithFormat:@"%@getArticle", _urlString] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setArticleComment:) name:[NSString stringWithFormat:@"%@getArticleComment", _urlString] object:nil];
    
}

- (void)setArticle:(NSNotification *)notification {
    if (flag == 0) {
        self.articleView = [[ONEArticleView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _articleView.title = [notification.userInfo objectForKey:@"title"];
    _articleView.author = [NSString stringWithFormat:@"作者：%@", [notification.userInfo objectForKey:@"author"]];
    _articleView.webString = [notification.userInfo objectForKey:@"article"];
    NSLog(@"%@", _articleView.webString);
    [_articleView.webView loadHTMLString:_articleView.webString baseURL:nil];
    if (flag == 1) {
        [self.view addSubview:_articleView];
    }
    flag = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@getSerial", _urlString] object:nil];
}

- (void)setArticleComment:(NSNotification *)notification {
    if (flag == 0) {
        self.articleView = [[ONEArticleView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _articleView.commentArray = [notification.userInfo objectForKey:@"comment"];
//    [_articleView calculateHeight];
//    NSLog(@"%@", _articleView.commentArray);
    if (flag == 1) {
        [self.view addSubview:_articleView];
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
