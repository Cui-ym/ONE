//
//  ONEHomeViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEHomeViewController.h"
#import "ONEArticleViewController.h"
#import "ONEAnwersViewController.h"
#import "ONESerialViewController.h"


#define scrollWidth [UIScreen mainScreen].bounds.size.width

@interface ONEHomeViewController () <UIScrollViewDelegate>
{
    NSString *firstDayStr;
    NSString *secondDayStr;
    NSString *thridDayStr;
    NSString *fourthDayStr;
    NSString *fifthDayStr;
    NSString *sixthDayStr;
    NSString *seventhDayStr;
    NSArray *array;
    int flag;
}
@end

@implementation ONEHomeViewController

- (void)viewWillAppear:(BOOL)animated {
    _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _urlString = @"http://v3.wufazhuce.com:8000/api/onelist/idlist/?channel=ios&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios";
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(barHidden)
//                                                 name:@"barHidden"
//                                               object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(barNoHidden)
//                                                 name:@"barNoHidden"
//                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setModel:)
                                                 name:@"everyday"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushArticle:)
                                                 name:@"pushArticleViewController"
                                               object:nil];
    self.navigationController.navigationBar.translucent = NO;
    self.homeModel = [[ONEHomeModel alloc] init];
    _homeModel.urlString = _urlString;
    [_homeModel getModel];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dictionary];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"一个";

}

// push 到文章的详细界面
- (void)pushArticle:(NSNotification *)notification {
    NSString *label = [notification.userInfo objectForKey:@"label"];
//    NSLog(@"%@", label);
    if ([label  isEqual: @"- ONE STORY  -"] || [label  isEqual: @"- 阅读  -"]) {
        ONEArticleViewController *articleView = [[ONEArticleViewController alloc] init];
        articleView.urlString = [notification.userInfo objectForKey:@"url"];
        [self.navigationController pushViewController:articleView animated:YES];
    } else if ([label  isEqual: @"- 问答  -"]) {
        ONEAnwersViewController *anwersView = [[ONEAnwersViewController alloc] init];
        anwersView.questioner = [notification.userInfo objectForKey:@"author"];
        anwersView.urlString = [notification.userInfo objectForKey:@"url"];
        [self.navigationController pushViewController:anwersView animated:YES];
    } else if ([label  isEqual: @"- 连载  -"]) {
        ONESerialViewController *serialView = [[ONESerialViewController alloc] init];
        serialView.urlString = [notification.userInfo objectForKey:@"url"];
        [self.navigationController pushViewController:serialView animated:YES];
    }
}

//- (void)barHidden {
//    flag = 0;
//    [self prefersStatusBarHidden];
//}
//
//- (void)barNoHidden {
//    flag = 1;
//    [self prefersStatusBarHidden];
//}

// 设置每天对应的代码
- (void)setModel:(NSNotification *)notification {
    NSArray *arr = [NSArray array];
    arr = [notification.userInfo objectForKey:@"data"];
    firstDayStr = arr[0];
    secondDayStr = arr[1];
    thridDayStr = arr[2];
    fourthDayStr = arr[3];
    fifthDayStr = arr[4];
    sixthDayStr = arr[5];
    seventhDayStr = arr[6];
    [self setMainScrollView];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"everyday" object:nil];
}

// 重写 set 方法
- (ONEHomeDayViewController *)firstViewController{
    if (_firstViewController == nil) {
        self.firstViewController = [[ONEHomeDayViewController alloc] init];
        _firstViewController.urlString = firstDayStr;
    }
    return _firstViewController;
}

- (ONEHomeDayViewController *)secondViewController{
    if (_secondViewController == nil) {
        self.secondViewController = [[ONEHomeDayViewController alloc] init];
        _secondViewController.urlString = secondDayStr;
    }
    return _secondViewController;
}

- (ONEHomeDayViewController *)thridViewController{
    if (_thridViewController == nil) {
        self.thridViewController = [[ONEHomeDayViewController alloc] init];
        _thridViewController.urlString = thridDayStr;
    }
    return _thridViewController;
}

- (ONEHomeDayViewController *)fourthViewController{
    if (_fourthViewController == nil) {
        self.fourthViewController = [[ONEHomeDayViewController alloc] init];
        _fourthViewController.urlString = fourthDayStr;
    }
    return _fourthViewController;
}

- (ONEHomeDayViewController *)fifthViewController{
    if (_fifthViewController == nil) {
        self.fifthViewController = [[ONEHomeDayViewController alloc] init];
        _fifthViewController.urlString = fifthDayStr;
    }
    return _fifthViewController;
}

- (ONEHomeDayViewController *)sixthViewController{
    if (_sixthViewController == nil) {
        self.sixthViewController = [[ONEHomeDayViewController alloc] init];
        _sixthViewController.urlString = sixthDayStr;
    }
    return _sixthViewController;
}

- (ONEHomeDayViewController *)seventhViewController{
    if (_seventhViewController == nil) {
        self.seventhViewController = [[ONEHomeDayViewController alloc] init];
        _seventhViewController.urlString = seventhDayStr;
    }
    return _seventhViewController;
}

- (void)setMainScrollView {
    // 设置scrollView
//    NSLog(@"setMainScroll");
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    [self firstViewController];
    [self secondViewController];
    [self thridViewController];
    [self fourthViewController];
    [self fifthViewController];
    [self sixthViewController];
    [self seventhViewController];
    
    // 添加 viewController 的 view
    NSArray *views = [NSArray arrayWithObjects:_firstViewController.view, _secondViewController.view, _thridViewController.view, _fourthViewController.view, _fifthViewController.view,  _sixthViewController.view, _seventhViewController.view, nil];
    
    for (NSInteger i = 0; i < views.count; i++) {
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(scrollWidth * i, 0, _scrollView.frame.size.width, _scrollView.frame.size.height - 100)];
        [pageView addSubview:views[i]];
        [_scrollView addSubview:pageView];
    }
    _scrollView.contentSize = CGSizeMake(scrollWidth * views.count, 0);
}

//- (BOOL)prefersStatusBarHidden {
//    if (flag == 0) {
//        [self.navigationController setNavigationBarHidden:YES animated:nil];
//        return YES;
//    } else {
//        [self.navigationController setNavigationBarHidden:NO animated:nil];
//        return NO;
//    }
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    array = [NSArray arrayWithObjects:@"一个", @"昨天", @"两天前", @"三天前", @"四天前", @"五天前", @"六天前", nil];
    NSInteger x = scrollView.contentOffset.x/scrollWidth;
    self.navigationItem.title = array[x];
//    switch (x) {
//        case 0:
//            [_firstViewController.homeView scrollViewDidScroll:_firstViewController.homeView.tableView];
//            break;
//        case 1:
//            [_secondViewController.homeView scrollViewDidScroll:_secondViewController.homeView.tableView];
//            break;
//        case 2:
//            [_thridViewController.homeView scrollViewDidScroll:_thridViewController.homeView.tableView];
//            break;
//        case 3:
//            [_fourthViewController.homeView scrollViewDidScroll:_fourthViewController.homeView.tableView];
//            break;
//        case 4:
//            [_fifthViewController.homeView scrollViewDidScroll:_fifthViewController.homeView.tableView];
//            break;
//        case 5:
//            [_sixthViewController.homeView scrollViewDidScroll:_sixthViewController.homeView.tableView];
//            break;
//        case 6:
//            [_seventhViewController.homeView scrollViewDidScroll:_seventhViewController.homeView.tableView];
//            break;
//        default:
//            break;
//    }
}

// 注销通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
