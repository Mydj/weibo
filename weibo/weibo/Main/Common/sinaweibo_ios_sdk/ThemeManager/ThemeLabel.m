//
//  ThemeLabel.m
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

- (void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ThmeChangeNSNotification" object:nil];
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:@"ThmeChangeNSNotification" object:nil];
    }
    return self;
}


- (void)themeChange{
    
    
    //根据颜色的key 设置不同的主题颜色
    self.textColor = [[ThemeManager shareManager]themeColorWithColorName:_colorName];
    
    
    
}

- (void)setColorName:(NSString *)colorName{
    
    _colorName = colorName;
    
    [self themeChange];
    
    
    

    
    
}

@end
