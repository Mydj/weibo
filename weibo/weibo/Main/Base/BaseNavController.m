//
//  BaseNavController.m
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "BaseNavController.h"
#import "ThemeManager.h"

@interface BaseNavController ()

@end

@implementation BaseNavController


- (void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ThmeChangeNSNotification" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏设置默认的图片
    [self themeChange];
    
    
}
//代码创建会调用此方法
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:@"ThmeChangeNSNotification" object:nil];
    }
    return self;
}
//xib创建调用的方法
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    
//    return nil;
//    
//}



//用sb创建调用的初始化方法

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    
    if (self) {
        //接收通知
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:@"ThmeChangeNSNotification" object:nil];
    }
    
    return self;
}

- (void)themeChange{
    
    //找到导航栏对应的图片
    
    UIImage *image =  [[ThemeManager shareManager]themeImgWithImgName:@"mask_titlebar64.png"];
    
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    
    
}

@end
