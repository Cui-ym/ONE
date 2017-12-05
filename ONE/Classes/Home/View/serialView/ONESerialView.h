//
//  ONESerialView.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/3.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ONEContentTableViewCell.h"
#import "ONECommentTableViewCell.h"

@interface ONESerialView : UIView <WKNavigationDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *webString;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;
@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, copy) NSArray *commentArray;

@property (nonatomic, strong) ONEContentTableViewCell *serialCell;
@property (nonatomic, strong) ONECommentTableViewCell *commentCell;

- (void)calculateHeight;

@end
