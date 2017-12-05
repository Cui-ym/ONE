//
//  ONEAnwersModel.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ONEAnwersModel : NSObject

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *anwers;
@property (nonatomic, copy) NSArray *commentArray;

- (void)getAnwersDetails;

@end
