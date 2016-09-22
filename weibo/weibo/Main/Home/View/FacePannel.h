//
//  FacePannel.h
//  weibo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceView;
@interface FacePannel : UIView<UIScrollViewDelegate>
@property(nonatomic,strong)FaceView *faceView;
@end
