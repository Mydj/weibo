//
//  HomeViewController.m
//  weibo
//
//  Created by apple on 16/7/3.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "HomeViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "UserModel.h"
#import "WeiboModel.h"
#import "YYModel.h"
#import "WeiBoTableView.h"
#import "WeiboLayout.h"
#import "Refresh.h"
#import "ThemeImageView.h"
#import "Common.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "HomeViewController.h"
#import "SinaWeibo.h"
#import "AppDelegate.h"
#import "ThemeManager.h"
#import "ThemeLabel.h"
#import "UserModel.h"
#import "WeiboModel.h"
#import "YYModel.h"
#import "WeiBoTableView.h"
#import "WeiboLayout.h"
#import "Refresh.h"
#import "ThemeImageView.h"
#import "Common.h"
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"

@interface HomeViewController ()<SinaWeiboDelegate,SinaWeiboRequestDelegate>
@property(nonatomic,strong)NSMutableArray *weiboList;

@property (nonatomic,strong)ThemeImageView *notfiyImgView;
@end

@implementation HomeViewController

- (ThemeImageView *)notfiyImgView{
    if ( _notfiyImgView == nil) {
        _notfiyImgView = [[ThemeImageView alloc]initWithFrame:CGRectMake(20, -40, kScreenWidth - 40, 40)];
        
        _notfiyImgView.imageName = @"timeline_notify.png";
        [self.view addSubview: _notfiyImgView];
        ThemeLabel *label = [[ThemeLabel alloc]initWithFrame:_notfiyImgView.bounds];
        
        label.colorName = @"Mask_Notice_color";
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.tag = 2016;
        
        [_notfiyImgView addSubview:label];
        
    }
    return _notfiyImgView;
    
}


//获取新浪微博对象
- (SinaWeibo *)sinaweibo
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.sinaweibo;
}

//懒加载创建数组
- (NSMutableArray *)weiboList{
    
    
    if (_weiboList == nil) {
        _weiboList = [NSMutableArray array];
    }
    
    return _weiboList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置代理,用来监听登陆成功的事件
    
     SinaWeibo *sinaWeibo= [self sinaweibo];
   
    [sinaWeibo setDelegate:self];
    
    //将导航栏的透明度改为 NO,防止表视图往下偏移
//    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.translucent = NO;
    [sinaWeibo logIn];
    //下拉刷新
    [_weiboTabelView addPullDownRefreshBlock:^{
        
        NSLog(@"下拉刷新");
        
        [self _loadMoreWeiBoData];
        
        //请求网络数据
    }];
    
    //添加上拉加载
    
    [_weiboTabelView addInfiniteScrollingWithActionHandler:^{
        
        //发送网路请求
        [self _loadMoreNextPageWeiBoData];
        
    }];
    
    

    
    
}



//下拉刷新的网络请求
- (void)_loadMoreWeiBoData{
    
    //获取当前最新微博的id
    WeiboLayout *layout  = [self.weiboList firstObject];
    
     NSString *weiboID= layout.weibo.idstr;
    
     SinaWeiboRequest *request = [[self sinaweibo] requestWithURL:@"statuses/home_timeline.json" params:[@{@"since_id" : weiboID}mutableCopy] httpMethod:@"GET" delegate:self];
    //上拉加载发送的网络请求(1)
    request.tag = 1;
    
    
}
//上拉加载

- (void)_loadMoreNextPageWeiBoData{
    
    //取得当前显示的最后一条微博的数据
     WeiboLayout *layout = [self.weiboList lastObject];
    
     NSString *weiboID= layout.weibo.idstr;
    
     SinaWeiboRequest *request = [[self sinaweibo]requestWithURL:@"statuses/home_timeline.json" params:[@{@"max_id" : weiboID}mutableCopy] httpMethod:@"GET" delegate:self];
    
    request.tag = 2;
    
    
    
}







//存储登陆信息
- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}



//登陆成功调用的代理方法
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    
    
    
    //存储token
    [self storeAuthData];
    
    //请求网络数据(url 请求参数 请求方式 request resume)
    
    //新浪SDK提供的网络请求
    

    //提供的网络请求,内部帮助我们拼接了token
    
    //拼接主接口()
     SinaWeiboRequest *request = [[self sinaweibo]requestWithURL:@"statuses/home_timeline.json" params:nil httpMethod:@"GET" delegate:self];
    
    //显示加载提示
    
//  _hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    _hud.dimBackground = YES;
//    
    //第一次发送网络请求(0)
    request.tag = 0;
    
    
    
    
    
    
    
    
}
//请求数据成功调用的代理方法
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    //第一次(1)
    //下拉刷新(5)
    
    NSLog(@"%@",result);
    //给model赋值
    //(1)获取微博列表的数据
      NSArray * statues= result[@"statuses"];
    //20
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSDictionary *status in statues) {
        
                //使用YYModel给model赋值
        
        WeiboModel *weiModel = [WeiboModel yy_modelWithDictionary:status];
        
        //给布局类(layout weibo属性赋值)
        WeiboLayout *layout = [[WeiboLayout alloc]init];
        //将微博model 交给布局类使用
        layout.weibo = weiModel;
        
        
        //1
        [tempArr addObject:layout];
    
        
    }
    
    
    //第一次加载
    if (request.tag == 0) {
        
        
        self.weiboList = tempArr;
        //隐藏加载提示
        
//        [_hud hide:YES];
        
        
        
    }//下拉刷新
    else if (request.tag == 1){
        //显示下拉刷新的数据
        [self showNotfyView:tempArr.count];
        //往数组的顶部追加最新的元素
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tempArr.count)];
        
        [self.weiboList insertObjects:tempArr atIndexes:set];
        
        //结束下拉刷新
        
        [self.weiboTabelView.pullToRefreshView stopAnimating];
        
        
        
        
    }else if(request.tag == 2){
        
        
        //去掉重复的微博
         WeiboLayout *lastLayout= [self.weiboList lastObject];
         WeiboLayout *firstLayout = [tempArr firstObject];
        if ([firstLayout.weibo.idstr isEqualToString:lastLayout.weibo.idstr]) {
            
            [tempArr removeObjectAtIndex:0];
        }
        
        
        
        //上拉加载
        //将数据直接添加到数组末尾
        
        
        //
        [self.weiboList addObjectsFromArray:tempArr];
        
        //结束上拉加载
        [self.weiboTabelView.infiniteScrollingView stopAnimating];
        
        
    }
    
    
    self.weiboTabelView.weiboLayout = _weiboList;
    //重点,数据来了重新刷新单元格
    [self.weiboTabelView reloadData];
    
    
    
    
    
    
}
#pragma  mark ------显示未读微博
- (void)showNotfyView:(NSInteger)count{
    
    if (count <=0) {
        return;
    }
    
    
     UILabel *label = (UILabel *)[self.notfiyImgView viewWithTag:2016];
    label.text = [NSString stringWithFormat:@"%ld 条微博",count];
    
    [UIView animateWithDuration:2 animations:^{
        
        
        self.notfiyImgView.transform = CGAffineTransformMakeTranslation(0,50);
    } completion:^(BOOL finished) {
        
        
        [UIView animateWithDuration:.3 animations:^{
            //动画执行结束调用的block
            self.notfiyImgView.transform = CGAffineTransformIdentity;
        }];
        
       
        
    }];
    
    
    //播放声音
    //对象就是封装C语言的结构体(强制封装)(多重继承) - NSObject
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"msgcome.wav" ofType:nil];
    
    //将字符串转换成url
     NSURL *url = [NSURL fileURLWithPath:filePath];
    

    //COREFoundatation 是Foundatation 的底层
    UInt32 soundID = 0;
    
    //注册为系统声音
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
    
    //播放
    AudioServicesPlaySystemSound(soundID);
    
    
    
    
}


@end
