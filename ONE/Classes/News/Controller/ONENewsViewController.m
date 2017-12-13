//
//  ONENewsViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/12/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONENewsViewController.h"
#import "ONENewsContentViewController.h"
#import "ONENewsTableView.h"
#import "ONENewsManager.h"
#import "ONENewsModel.h"

#import <MJRefresh.h>

#define mainFrameSize self.view.frame.size

@interface ONENewsViewController ()<ONENewsViewDelegate>

{
    int tableViewArray[5];
}

@end

@implementation ONENewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置标题栏属性
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:dictionary];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"新闻";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化 newsView
    self.newsView = [[ONENewsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.newsView.delegate = self;
    [self.view addSubview:_newsView];
    
    // 初始化array
    self.array = [NSArray arrayWithObjects:@"5572a108b3cdc86cf39001cd", @"5572a108b3cdc86cf39001ce", @"5572a109b3cdc86cf39001db", @"5572a108b3cdc86cf39001d1", @"5572a109b3cdc86cf39001da", nil];
    
    // 初始化tableView数组
    for (int i = 0; i < 5; i++) {
        if (i == 2)
            continue;
        tableViewArray[i] = 0;
    }
    
    // Do any additional setup after loading the view.
}

// 点击按钮移动scrollView
- (void)clickButton:(UIButton *)sender {
    __weak ONENewsViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.newsView.scrollView.contentOffset = CGPointMake(mainFrameSize.width * (sender.tag - 1), 0);
    } completion:^(BOOL finished) {
        weakSelf.newsView.homeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        weakSelf.newsView.internationalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        weakSelf.newsView.itBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        weakSelf.newsView.latestBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        weakSelf.newsView.socialBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        sender.titleLabel.font = [UIFont systemFontOfSize:19];
    }];
}

// scrollView停止滚动 变换按钮的选定
// 添加 tableView 并获取网络数据
- (void)scrollEndPosition:(CGPoint)point {
    int tag = point.x / 375;
    self.newsView.homeBtn.selected = NO;
    self.newsView.internationalBtn.selected = NO;
    self.newsView.itBtn.selected = NO;
    self.newsView.latestBtn.selected = NO;
    self.newsView.socialBtn.selected = NO;
    self.newsView.homeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.newsView.internationalBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.newsView.itBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.newsView.latestBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.newsView.socialBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIButton *button = [self.newsView viewWithTag:tag + 1];
    button.selected = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:19];
    
    // 网络请求 并更新tableView
    if (!tableViewArray[tag]) {
        ONENewsManager *manager = [[ONENewsManager alloc] init];
        [manager doGet:_array[tag] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *error;
            ONENewsModel *model = [[ONENewsModel alloc] initWithDictionary:responseObject error:&error];
            // 添加tableView
            [self.newsView setNewsTableView:tag flag:tableViewArray[tag] model:model.showapi_res_body.pagebean.contentlist];
            tableViewArray[tag] = 1;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}

// 刷新重新获取数据
- (void)getTableViewData:(NSInteger)num table:(ONENewsTableView *)table which:(int)add{
    ONENewsManager *manager = [[ONENewsManager alloc] init];
//    int i = (int)num ;
//    NSLog(@"%ld %d", num, i);
    [manager doGet:_array[num] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        ONENewsModel *model = [[ONENewsModel alloc] initWithDictionary:responseObject error:&error];
        if (add == 0) {
            table.newsArray = model.showapi_res_body.pagebean.contentlist;
            [table calculateHeight];
            [table reloadData];
            [table.mj_header endRefreshing];
        } else {
            for (id obj in model.showapi_res_body.pagebean.contentlist) {
                table.newsArray = (NSArray<ONENewsItemModel> *)[table.newsArray arrayByAddingObject:obj];
            }
            [table calculateHeight];
            [table reloadData];
            [table.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

// push进详细界面
- (void)pushContentViewControllerWithString:(NSString *)html {
    ONENewsContentViewController *controller = [[ONENewsContentViewController alloc] init];
    controller.webString = html;
    [self.navigationController pushViewController:controller animated:YES];
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
