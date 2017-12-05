//
//  ONECollectionInstance.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/23.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONECollectionInstance : NSObject

@property (nonatomic, strong) NSMutableDictionary *pictureDic;
@property (nonatomic, strong) NSMutableDictionary *articleDic;
@property (nonatomic, strong) NSMutableDictionary *anwersDic;
@property (nonatomic, strong) NSMutableDictionary *serialDic;

+(instancetype)shareCollection;
@end
