//
//  DataService.m
//  weibo
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "DataService.h"
#import "AppDelegate.h"
#import "AFNetworking.h"

#define BaseUrl @"https://api.weibo.com/2/"
@implementation DataService

+ (void)requestWithUrl:(NSString *)url httpMethod:(NSString *)method params:(NSDictionary *)params fileData:(NSDictionary *)fileDic success:(SuccessBlock)sBlock failure:(FailureBlock)fBlock;{
    
    //1.拼接完整的接口
    
    url = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    
    //2.设置参数
     NSMutableDictionary *mDic= [NSMutableDictionary dictionaryWithDictionary:params];
    
     AppDelegate *appDelegate= [UIApplication sharedApplication].delegate;
    
    [mDic setObject:appDelegate.sinaweibo.accessToken forKey:@"access_token"];
    
    
    //发送网络请求
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //判断请求方式
    if ([method caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        
        [manager GET:url parameters:mDic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            sBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            
            fBlock(error);
        }];
        
        
        
    }else if ([method caseInsensitiveCompare:@"POST"]==NSOrderedSame){
        
        
        //如果发送带图片的微博
        if (fileDic) {
            
            
            [manager POST:url parameters:mDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                //拼接上传到服务器的数据(图片数据)
                
                for (NSString *key in fileDic) {
                    
                    [formData appendPartWithFileData:fileDic[key] name:key fileName:key mimeType:@"image/jpeg"];
                    
                }
                
                
                
                
            } success:^(NSURLSessionDataTask *task, id responseObject) {
                sBlock(responseObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                fBlock(error);
            }];
        }
        
        
        
        
        //发送文字的微博
        [manager POST:url parameters:mDic success:^(NSURLSessionDataTask *task, id responseObject) {
            sBlock(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            fBlock(error);
        }];
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}
@end
