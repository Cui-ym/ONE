//
//  ONEMainTableViewCell.h
//  ONE
//
//  Created by 崔一鸣 on 2017/10/1.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONEMainCellModel.h"
#import "ONECollectionInstance.h"

@protocol ONEMainTableViewCellDelegate<NSObject>

@optional
- (void)clickCollectionButton:(UIButton *)button type:(NSString *)type model:(ONEMainCellModel *)model;

@end

@interface ONEMainTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *authorLab;
@property (nonatomic, strong) UILabel *articleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UIButton *collectionBtn; 
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *forwardBtn;

@property (nonatomic, weak) id<ONEMainTableViewCellDelegate> delegate;
@property (nonatomic, strong) ONEMainCellModel *model;
@property (nonatomic, strong) ONECollectionInstance *instance;

+(CGFloat)cellHeight:(ONEMainCellModel *)model size:(CGSize)contextSize;

- (void)setContent:(ONEMainCellModel *)model;

@end
