//
//  MYButton.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "MYButton.h"

@implementation MYButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect imageRect = self.imageView.frame;
    imageRect.origin.x = self.frame.size.width * 0.5 - imageRect.size.width * 0.5;
    imageRect.origin.y = 0.0;
    
    CGRect titleRect = self.titleLabel.frame;
    titleRect.origin.x = self.frame.size.width * 0.5 - titleRect.size.width * 0.5;
    titleRect.origin.y = self.frame.size.height * 0.5 ;
    
    self.imageView.frame = imageRect;
    self.titleLabel.frame = titleRect;
}

@end
