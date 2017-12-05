//
//  ONECollectionInstance.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/23.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONECollectionInstance.h"

@implementation ONECollectionInstance

static ONECollectionInstance *_instance = nil;

+ (instancetype)shareCollection
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
        _instance.articleDic = [NSMutableDictionary dictionary];
        _instance.anwersDic = [NSMutableDictionary dictionary];
        _instance.pictureDic = [NSMutableDictionary dictionary];
        _instance.serialDic = [NSMutableDictionary dictionary];
    }) ;
    return _instance ;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [ONECollectionInstance shareCollection] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [ONECollectionInstance shareCollection] ;
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

@end
