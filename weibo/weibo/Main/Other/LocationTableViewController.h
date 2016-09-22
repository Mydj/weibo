//
//  LocationTableViewController.h
//  weibo
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelecetedLocationBlock)(NSString *address);

@interface LocationTableViewController : UITableViewController
@property(nonatomic,copy)SelecetedLocationBlock locationBlock;

@end
