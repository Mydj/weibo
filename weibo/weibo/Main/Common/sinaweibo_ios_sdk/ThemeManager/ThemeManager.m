//
//  ThemeManager.m
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "ThemeManager.h"

@interface ThemeManager ()

@property(nonatomic,strong)NSDictionary *colorDic;

@end
@implementation ThemeManager


+ (instancetype)shareManager{
    
    static ThemeManager *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
        
    
        
    });
    return instance;
    
}

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        //默认的主题名字(坑)
        
        //读取保存的主题
         NSString *themeName= [[NSUserDefaults standardUserDefaults]valueForKey:@"kThemeName"];
        
        _themeName = themeName ? :@"猫爷";
        
        //读取plist文件
        
         _themeDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil]];
        
        //读取默认的颜色配置文件
        [self _loadColorConfigFile];
        
    }
    
    return self;
}

- (void)_loadColorConfigFile{
    
    //拼接路径budel/skins/con
     NSString *path = [self.themePath stringByAppendingPathComponent:@"config.plist"];
    
    
    _colorDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    
    
    
}


//拼接路径//bundel/cat/
- (NSString *)themePath{
    
    
    //取出cat
     NSString *themePath= [_themeDic objectForKey:_themeName];
    
   return  [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:themePath];
    
    
    
}

- (void)setThemeName:(NSString *)themeName{
    _themeName = themeName;
    
    //主题改变的时候,重新读取颜色配置文件
    [self _loadColorConfigFile];

    //发送通知
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ThmeChangeNSNotification" object:nil];
    //主题改变的时候,保存当前主题
    
    //系统的plist文件(沙盒)
    
    [[NSUserDefaults standardUserDefaults]setValue:_themeName forKey:@"kThemeName"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
    
    
    
    
}

//plist文件
//返回蓝色文件夹下面的图片
- (UIImage *)themeImgWithImgName:(NSString *)imgName{
    
    //bundel/Skins/猫爷/1.jap/
    
    //猫爷:cat
    //魁拔:kuiba
     NSString * imPath = [self.themePath stringByAppendingPathComponent:imgName];
    

    
    return [UIImage imageWithContentsOfFile:imPath];
    
}
//返回蓝色文件夹下面的rgb颜色
- (UIColor *)themeColorWithColorName:(NSString *)colorName{
    
     NSDictionary *rgbDic= _colorDic[colorName];
    
     float r = [rgbDic[@"R"]floatValue];
     float g = [rgbDic[@"G"]floatValue];
     float b = [rgbDic[@"B"]floatValue];
    
    float alpha  = rgbDic[@"alpha"] ? [rgbDic[@"alpha"] floatValue] :1;
    
   return  [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:alpha];
    
    
    
    
    
}


@end
