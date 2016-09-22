//
//  WeiboLayout.h
//  weibo
//
//  Created by apple on 16/7/6.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WeiboModel.h"

@interface WeiboLayout : NSObject
//单元格的高度
@property(nonatomic,assign)CGFloat cellHeight;
//微博正文
@property(nonatomic,assign)CGRect weiboTextFrame;

//数据
@property(nonatomic,strong)WeiboModel *weibo;

//微博图片的frame(转发微博图片的frame)
@property(nonatomic,assign)CGRect weiboImgFrame;
//转发微博的背景视图的frame
@property(nonatomic,assign)CGRect reWeiboBgImgFrame;

//转发微博的正文的frame
@property(nonatomic,assign)CGRect reWeoboTextFrame;

//多张图片的frame
@property(nonatomic,strong)NSMutableArray *weiboImgFrameArr;




@end
