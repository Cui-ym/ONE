//
//  ONEWordsNewsTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/12/11.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONENewsModel.h"

@interface ONEWordsNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *datailLab;
@property (nonatomic, strong) UILabel *timeLab;

@end
