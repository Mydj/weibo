//
//  ThemeTableViewController.m
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "ThemeManager.h"
#import "ThemeCell.h"

@interface ThemeTableViewController ()

@property(nonatomic,strong)NSDictionary *themeDic;
@end

@implementation ThemeTableViewController



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
    
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _themeDic = [ThemeManager shareManager].themeDic;
    
    
    
    //设置默认的颜色
    [self themeChange];
    
   }


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _themeDic.count;
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"themeCell" forIndexPath:indexPath];
    
    
    
    NSArray *allKeys= [_themeDic allKeys];
    //单元格上显示的内容
    NSString *themeName = allKeys[indexPath.row];
    
    cell.themeLabel.text = themeName;
    //改变单元格字体的颜色
    cell.themeLabel.textColor = [[ThemeManager shareManager]themeColorWithColorName:@"Compose_Option_color"];
    
    //显示的图片(获取路径)(1.jap - >找到路径->读取图片返回给我们)
    //(获取路径)
    //根据主题名字,获取主题路径
    
    NSString * themePath =[ThemeManager shareManager].themeDic[themeName];
    
     NSString *imgPath = [[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:themePath] stringByAppendingPathComponent:@"more_icon_theme.png"];
    
    cell.themeImgView.image = [UIImage imageWithContentsOfFile:imgPath];
    

    
    //获取当前主题
    if ( [[ThemeManager shareManager].themeName isEqualToString:themeName]) {
        //对勾
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
   
    
   

    
    return cell;
}
//选中单元格调用代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     NSArray *allKeys= [_themeDic allKeys];
    
    //切换主题
    [ThemeManager shareManager].themeName = allKeys[indexPath.row];
    
    [tableView reloadData];
    
    
}









@end
