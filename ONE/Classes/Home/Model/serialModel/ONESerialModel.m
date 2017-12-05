//
//  ONESerialModel.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONESerialModel.h"
#import <AFNetworking.h>

@implementation ONESerialModel

- (void)getSerialDetails {
    
    // 获取文章信息
    NSString *url = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/serialcontent/%@?channel=ios&source=channel_reading&source_id=9264&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.title = [[responseObject objectForKey:@"data"] objectForKey:@"title"];
        self.author = [[[responseObject objectForKey:@"data"] objectForKey:@"author"] objectForKey:@"user_name"];
        self.serial = [[responseObject objectForKey:@"data"] objectForKey:@"content"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_title, @"title", _author, @"author", _serial, @"serial", nil];
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getSerial", _urlString] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
    
    // 获取评论信息
    NSString *commentUrl = [NSString stringWithFormat:@"http://v3.wufazhuce.com:8000/api/comment/praiseandtime/serial/%@/0?channel=ios&version=4.2.2&uuid=ffffffff-a90e-706a-63f7-ccf973aae5ee&platform=ios", _urlString];
    AFHTTPSessionManager *commentManager = [AFHTTPSessionManager manager];
    [commentManager GET:commentUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.commentArray = [NSArray array];
        self.commentArray = [[responseObject objectForKey:@"data"] objectForKey:@"data"];
//        NSLog(@"%@ %@", responseObject, _urlString);
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_commentArray, @"comment", nil];
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getSerialComment", _urlString] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

@end
