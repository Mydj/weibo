//
//  WeiboModel.m
//  weibo
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "WeiboModel.h"
#import "YYModel.h"
#import "RegexKitLite.h"


@implementation WeiboModel
//自定义属性转调用的方法
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    
    //self.text - [兔子] - plist字典 - 1.png
    
    //设置找到表情的正则表达式
    
    
    NSString *regex = @"\\[\\w+\\]";
    //[兔子][猫]
    NSArray *faceArr= [self.text componentsMatchedByRegex:regex];
    //读取plist文件
     NSString *path= [[NSBundle mainBundle]pathForResource:@"emoticons.plist" ofType:nil];
    
    NSArray *facePlistArr= [NSArray arrayWithContentsOfFile:path];
    
    for (NSString *faceStr in faceArr) {
        //[兔子]
        
        NSString *s = [NSString stringWithFormat:@"chs = '%@'",faceStr];
        
        //通过[兔子] 找出对应的表情字典(使用谓词)
        
        
         NSArray *result = [facePlistArr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:s]];
        
         NSDictionary *faceDic = [result lastObject];
        
        //取出对应的图片[兔子]---->[001.png]
         NSString *imageName= faceDic[@"png"];
        //<image url = 001.png>
        NSString *imgUrl = [NSString stringWithFormat:@"<image url = '%@'>",imageName];
        //哈哈哈[兔子]呵呵呵
        
         self.text = [self.text stringByReplacingOccurrencesOfString:faceStr withString:imgUrl];
        
        
    }
    
    
    return YES;
    
}




@end
