//
//  WeiBoTableView.h
//  weibo
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiBoTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *weiboLayout;
@end
