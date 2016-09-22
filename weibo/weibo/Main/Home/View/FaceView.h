//
//  FaceView.h
//  weibo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FaceViewDelegate <NSObject>

- (void)faceViewDidSelectedFace:(NSString *)faceName;

@end

@interface FaceView : UIView
@property(nonatomic,strong)UIImageView *selectImgView;
@property(nonatomic,assign)id<FaceViewDelegate>delegate;
@property(nonatomic,copy)NSString *faceName;
@end
