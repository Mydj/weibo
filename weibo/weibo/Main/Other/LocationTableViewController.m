//
//  LocationTableViewController.m
//  weibo
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "LocationTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Common.h"
#import "AppDelegate.h"


@interface LocationTableViewController ()<CLLocationManagerDelegate,SinaWeiboRequestDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@property(nonatomic,strong)NSArray *locationArr;

@end

@implementation LocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
            NSLog(@"定位");
    
    
    
    
            _locationManager = [[CLLocationManager alloc]init];
            //iOS7
    
    
    
            if (kiOS8Later >= 8.0) {
                
                
                //请求用户授予定位的权限
                [_locationManager requestWhenInUseAuthorization];
    
            }
    
    //1.设置定位的精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    //设置代理
    _locationManager.delegate = self;
    
    //3.开始定位
    [_locationManager startUpdatingLocation];
   
}

#pragma mark------LocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    
    NSLog(@"定位成功");
    
    //停止定位
    [_locationManager stopUpdatingLocation];
    
    //获取当前的经纬度
    CLLocation *location  = [locations lastObject];
    //纬度
    double lat = location.coordinate.latitude;
    //经度
    double lon = location.coordinate.longitude;
    
    NSString *latStr = [NSString stringWithFormat:@"%lf",lat];
    NSString *lonStr = [NSString stringWithFormat:@"%lf",lon];
    
    //位置反编码(新浪)(发送网络请求.将经纬度传递给新浪服务器)
    //新浪会返回给你位置信息
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.sinaweibo requestWithURL:@"place/nearby/pois.json" params:[@{@"lat" :latStr,@"long" : lonStr}mutableCopy] httpMethod:@"GET" delegate:self];
   
    //百度  苹果的 谷歌的
    //iOS内置的反编码
//     CLGeocoder *coder= [[CLGeocoder alloc]init];
//    
//    //234234.234234 23423423.234234
//    [coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//         CLPlacemark *mark= [placemarks lastObject];
//        
//        NSLog(@"%@",mark.addressDictionary);
//        
//    }];
//    
    
    
    
}


#pragma mark -------sinaDelegate
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    NSLog(@"%@",result);
    
     NSArray *posArr= result[@"pois"];
     _locationArr= posArr;
    
    [self.tableView reloadData];
    
  
    
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _locationArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loacationCell" forIndexPath:indexPath];
    
    
    
    NSDictionary *locationDic = [_locationArr objectAtIndex:indexPath.row];
     NSString *text = locationDic[@"address"];
    
    if ([text isKindOfClass:[NSString class]]) {
         cell.textLabel.text =text;
    }
    
   
    
    return cell;
}

//选中单元格,传递值

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     NSDictionary * locationDic = _locationArr[indexPath.row];
     NSString *address = locationDic[@"address"];
    
    //回调block
    _locationBlock(address);
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}














@end
