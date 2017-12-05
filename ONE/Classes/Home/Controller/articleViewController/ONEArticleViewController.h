//
//  ONEArticleViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/2.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEArticleModel.h"
#import "ONEArticleView.h"


@interface ONEArticleViewController : UIViewController

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *commentUrl;
@property (nonatomic, strong) ONEArticleView *articleView;

@end
