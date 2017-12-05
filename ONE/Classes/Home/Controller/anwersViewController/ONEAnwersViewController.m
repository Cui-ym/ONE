//
//  ONEAnwersViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEAnwersViewController.h"

@interface ONEAnwersViewController ()
{
    int flag;
}

@end

@implementation ONEAnwersViewController

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
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"问答";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.model = [[ONEAnwersModel alloc] init];
    _model.urlString = _urlString;
    [_model getAnwersDetails];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAnwers:) name:[NSString stringWithFormat:@"%@getAnswer", _urlString] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAnwersComment:) name:[NSString stringWithFormat:@"%@getAnswerComment", _urlString] object:nil];
    
}

- (void)setAnwers:(NSNotification *)notification {
    NSLog(@"fsa");
    if (flag == 0) {
        self.anwersView = [[ONEAnwersView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _anwersView.questioner = _questioner;
    _anwersView.question = [notification.userInfo objectForKey:@"question"];
    _anwersView.title = [notification.userInfo objectForKey:@"title"];
    _anwersView.author = [NSString stringWithFormat:@"%@答", [notification.userInfo objectForKey:@"author"]];
    _anwersView.webString = [notification.userInfo objectForKey:@"answer"];
    [_anwersView.answer loadHTMLString:_anwersView.webString baseURL:nil];
    if (flag == 1) {
        [self.view addSubview:_anwersView];
    }
    flag = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@getAnwers", _urlString] object:nil];
}

- (void)setAnwersComment:(NSNotification *)notification {
    NSLog(@"fsa--");
    if (flag == 0) {
        self.anwersView = [[ONEAnwersView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _anwersView.commentArray = [notification.userInfo objectForKey:@"comment"];
//    NSLog(@"%@", _anwersView.commentArray);
    if (flag == 1) {
        [self.view addSubview:_anwersView];
    }
    flag = 1;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"%@getAnwersComment", _urlString] object:nil];
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
