//
//  ThemeCell.h
//  weibo
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeLabel.h"

@interface ThemeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *themeImgView;
@property (weak, nonatomic) IBOutlet ThemeLabel *themeLabel;

@end
