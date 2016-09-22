//
//  ThemeImageView.m
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

- (void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ThmeChangeNSNotification" object:nil];
}


- (void)awakeFromNib{
    
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:@"ThmeChangeNSNotification" object:nil];
    
}
//代码创建的初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(themeChange) name:@"ThmeChangeNSNotification" object:nil];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName{
    
    
    _imageName = imageName;
    
    [self themeChange];
    

}
- (void)themeChange{
    //重新设置图片
    
     UIImage *image = [[ThemeManager shareManager]themeImgWithImgName:_imageName];
    
    //拉伸图片的
   image = [image stretchableImageWithLeftCapWidth:_leftCapWidth topCapHeight:_rightCapWidth];
    
    
    self.image = image;
    
    
}
@end
