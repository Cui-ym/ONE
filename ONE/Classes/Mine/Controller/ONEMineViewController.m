//
//  ONEMineViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/5.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONEMineViewController.h"
#import "ONEPersonalTableViewCell.h"

#define viewHeight self.view.frame.size.height
#define viewWidth  self.view.frame.size.width

@interface ONEMineViewController () <ONESetViewControllerDelegate>

@end

@implementation ONEMineViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushSetController)
                                                 name:@"pushController"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pushCollectionController:)
                                                 name:@"pushCollectionController"
                                               object:nil];
    self.mineModel = [[ONEMineModel alloc] init];
    self.mineView.mineModel = _mineModel;
    self.mineView = [[ONEMineView alloc] initWithFrame:CGRectMake(0, -10, viewWidth, viewHeight + 10)];
    
    [self.view addSubview: _mineView];
    // Do any additional setup after loading the view.
}

- (void)setMineViewModel {
    self.mineView.mineModel = _mineModel;
    [self.mineView.tableView reloadData];
}

- (void)pushCollectionController:(NSNotification *)notification {
    NSString *string = [notification.userInfo objectForKey:@"collection"];
    if ([string  isEqual: @"图 文"]) {
        _pictureController.string = @"图文";
        self.pictureController = [[ONECollectionViewController alloc] init];
        [self.pictureController loadCollectionView:@"图文"];
        [self.navigationController pushViewController:_pictureController animated:YES];
    } else if ([string  isEqual: @"阅 读"]) {
        self.articleController = [[ONECollectionViewController alloc] init];
        [self.articleController loadCollectionView:@"阅读"];
        [self.navigationController pushViewController:_articleController animated:YES];
//        NSLog(@"%@", string);
    } else if ([string  isEqual: @"问 答"]) {
        self.anwersController = [[ONECollectionViewController alloc] init];
        [self.anwersController loadCollectionView:@"问答"];
        [self.navigationController pushViewController:_anwersController animated:YES];
        
//        NSLog(@"%@", string);
    } else if ([string  isEqual: @"连 载"]) {
        self.serialController = [[ONECollectionViewController alloc] init];
        [self.serialController loadCollectionView:@"连载"];
        [self.navigationController pushViewController:_serialController animated:YES];
//        NSLog(@"%@", string);
    }
}

- (void)pushSetController {
    self.setViewController = [[ONESetViewController alloc] init];
    self.setViewController.mineModel = [[ONEMineModel alloc] init];
    _setViewController.mineModel = _mineModel;
    [_setViewController setSetView];
//    NSLog(@"mineView %@", _setViewController.mineModel.nameStr);
    _setViewController.delegate = self;
    [self.navigationController pushViewController:_setViewController animated:YES];
}

- (void)pushMineModel:(ONEMineModel *)model {
    self.mineModel = model;
    [self setMineViewModel];
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
