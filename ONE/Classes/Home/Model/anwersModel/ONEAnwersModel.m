//
//  ONEAnwersModel.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEAnwersModel.h"
#import <AFNetworking.h>

@implementation ONEAnwersModel

- (void)getAnwersDetails {
    
    NSString *url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/question/%@?channel=ios&source=channel_reading&source_id=9254&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.title = [[responseObject objectForKey:@"data"] objectForKey:@"question_title"];
        self.author = [[[responseObject objectForKey:@"data"] objectForKey:@"answerer"] objectForKey:@"user_name"];
        self.question = [[responseObject objectForKey:@"data"] objectForKey:@"question_content"];
        self.anwers = [[responseObject objectForKey:@"data"] objectForKey:@"answer_content"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_title, @"title", _author, @"author", _question, @"question", _anwers, @"answer", nil];
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getAnswer", _urlString] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    
    // 获取评论信息
    NSString *commentUrl = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/question/%@/0?channel=ios&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    AFHTTPSessionManager *commentManager = [AFHTTPSessionManager manager];
    [commentManager GET:commentUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.commentArray = [NSArray array];
        self.commentArray = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_commentArray, @"comment", nil];
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getAnswerComment", _urlString] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}


@end
