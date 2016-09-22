//
//  PhotoCell.h
//  weibo
//
//  Created by liuwei on 15/11/24.
//  Copyright (c) 2015年 JayWon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "PhotoScrollView.h"

@interface PhotoCell : UICollectionViewCell

@property (nonatomic,strong)PhotoScrollView *photoView;

@property(nonatomic,strong)Photo *photo;
@end
