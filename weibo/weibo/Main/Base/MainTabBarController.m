//
//  MainTabBarController.m
//  weibo
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "MainTabBarController.h"
#import "Common.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "BaseNavController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    //构造三级控制器
    
    //(1)加载sb文件中的控制器
    
    [self _loadSubViewControllers];
    
    //移除所有的子视图
    [self _removeSubViews];
    

}



- (void)_loadSubViewControllers{
    
    
    //所有故事版的名字
    NSArray *name = @[@"Home",@"Message",@"Profile",@"Discover",@"More"];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    
    for (NSString *sbName in name) {
        
         UIStoryboard *storyboard= [UIStoryboard storyboardWithName:sbName bundle:nil];
        
        //加载导航控制器
         BaseNavController *nav= [storyboard instantiateInitialViewController];
        
        [arr addObject:nav];
        
    }
    //将导航控制器交给标签控制器管理
    
    self.viewControllers = arr;
    
    
}

- (void)_removeSubViews{
    //移除的子视图(UITabBarButton)
    
    ThemeImageView *imageView = [[ThemeImageView alloc]initWithFrame:self.tabBar.bounds];
    
    imageView.imageName = @"mask_navbar.png";
    
    [self.tabBar addSubview:imageView];

    
    for (UIView *view in self.tabBar.subviews) {
        

         Class c = NSClassFromString(@"UITabBarButton");
        
        //如果是c类型创建的,就删除
        if ([view isKindOfClass:c]) {
            
            [view removeFromSuperview];
        }
        
    }
    
    //button的宽
    CGFloat width = kScreenWidth / 5;
    
    for (NSInteger i = 0; i < 5; i++) {
        
        ThemeButton *button = [ThemeButton buttonWithType:UIButtonTypeCustom];
        
        
        NSString *imageName = [NSString stringWithFormat:@"home_tab_icon_%ld.png",i+1];
        
        button.frame = CGRectMake(i *width, 0, width, kTabBarHeight);
        //做一个标记
        
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        //指定图片名字
        button.imageName = imageName;
        
        [self.tabBar addSubview:button];
        
        
        
        
    }
    //设置tabbar背景图片
    
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"mask_navbar.png"]];
    
    
    
    
    //选中视图
    _selectImg = [[ThemeImageView alloc]init];
    //设置图片
    _selectImg.imageName = @"home_bottom_tab_arrow.png";
    _selectImg.frame = CGRectMake(0, 0, width, kTabBarHeight);
    
    [self.tabBar addSubview:_selectImg];
    
}

//点击button调用的方法

- (void)buttonAction:(UIButton *)sender{
    
    [UIView animateWithDuration:.35 animations:^{
        //切换选中视图
        _selectImg.center = sender.center;
        
        
    }];
    
    
    

   
 
    
    
    //切换子控制器
    self.selectedIndex = sender.tag;
    
    
    
    
    
    
    
}


@end
