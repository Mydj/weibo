//
//  FacePannel.m
//  weibo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "FacePannel.h"
#import "FaceView.h"
#import "Common.h"

@implementation FacePannel
- (instancetype)initWithFrame:(CGRect)frame{
    

    if (self = [super initWithFrame:frame]) {
        
       

        [self _creatSubViews];
    }
    return self;
}
- (void)_creatSubViews{
    
    //1.表情视图
    _faceView = [[FaceView alloc]initWithFrame:CGRectZero];
    
  
    
    
    //2.滑动视图
    UIScrollView *s = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, _faceView.height)];
    s.pagingEnabled = YES;
    s.contentSize = CGSizeMake(4 *kScreenWidth, _faceView.height);
    //不让父视图切割子视图
    s.clipsToBounds = NO;
    [s addSubview:_faceView];
    [self addSubview:s];
    
    //3.分页视图
    UIPageControl *pageCtrl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, _faceView.bottom, kScreenWidth, 30)];
    //确定当前视图的宽和高度
    
    self.width = kScreenWidth;
    self.height = _faceView.height + pageCtrl.height;
    
    pageCtrl.backgroundColor = [UIColor redColor];
    
    pageCtrl.numberOfPages = 4;
    
    [self addSubview:pageCtrl];
    
    
}


@end
