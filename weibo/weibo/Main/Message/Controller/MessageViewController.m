//
//  MessageViewController.m
//  weibo
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "MessageViewController.h"
#import "FaceView.h"
#import "Common.h"
#import "MMDrawerController.h"
#import "FacePannel.h"

@interface MessageViewController ()

@end

@implementation MessageViewController



//在运行内存中绘制
//渲染到屏幕上
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //禁止滑动视图向下偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    FacePannel *face = [[FacePannel alloc]initWithFrame:CGRectMake(0, 100, 0, 0)];
    
    [self.view addSubview:face];
    
    
    
    
}
//关闭侧滑功能
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    MMDrawerController *ctrl = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [ctrl  setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];

    
}
//开启侧滑功能
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    MMDrawerController *ctrl = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [ctrl  setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}




@end
