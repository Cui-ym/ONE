//
//  ONECollectionViewController.h
//  ONE
//
//  Created by 崔一鸣 on 2017/11/23.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ONECollectionView.h"

@interface ONECollectionViewController : UIViewController

@property (nonatomic, strong) ONECollectionView *collectionView;
@property (nonatomic, copy) NSString *string;

- (void)loadCollectionView:(NSString *)labelStr;

@end
