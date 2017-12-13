//
//  ONENewsManager.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONENewsManager : NSObject

- (void)doGet:(NSString *_Nullable)style
      success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
      failure:(void (^_Nullable)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

@end
