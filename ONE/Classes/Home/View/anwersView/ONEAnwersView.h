//
//  ONEAnwersView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ONEAnswerTableViewCell.h"
#import "ONECommentTableViewCell.h"

@interface ONEAnwersView : UIView <WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *questioner;
@property (nonatomic, copy) NSString *question;
@property (nonatomic, copy) NSString *author;

@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, strong) WKWebView *answer;
@property (nonatomic, strong) NSString *webString;
@property (nonatomic, assign) CGFloat webHeight;

@property (nonatomic, copy) NSArray *commentArray;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

@property (nonatomic, strong) ONEAnswerTableViewCell *answerCell;
@property (nonatomic, strong) ONECommentTableViewCell *commentCell;

- (void)calculateHeight;

@end
