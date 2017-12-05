//
//  ONEHomeModel.m
//  ONE
//
//  Created by 崔一鸣 on 2017/10/10.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEHomeModel.h"

@implementation ONEHomeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstModel = [[ONEFirstCellModel alloc] init];
    }
    
    return self;
}

// cell 信息获取
// 通过 url 来发送对应时间的通知
- (void)getCellModel:(NSString *)str {
    
    _urlString = [_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:_urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _dic = responseObject;
        NSArray *array = [[_dic objectForKey:@"data"] objectForKey:@"content_list"];
        [self firstJsonParsing];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_firstModel, @"1", nil];
        for (int i = 1, j = 1; i < array.count; i++) {
            ONEMainCellModel *model = [[ONEMainCellModel alloc] init];
            NSArray *arr = [array[i] objectForKey:@"tag_list"];
            if (arr.count != 0) {
//                NSLog(@"%@", arr);
                NSString *string = [arr[0] objectForKey:@"title"];
                if ([string isEqual:@"广告"]) {
                    continue;
                }
            }
            model = [self mainJsonParsing:array[i]];
            if ([model.label  isEqual: @"- 音乐  -"] || [model.label  isEqual: @"- 电影  -"] || [model.label  isEqual: @"- (null) -"] || [model.label  isEqual: @"- 深夜电台  -"] || [model.label  isEqual: @"- 周末读诗  -"] || [model.label  isEqual: @"- 广告  -"] ) {
                continue;
            } else {
                j++;
                NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:model, [NSString stringWithFormat:@"%d", j], nil];
                [dic addEntriesFromDictionary:dictionary];
            }
        }
        
        // 发送通知
        NSNotification *notification = [NSNotification notificationWithName:[NSString stringWithFormat:@"%@getFirstModel", str] object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

// 获取日期编码
- (void)getModel {
    _urlString = [_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:_urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 发送通知
        NSNotification *notification = [NSNotification notificationWithName:@"everyday" object:nil userInfo:responseObject];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@", error);
    }];
}

// JSON 数据解析
- (void)firstJsonParsing {
    NSArray *array = [[_dic objectForKey:@"data"] objectForKey:@"content_list"];
    _firstModel.urlString = _urlString;
    _firstModel.time = [array[0] objectForKey:@"post_date"];
    _firstModel.label = [array[0] objectForKey:@"title"];
    _firstModel.author = [array[0] objectForKey:@"pic_info"];
    _firstModel.article = [array[0] objectForKey:@"forward"];
    _firstModel.title = [array[0] objectForKey:@"words_info"];
    _firstModel.picture = [array[0] objectForKey:@"img_url"];
//    NSLog(@"%@", array[0]);
    NSString *year = [_firstModel.time substringWithRange:NSMakeRange(0, 4)];
    NSString *mon = [_firstModel.time substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [_firstModel.time substringWithRange:NSMakeRange(8, 2)];
    _firstModel.time = [NSString stringWithFormat:@"%@   /   %@   /   %@", year, mon, day];
    
    _firstModel.label = [NSString stringWithFormat:@"%@|%@", _firstModel.label, _firstModel.author];
    
}

- (ONEMainCellModel *)mainJsonParsing:(NSDictionary *)dictionary {
    ONEMainCellModel *model = [[ONEMainCellModel alloc] init];
//    NSLog(@"%@", dictionary);
    NSString *label = [[[dictionary objectForKey:@"share_list"] objectForKey:@"wx_timeline"] objectForKey:@"title"];
    NSRange range = [label rangeOfString:@"|"];
//    NSLog(@"%@", label);
    
    model.label = [NSString stringWithFormat:@"- %@ -",[label substringToIndex:range.location]];
    model.title = [dictionary objectForKey:@"title"];
    model.article = [dictionary objectForKey:@"forward"];
    model.author = [[dictionary objectForKey:@"author"] objectForKey:@"user_name"];
    model.time = [dictionary objectForKey:@"post_date"];
    model.picture = [dictionary objectForKey:@"img_url"];
    model.item_id = [dictionary objectForKey:@"item_id"];
    NSString *mon = [model.time substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [model.time substringWithRange:NSMakeRange(8, 2)];
    model.time = [NSString stringWithFormat:@"%@月%@日",mon, day];
    
//    NSLog(@"%@ %@ %@", model.time, model.label, model.item_id);
    
    
    return model;
}

@end
