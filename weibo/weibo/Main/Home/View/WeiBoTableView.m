//
//  WeiBoTableView.m
//  weibo
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "WeiBoTableView.h"
#import "WeiboCell.h"
#import "WeiboModel.h"
#import "Common.h"
#import "WeiboLayout.h"

@implementation WeiBoTableView

- (void)awakeFromNib{
    
    
    self.dataSource = self;
    self.delegate = self;
    
}
#pragma makr---------TableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     WeiboLayout * layout = self.weiboLayout[indexPath.row];
    
//    //60 + 微博正文的高度 + 20空隙
//    CGRect textrect = [weibo.text boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:16]} context:NULL];
    
    
    return layout.cellHeight;
}
#pragma mark   ----- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.weiboLayout.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weibocell" forIndexPath:indexPath];
    
    cell.layout = self.weiboLayout[indexPath.row];
    
    
    
    
        return cell;
    
}





@end
