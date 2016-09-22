//
//  MoreViewController.m
//  weibo
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "MoreViewController.h"
#import "ThemeLabel.h"
#import "ThemeManager.h"
#import "ThemeImageView.h"


@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet ThemeImageView *row1ImageView;
@property (weak, nonatomic) IBOutlet ThemeLabel *row1Label1;
@property (weak, nonatomic) IBOutlet ThemeLabel *row1Lable2;


@end

@implementation MoreViewController


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        //监听主题切换的通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:@"ThmeChangeNSNotification" object:nil];
    }
    
    return self;
}

- (void)themeChange{
    //表示图的背景颜色和分割线的颜色
    
    UIColor *tableViewColor = [[ThemeManager shareManager]themeColorWithColorName:@"More_Item_color"];
    
    self.tableView.backgroundColor = tableViewColor;
    
    //线的颜色
    UIColor *lineColor = [[ThemeManager shareManager]themeColorWithColorName:@"More_Item_Line_color"];
    
    
    self.tableView.separatorColor = lineColor;
    //显示当前主题的名字
    _row1Lable2.text =  [ThemeManager shareManager].themeName;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _row1ImageView.imageName = @"more_icon_theme";
    
    _row1Label1.colorName = @"More_Item_Text_color";
    _row1Lable2.colorName = @"More_Item_Text_color";
    
    //显示当前主题的名字
    _row1Lable2.text =  [ThemeManager shareManager].themeName;
    
    //设置默认的颜色
    [self themeChange];
    
    
    
}


@end
