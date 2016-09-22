//
//  RightViewController.m
//  weibo
//
//  Created by apple on 16/7/8.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "RightViewController.h"
#import "ThemeButton.h"
#import "SendViewController.h"
#import "BaseNavController.h"
#import "Common.h"
@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    ThemeButton *btn = [ThemeButton buttonWithType:UIButtonTypeCustom];
    btn.imageName = @"newbar_icon_1.png";
    btn.frame = CGRectMake(100 - 40 - 20, 60, 40, 40);
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)clickAction:(UIButton *)btn{
    
    //发送微博的视图控制器
    SendViewController *ctrl = [[SendViewController alloc] init];
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:ctrl];
    
    [self presentViewController:nav animated:YES completion:NULL];
}

@end
