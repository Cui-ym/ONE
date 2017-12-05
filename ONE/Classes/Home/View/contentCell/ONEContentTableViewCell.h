//
//  ONEContentTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/28.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <Masonry.h>

#import "UILabel+LabelHeight.h"

@interface ONEContentTableViewCell : UITableViewCell<WKNavigationDelegate>

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *author;
@property (nonatomic, strong) WKWebView *contentWeb;

+ (CGFloat)cellHeightTitle:(NSString *)title size:(CGSize)contextSize;

@end
