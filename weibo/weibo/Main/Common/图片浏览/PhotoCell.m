//
//  PhotoCell.m
//  weibo
//
//  Created by liuwei on 15/11/24.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _photoView = [[PhotoScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - kPhotoImageEdgeSize, CGRectGetHeight(self.frame))];
        [self.contentView addSubview:_photoView];
    }
    return self;
}

- (void)setPhoto:(Photo *)photo{
    _photo = photo;
    _photoView.photo = _photo;
}
@end
