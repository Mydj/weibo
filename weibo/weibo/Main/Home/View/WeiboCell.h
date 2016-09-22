//
//  WeiboCell.h
//  weibo
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboModel;
@class WeiboLayout;
@class Label;
//Texk Kit  //CoreText

@interface WeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *source;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

@property(nonatomic,strong)WeiboLayout *layout;
//微博正文
@property(nonatomic,strong)Label *weiboText;
@end
