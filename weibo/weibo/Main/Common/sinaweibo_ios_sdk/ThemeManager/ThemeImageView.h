//
//  ThemeImageView.h
//  weibo
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView
@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,assign)CGFloat leftCapWidth;
@property(nonatomic,assign)CGFloat rightCapWidth;
@end
