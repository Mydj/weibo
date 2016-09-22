//
// PhotoView.h
//
//  Created by liuwei on 15/9/15.
//  Copyright (c) 2015年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPhotoImageEdgeSize  40
#define kBackgroundColor [UIColor grayColor]

@interface UIView (viewController)
- (UIViewController *)viewController;
@end

@implementation UIView (viewController)

- (UIViewController *)viewController {
    
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil;
}
@end

@class PhotoBrowser, Photo, PhotoScrollView;

@protocol PhotoViewDelegate <NSObject>
@optional
- (void)photoViewWillZoomIn:(PhotoScrollView *)photoView;
- (void)photoViewDidZoomIn:(PhotoScrollView *)photoView;
- (void)photoViewWillZoomOut:(PhotoScrollView *)photoView;
- (void)photoViewDidZoomOut:(PhotoScrollView *)photoView;

@end

@interface PhotoScrollView : UIScrollView <UIScrollViewDelegate>
// 图片
@property (nonatomic, strong) Photo *photo;
// 代理
@property (nonatomic, weak) id<PhotoViewDelegate> photoViewDelegate;
@end