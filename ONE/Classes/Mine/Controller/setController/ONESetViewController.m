//
//  ONESetViewController.m
//  ONE
//
//  Created by 崔一鸣 on 2017/11/7.
//  Copyright © 2017年 崔一鸣. All rights reserved.
//

#import "ONESetViewController.h"

@interface ONESetViewController () <ONESetViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

{
    NSArray *array;
}

@end


@implementation ONESetViewController

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarHidden) name:@"tabBarHidden" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarNotHidden) name:@"tabBarNotHidden" object:nil];
    // 键盘回收事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWillDisAppear:(NSNotification *)notification{
    [UIView animateWithDuration:1 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, 0);}];
}

- (void)keyboardWillAppear:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    [UIView animateWithDuration:1.0 animations:^{self.view.transform = CGAffineTransformMakeTranslation(0, keyboardY - self.view.frame.size.height - 44 + self.tabBarController.tabBar.frame.size.height);}];
}

- (void)setSetView{
    self.setView = [[ONESetView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _setView.mineModel = _mineModel;
    NSLog(@"%@", _mineModel.nameStr);
    self.setView.delegate = self;
    [self.view addSubview:_setView];
}

- (void)tabBarHidden {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)tabBarNotHidden {
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didSelectCell:(ONESetTableViewCell *)cell {
    NSLog(@"select:::%@", cell);
    self.setCell = cell;
    NSString *string = cell.headLabel.text;
    if ([string  isEqual: @"头像"] || [string isEqual: @"个人主页背景"]) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    } else if ([string isEqual:@"昵称"]) {
        UIAlertController *inputAlert = [UIAlertController alertControllerWithTitle:@"请输入昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [inputAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"your name";
            textField.text = cell.label.text;
            textField.secureTextEntry = NO;
        }];
        UIAlertAction *cencelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [inputAlert.textFields[0] resignFirstResponder];
        }];
        [inputAlert addAction:cencelAction];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cell.label.text = inputAlert.textFields[0].text;
            _mineModel.nameStr = inputAlert.textFields[0].text;
            [inputAlert.textFields[0] resignFirstResponder];
        }];
        [inputAlert addAction:yesAction];
        [self presentViewController:inputAlert animated:YES completion:nil];
    } else if ([string isEqual:@"性别"]) {
        NSArray *array = [NSArray arrayWithObjects:@"男", @"女", nil];
        self.setView.dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:array, [NSString stringWithFormat:@"0"], nil];
        self.setView.flag = 0;
        self.setView.number = 1;
        [self.setView addPickerView];
    } else if ([string isEqual:@"生日"]) {
        self.setView.flag = 1;
        [self.setView addPickerView];
    } else if ([string isEqual:@"地区"]) {
        self.setView.flag = 2;
        self.setView.number = 2;
        [self.setView addPickerView];
    }
}

//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSLog(@"%@", info);
    if ([_setCell.headLabel.text  isEqual: @"头像"]) {
        self.headImage = newPhoto;
        self.mineModel.headDic = info;
    } else {
        self.backgroundImage = newPhoto;
        self.mineModel.backgroundDic = info;
    }
    //把newPhono设置成头像
    _setCell.picture.image = newPhoto;
    //关闭当前界面，即回到主界面去
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    _mineModel.profilesStr = _setView.mineModel.profilesStr;
    if ([self.delegate respondsToSelector:@selector(pushMineModel:)]) {
        [self.delegate pushMineModel:_mineModel];
        NSLog(@"%@", _mineModel.profilesStr);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
