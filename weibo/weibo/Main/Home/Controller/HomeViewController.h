//
//  HomeViewController.h
//  weibo
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiBoTableView;
@class MBProgressHUD;

@interface HomeViewController : UIViewController
{
    MBProgressHUD *_hud;
}
@property (weak, nonatomic) IBOutlet WeiBoTableView *weiboTabelView;

@end
