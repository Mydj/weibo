//
//  ThemeButton.m
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton
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

-(void)setImageName:(NSString *)imageName{
    
    _imageName = imageName;
    
    //图片名字一改变,就切换主题
    [self themeChange];
   
}

- (void)themeChange{
    
    //重新设置图片//themeName
    
     UIImage *image = [[ThemeManager shareManager]themeImgWithImgName:_imageName];
    
    [self setImage:image forState:UIControlStateNormal];
    
    
    
    
    
}

@end
