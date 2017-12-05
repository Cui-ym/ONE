//
//  ONEArticleModel.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/2.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEArticleModel.h"
#import <AFNetworking.h>

@implementation ONEArticleModel

- (void)getArticleDetails {
    
    NSString *url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/essay/%@?channel=ios&source=summary&source_id=9261&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.title = [[responseObject objectForKey:@"data"] objectForKey:@"hp_title"];
        self.author = [[responseObject objectForKey:@"data"] objectForKey:@"hp_author"];
        self.article = [[responseObject objectForKey:@"data"] objectForKey:@"hp_content"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_title, @"title", _author, @"author", _article, @"article", nil];
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getArticle", _urlString] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    
    // 获取评论信息
    NSString *commentUrl = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/essay/%@/0?channel=ios&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    AFHTTPSessionManager *commentManager = [AFHTTPSessionManager manager];
    [commentManager GET:commentUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.commentArray = [NSArray array];
        self.commentArray = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_commentArray, @"comment", nil];
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getArticleComment", _urlString] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

@end
