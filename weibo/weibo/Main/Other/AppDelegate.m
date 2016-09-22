//
//  AppDelegate.m
//  weibo
//
//  Created by liuwei on 16/1/16.
//  Copyright (c) 2016年 baidu. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "LeftViewController.h"
#include "RightViewController.h"
#import "MMDrawerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //
    
   
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _window.backgroundColor = [UIColor whiteColor];
     MainTabBarController *main = [[MainTabBarController alloc]init];

    
    [_window makeKeyAndVisible];
    
    //左侧控制器
    
    LeftViewController *left = [[LeftViewController alloc]init];
    
    //右侧的控制器
    RightViewController *right = [[RightViewController alloc]init];
    //创建mm控制器管理上方的三个子控制器
    
    MMDrawerController *drawController = [[MMDrawerController alloc]initWithCenterViewController:main leftDrawerViewController:left rightDrawerViewController:right];
    //设置左右控制器显示的范围
    
    [drawController setMaximumLeftDrawerWidth:200.0];
    [drawController setMaximumRightDrawerWidth:150.0];
    
    
    
    //设置打开的区域
    
    [drawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    
    //设置关闭的区域
    [drawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    self.window.rootViewController = drawController;
    

    
    
    
    
    
    
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey
                                        appSecret:kAppSecret
                                   appRedirectURI:kAppRedirectURI
                                      andDelegate:nil];
    //系统的plist文件(沙盒)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //sinaweiboInfo nil
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] &&
        [sinaweiboInfo objectForKey:@"ExpirationDateKey"] &&
        [sinaweiboInfo objectForKey:@"UserIDKey"]) {
        
        
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate =
        [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    
    
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
