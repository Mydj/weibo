//
//  NearWeiBoViewController.m
//  weibo
//
//  Created by apple on 16/7/15.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "NearWeiBoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Common.h"
#import "WeiBoAnnotation.h"
#import "DataService.h"
#import "YYModel.h"
#import "WeiboModel.h"
@interface NearWeiBoViewController ()
{
    CLLocationManager *_location;
}

@end

@implementation NearWeiBoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 百度地图 SDK
        //定位一下
    
    if (kiOS8Later > 8.0) {
        _location = [[CLLocationManager alloc]init];
        
        //请求用户授权
        [_location requestWhenInUseAuthorization];
    }
    
    
    
   

    
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    
     //设置代理,监听定位成功
    mapView.delegate = self;
    
    //显示当前用户位置
    mapView.showsUserLocation = YES;
    
    
    [self.view addSubview:mapView];
}
//用户的位置已经更新(定位成功)
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //俯冲(显示当前用户的位置)
    // 设置显示的区域(精度,跨度)
    
    CLLocationCoordinate2D coordinate = userLocation.coordinate;
    
    //跨度,传入的参数越小,越精确
    MKCoordinateSpan span = MKCoordinateSpanMake(.05, .05);
    
    [mapView setRegion:MKCoordinateRegionMake(coordinate, span)];
    /*
    WeiBoAnnotation *a = [[WeiBoAnnotation alloc]init];
    //红色标注视图显示的位置
    a.coordinate = CLLocationCoordinate2DMake(39.924115, 116.186059);
    a.title = @"haha";
    //标注视图(model)
    [mapView addAnnotation:a];
 */
    //请求新浪服务器,获取附近的微博
    
    NSString *lat =[NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *lon =[NSString stringWithFormat:@"%f",coordinate.longitude];
    
    
    [DataService requestWithUrl:@"place/nearby_timeline.json" httpMethod:@"GET" params:@{@"lat" : lat,@"long" : lon} fileData:nil success:^(id result) {
        
        NSArray *status = result[@"statuses"];
        for (NSDictionary *dic in status) {
            //100
              WeiboModel *model = [WeiboModel yy_modelWithDictionary:dic];
            //创建标注视图
            WeiBoAnnotation *annotaion = [[WeiBoAnnotation alloc]init];
            annotaion.model = model;
            //将标注视图添加到地图上
            [mapView addAnnotation:annotaion];

            
        }
        
      
      
        
        
        //解析数据model

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
}



@end
