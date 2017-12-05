//
//  ONEHomeDayViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/18.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEHomeDayViewController.h"
#import <UIImageView+WebCache.h>
#import <WebKit/WebKit.h>

@interface ONEHomeDayViewController () 

@end

@implementation ONEHomeDayViewController

- (void)viewWillAppear:(BOOL)animated {
    // 设置 self 不再自动调整位置
//    [self.homeView.tableView reloadData];
//    self.homeView.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel:) name:[NSString stringWithFormat:@"%@getFirstModel", _urlString] object:nil];

    self.instance = [ONECollectionInstance shareCollection];
    self.homeModel = [[ONEHomeModel alloc] init];
    _homeModel.urlString = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/onelist/%@/0?cchannel=ios&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    [_homeModel getCellModel:_urlString];
}

- (void)getModel:(NSNotification *)notification {
    // 创建视图
    self.homeView = [[ONEHomeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.homeView.delegate = self;
    
    // 设置 firstCell 的 model
    self.homeView.firstModel = [notification.userInfo objectForKey:@"1"];
    self.homeView.firstMainModel = [notification.userInfo objectForKey:@"2"];
    self.homeView.secondMainModel = [notification.userInfo objectForKey:@"3"];
    self.homeView.thridMainModel = [notification.userInfo objectForKey:@"4"];
    self.homeView.fourthMainModel = [notification.userInfo objectForKey:@"5"];
    self.homeView.fifthMainModel = [notification.userInfo objectForKey:@"6"];
    self.homeView.sixMainModel = [notification.userInfo objectForKey:@"7"];
    self.homeView.number = notification.userInfo.count;
//    NSLog(@"%@ %ld", notification.userInfo, notification.userInfo.count);
    
    [self.homeView calculateHeight];
    [self.view addSubview:self.homeView];
    
}

// 检测tableView的位置，达到隐藏状态栏的效果
//- (void)tableViewDidScroll:(UITableView *)tableView {
//    CGFloat height = 0.0;
//    CGFloat contentOffsetY = tableView.contentOffset.y;
//    if (contentOffsetY <= height) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"barHidden" object:nil];
//    } else {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"barNoHidden" object:nil];
//    }
//}

// 点击收藏按钮
// 将文章的id存入单例中的字典中
- (void)collectType:(NSString *)type model:(ONEMainCellModel *)model {
//    NSLog(@"%@", type);
    if ([type isEqual:@"- ONE STORY  -"] || [type isEqual:@"- 阅读  -"]) {
        [_instance.articleDic setValue:model forKey:model.title];
//        NSLog(@"_instance.articleDic中的信息%@", _instance.articleDic);
    } else if ([type isEqual:@"- 问答  -"]) {
        [_instance.anwersDic setValue:model forKey:model.title];
    } else if ([type isEqual:@"- 连载  -"]) {
        [_instance.serialDic setValue:model forKey:model.title];
    }
}

// 取消收藏
// 通过文章id将单例字典中的信息删除
- (void)cancleCollectType:(NSString *)type itemId:(NSString *)item {
//    NSLog(@"%@", type);
    if ([type isEqual:@"- ONE STORY  -"] || [type isEqual:@"- 阅读  -"]) {
        [_instance.articleDic removeObjectForKey:item];
        NSLog(@"_instance.articleDic中的信息%@", _instance.articleDic);
    } else if ([type isEqual:@"- 问答  -"]) {
        [_instance.anwersDic removeObjectForKey:item];
    } else if ([type isEqual:@"- 连载  -"]) {
        [_instance.serialDic removeObjectForKey:item];
    }
}

// 图文的收藏和取消
- (void)collectPictureModel:(ONEFirstCellModel *)model title:(NSString *)title {
    [_instance.pictureDic setValue:model forKey:title];
    
//    NSLog(@"_instance.pictureDic中的信息%@", _instance.pictureDic.allKeys);
}
- (void)cancleCollectPictureTitle:(NSString *)title {
    [_instance.pictureDic removeObjectForKey:title];
}

- (void)pushArticleViewController:(NSString *)string label:(NSString *)label author:(NSString *)author{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:string, @"url", label, @"label", author, @"author", nil];
    NSNotification *notification = [[NSNotification alloc] initWithName:@"pushArticleViewController" object:nil userInfo:dictionary];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
