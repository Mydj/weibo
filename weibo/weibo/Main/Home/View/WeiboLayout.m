//
//  WeiboLayout.m
//  weibo
//
//  Created by apple on 16/7/6.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "WeiboLayout.h"
#import "Common.h"
#import "Label.h"

//空隙
#define kSpace 10
//单元格的默认高度
#define kCellHeight 60

//图片之间的空隙
#define kImageGap 5

@implementation WeiboLayout


- (NSMutableArray *)weiboImgFrameArr{
    
    
    if (_weiboImgFrameArr == nil) {
        _weiboImgFrameArr = [NSMutableArray array];
    }
    return _weiboImgFrameArr;
}

//计算单元格的高度,微博正文的高度

- (void)setWeibo:(WeiboModel *)weibo{
    
    //计算frame
    _weibo = weibo;
    
    self.cellHeight  = kCellHeight;
    
    //确定单元格每个子视图的frame
    //(1)计算微博正文所占用的空间(高)
//    CGRect textrect = [self.weibo.text boundingRectWithSize:CGSizeMake(kScreenWidth - kSpace, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:NULL];
    
    //使用Label提供的方法.设置动态单元格的高度
     CGFloat textHeight= [Label getTextHeight:16 width:kScreenWidth - kSpace text:self.weibo.text];
    
    
    //微博正文的frame
    self.weiboTextFrame = CGRectMake(kSpace, kCellHeight + kSpace, kScreenWidth - 2 * kSpace, textHeight);
    
    //更新单元格的高度
    
    self.cellHeight += CGRectGetHeight(self.weiboTextFrame)+kSpace;

    //微博图片的frame
//    if (_weibo.thumbnail_pic!=nil) {
    
//        self.weiboImgFrame = CGRectMake(CGRectGetMinX(self.weiboTextFrame), CGRectGetMaxY(self.weiboTextFrame)+kSpace, 100, 100);
        
//        self.cellHeight+=CGRectGetHeight(self.weiboImgFrame);
//    }
    
    //-------------------微博九宫格图片----------------------
    
    //多张图片的frame
    
    CGFloat imgX = CGRectGetMinX(self.weiboTextFrame);
    CGFloat imgY = CGRectGetMaxY(self.weiboTextFrame);
    
    CGFloat immSize = (CGRectGetWidth(self.weiboTextFrame) - 2 *kImageGap) / 3;
    
    //行
    NSInteger row = 0;
    //列
    NSInteger column = 0;
    //4
    for (NSInteger i = 0; i <_weibo.pic_urls.count; i++) {
        
        //控制行和列
        row  = i / 3;
        column = i % 3;
        
        
        CGRect rect = CGRectMake(imgX + column *(immSize + kImageGap), imgY + row *(immSize +kImageGap), immSize, immSize);
        
        [self.weiboImgFrameArr addObject:[NSValue valueWithCGRect:rect]];
        
    }
    
    //单元格的高度
    
    
    // 0 - 3 列
    // 0 - 2 空隙的取值范围
    //行数
     NSInteger line = (self.weiboImgFrameArr.count + 2) / 3;
    
    self.cellHeight += line * immSize + MAX(0, line - 1) *kImageGap + kSpace;
    
    
    //-----------------------------------------------------
    
    //转发微博的frame设置

    if (_weibo.retweeted_status !=nil) {
        //转发微博的frame
        self.reWeiboBgImgFrame = CGRectMake(CGRectGetMinX(self.weiboTextFrame), CGRectGetMaxY(self.weiboTextFrame)+kSpace, CGRectGetWidth(self.weiboTextFrame), 0);
        
       
        
        //计算转发微博正文所占的空间
//         CGRect rect = [self.weibo.retweeted_status.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.reWeiboBgImgFrame)-2*kSpace, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:15]} context:nil];
        
         CGFloat reHeight= [Label getTextHeight:15 width:(CGRectGetWidth(self.reWeiboBgImgFrame)-2*kSpace) text:self.weibo.retweeted_status.text];
        //转发微博背景的高度
        CGFloat bgHeight = reHeight + kSpace;
        //设置转发微博的正文frame
        
        self.reWeoboTextFrame = CGRectMake(CGRectGetMinX(self.reWeiboBgImgFrame)+kSpace, CGRectGetMinY(self.reWeiboBgImgFrame)+kSpace,CGRectGetWidth(self.reWeiboBgImgFrame)- 2*kSpace, reHeight);
        //转发微博图片的frame
//        if (self.weibo.retweeted_status.thumbnail_pic != nil) {
        
            
            //----------- 转发微博多图------------
            //转发微博多图frame，微博多图的frame 存在业务上互斥，微博多图与转发微博多图的frame计算只会执行一次（转发微博有图的时候微博就不会有图，微博有图的时候转发微博就不会有图）
            CGFloat retweetImgX = CGRectGetMinX(self.reWeoboTextFrame);
            CGFloat retweetImgY = CGRectGetMaxY(self.reWeoboTextFrame)+kSpace;
            CGFloat retweetImgSize = (CGRectGetWidth(self.reWeoboTextFrame) - kImageGap*2)/3;
            CGRect retweetImgFrame = CGRectZero;
            for (int i=0; i<_weibo.retweeted_status.pic_urls.count; i++) {
                row = i/3;
                column = i%3;
                retweetImgFrame = CGRectMake(retweetImgX+column*(retweetImgSize+kImageGap), retweetImgY+row*(retweetImgSize+kImageGap), retweetImgSize, retweetImgSize);
                [self.weiboImgFrameArr addObject:[NSValue valueWithCGRect:retweetImgFrame]];
            }
            NSInteger line = (_weibo.retweeted_status.pic_urls.count+2)/3;
            bgHeight += line*retweetImgSize + (MAX(0, line-1))*kImageGap + kSpace*(MAX(0, MIN(line, 1)));
            
            //-----------------------------------

            
//        }
        bgHeight += kSpace;
        //重新更新一下转发微博背景图片的frame
        
        self.reWeiboBgImgFrame = CGRectMake(CGRectGetMinX(self.weiboTextFrame), CGRectGetMaxY(self.weiboTextFrame)+kSpace, CGRectGetWidth(self.weiboTextFrame), bgHeight);
        
        //更新单元格的高度
        self.cellHeight += CGRectGetHeight(self.reWeiboBgImgFrame) + kSpace;
        
        
        
    }
    
    
    //加上剩余的frame
    for (NSInteger i =self.weiboImgFrameArr.count; i < 9; i++) {
        
        //添加剩余的frame值
        [self.weiboImgFrameArr addObject:[NSValue valueWithCGRect:CGRectZero]];
    }
    

  
    
    
    
}

@end
