//
//  DataService.h
//  weibo
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id result);
typedef void (^FailureBlock)(NSError *error);

@interface DataService : NSObject
//网络请求的方法
+ (void)requestWithUrl:(NSString *)url httpMethod:(NSString *)method params:(NSDictionary *)params fileData:(NSDictionary *)fileDic success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;


@end
