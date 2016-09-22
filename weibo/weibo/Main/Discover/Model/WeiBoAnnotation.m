//
//  WeiBoAnnotation.m
//  weibo
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "WeiBoAnnotation.h"

@implementation WeiBoAnnotation
- (void)setModel:(WeiboModel *)model{
    
    _model = model;
    
    //获取到当前用户的经纬度
     NSDictionary *geo = _model.geo;
    
     NSArray *geoArr= geo[@"coordinates"];
    if (geoArr.count == 2) {
        
         NSString *lat= [geoArr firstObject];
        NSString *lon = [geoArr lastObject];
        //设置大头针显示的区域
        self.coordinate = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
    }
    
    
    
}
@end
