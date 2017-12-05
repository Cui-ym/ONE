//
//  ONEHomeModel.h
//  ONE
//
//  Created by 崔一鸣 on 2017/10/10.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "ONEMainCellModel.h"
#import "ONEFirstCellModel.h"

@interface ONEHomeModel : NSObject

@property (nonatomic) NSString *urlString;
@property (nonatomic) NSDictionary *dic;
@property (nonatomic) ONEFirstCellModel *firstModel;

- (void)getModel;
- (void)getCellModel:(NSString *)str;
- (void)firstJsonParsing;

@end
