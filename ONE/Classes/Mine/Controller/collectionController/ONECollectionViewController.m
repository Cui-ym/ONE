//
//  ONECollectionViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/23.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONECollectionViewController.h"
#import "ONEArticleViewController.h"
#import "ONEAnwersViewController.h"
#import "ONESerialViewController.h"

@interface ONECollectionViewController ()<ONECollectionViewDelegate>

@end

@implementation ONECollectionViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)loadCollectionView:(NSString *)labelStr {
    _string = labelStr;
//    NSLog(@"string:%@", _string);
    self.navigationItem.title = _string;
    self.collectionView = [[ONECollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _collectionView.labelStr = _string;
    _collectionView.delegat = self;
    [_collectionView judgeStyle];
    [self.view addSubview:_collectionView];
}

- (void)pushContentView:(ONEMainCellModel *)model {
    NSString *label = model.label;
    if ([label  isEqual: @"- ONE STORY  -"] || [label  isEqual: @"- 阅读  -"]) {
        ONEArticleViewController *articleView = [[ONEArticleViewController alloc] init];
        articleView.urlString = model.item_id;
        [self.navigationController pushViewController:articleView animated:YES];
    } else if ([label  isEqual: @"- 问答  -"]) {
        ONEAnwersViewController *anwersView = [[ONEAnwersViewController alloc] init];
        anwersView.urlString = model.item_id;
        [self.navigationController pushViewController:anwersView animated:YES];
    } else if ([label  isEqual: @"- 连载  -"]) {
        ONESerialViewController *serialView = [[ONESerialViewController alloc] init];
        serialView.urlString = model.item_id;
        [self.navigationController pushViewController:serialView animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
