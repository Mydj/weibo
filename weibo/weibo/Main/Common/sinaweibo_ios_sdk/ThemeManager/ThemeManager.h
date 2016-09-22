//
//  ThemeManager.h
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

+ (instancetype)shareManager;

@property(nonatomic,strong)NSDictionary *themeDic;
@property(nonatomic,copy)NSString *themeName;//当前主题
//根据图片的名字找到对应的图片返回(1.jap)
- (UIImage *)themeImgWithImgName:(NSString *)imgName;
//根据颜色配置文件中的key找到对应主题包下面的颜色
- (UIColor *)themeColorWithColorName:(NSString *)colorName;


@end
