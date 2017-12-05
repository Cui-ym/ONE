//
//  ONEAnswerTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/2.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ONEAnswerTableViewCell : UITableViewCell <WKNavigationDelegate>

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *questioner;
@property (nonatomic, strong) UILabel *question;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) WKWebView *answer;

+ (CGFloat)cellHeightTitle:(NSString *)title question:(NSString *)question size:(CGSize)contextSize;
@end
