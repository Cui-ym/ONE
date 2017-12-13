//
//  ONENewsManager.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONENewsManager.h"
#import <AFNetworking.h>

@implementation ONENewsManager

- (void)doGet:(NSString *)style success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    NSString *url = [NSString stringWithFormat:@"http://route.showapi.com/109-35?channelId=%@&showapi_appid=51511&showapi_sign=08f67fa57b6b4d6f8ea773accd2a6011&needHtml=1", style];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:success failure:failure];
}

@end
