//
//  AppDelegate.h
//  weibo
//
//  Created by liuwei on 16/1/16.
//  Copyright (c) 2016年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

#define kAppKey             @"1111650187"
#define kAppSecret          @"56a1f293af5cdc44625c86a61c5dc141"
#define kAppRedirectURI     @"http://www.baidu.com"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic) SinaWeibo *sinaweibo;

@end

