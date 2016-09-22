//
//  WeiBoAnnotation.h
//  weibo
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"
@interface WeiBoAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,  copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;
@property(nonatomic,strong)WeiboModel *model;
@end
