//
//  WeiboCell.m
//  weibo
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "WeiboCell.h"
#import "WeiboModel.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"
#import "WeiboLayout.h"
#import "ThemeImageView.h"
#import "NSDate+TimeAgo.h"
#import "Label.h"
#import "PhotoBrowser.h"
#import "Photo.h"

@interface WeiboCell ()<LabelDelegate,PhotoBrowerDelegate>
//微博的图片(转发微博的图片)
@property(nonatomic,strong)UIImageView *weiboImgView;
//转发微博的背景图片
@property(nonatomic,strong)ThemeImageView *reWeiboBgImgView;
//转发微博的正文
@property(nonatomic,strong)Label *reWeiBotext;
//装多张图片的数组
@property(nonatomic,strong)NSMutableArray *weiboImgArr;


@end

@implementation WeiboCell


//多张图片

- (NSMutableArray *)weiboImgArr{
    
    if (_weiboImgArr == nil) {
        _weiboImgArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 9; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            //100
            
            //图片拉伸变形了
//            UIViewContentModeScaleToFill 拉伸填充(会变形)
            // UIViewContentModeScaleAspectFit 按比例缩放
            //UIViewContentModeScaleAspectFill 按原图显示
            // 会超出 imageView的范围
            
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            imageView.tag = i;
            //超出imageView的范围,切除
            imageView.clipsToBounds = YES;
            //给图片添加手势
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            
            
            
            [imageView addGestureRecognizer:tap];
            [self.contentView addSubview:imageView];
            [_weiboImgArr addObject:imageView];
        }
        
       
        
    }
    
    return _weiboImgArr;
    
}
//点击图片调用的方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
  //显示图片浏览器
    [PhotoBrowser showImageInView:self.window selectImageIndex:tap.view.tag delegate:self];
    
    
    
    
    
    
    
}
//转发微博的背景图片

- (ThemeImageView *)reWeiboBgImgView{
    
    if (_reWeiboBgImgView == nil) {
        _reWeiboBgImgView = [[ThemeImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_reWeiboBgImgView];
    }
    
    return _reWeiboBgImgView;
    
}
//转发微博的正文

- (UILabel *)reWeiBotext{
    
    if (_reWeiBotext == nil) {
        _reWeiBotext = [[Label alloc]initWithFrame:CGRectZero];
        _reWeiBotext.LabelDelegate = self;
        _reWeiBotext.font = [UIFont systemFontOfSize:15];
        _reWeiBotext.numberOfLines = 0;
        
        [self.contentView addSubview:_reWeiBotext];
    }
    return _reWeiBotext;
}

//微博正文
- (UILabel *)weiboText{
    
    
    
    if (_weiboText == nil) {
        _weiboText = [[Label alloc]initWithFrame:CGRectZero];
        _weiboText.font = [UIFont systemFontOfSize:16];
        _weiboText.LabelDelegate = self;
        _weiboText.numberOfLines = 0;
        [self.contentView addSubview:_weiboText];
    }
    return _weiboText;
}

//微博的图片
//- (UIImageView *)weiboImgView{
//    
//    if (_weiboImgView == nil) {
//        _weiboImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
//        [self.contentView addSubview:_weiboImgView];
//        
//    }
//    return _weiboImgView;
//}

- (void)awakeFromNib {
    
 //设置图片圆角属性
    self.userImgView.layer.cornerRadius = 5;
    self.userImgView.layer.borderColor = [UIColor grayColor].CGColor;
    self.userImgView.layer.borderWidth = .5;
    
    self.userImgView.layer.masksToBounds = YES;
    
}
- (void)setLayout:(WeiboLayout *)layout{
    
    
    _layout = layout;
    //昵称
    _nickName.text =_layout.weibo.user.name;
    
    //    //时间
//        _time.text = _layout.weibo.created_at;
    _time.text = [self parseWeiBoDate:_layout.weibo.created_at];
    
    //
    //    //来源//123>weibo<12312312
        _source.text = [self parseWeiBoSource:_layout.weibo.source];
    
    
    //头像
    //正则表达式
    [_userImgView sd_setImageWithURL:[NSURL URLWithString:_layout.weibo.user.profile_image_url]];
    //sadha 阿斯顿[兔子]
    self.weiboText.text = _layout.weibo.text;
    
    
    
    self.weiboText.frame = _layout.weiboTextFrame;
    
    //微博图片

    
    //显示的数据
    if (_layout.weibo.thumbnail_pic!=nil) {
//        [self.weiboImgView sd_setImageWithURL:[NSURL URLWithString:_layout.weibo.thumbnail_pic]];
        
        NSLog(@"%@",_layout.weibo.thumbnail_pic);
        
        [self showImgWithurls:_layout.weibo.pic_urls];
        
        
    }
 
    
    //转发微博属性的设置
    
    if (self.layout.weibo.retweeted_status!=nil) {
        //设置转发微博正文的数据
        
        self.reWeiBotext.text = _layout.weibo.retweeted_status.text;
        //转发微博的背景图片
        self.reWeiboBgImgView.leftCapWidth = 25;
        self.reWeiboBgImgView.rightCapWidth = 25;
        
        self.reWeiboBgImgView.imageName = @"timeline_rt_border_9";
        //转发微博的图片
     
           
            
            //显示转发微博图片
            //转发微博多图赋值，与微博多图赋值 存在业务上的互斥，两个showImgs调用只会执行一个（转发微博有图的时候微博就不会有图，微博有图的时候转发微博就不会有图）
//            [self showImgWithurls:_layout.weibo.retweeted_status.pic_urls];
        for (NSInteger i = 0; i < _layout.weibo.retweeted_status.pic_urls.count; i++) {
            
            UIImageView *imageView= [[self weiboImgArr] objectAtIndex:i];
        

            [imageView sd_setImageWithURL:_layout.weibo.retweeted_status.pic_urls[i][@"thumbnail_pic"]];
            
        }
        

        
        
        
    }
    
    //100 100(微博正文图片的frame和转发微博图片的frame)
//    self.weiboImgView.frame = _layout.weiboImgFrame;
    
    //转发微博相关的frame值
    self.reWeiboBgImgView.frame = _layout.reWeiboBgImgFrame;

    self.reWeiBotext.frame = _layout.reWeoboTextFrame;

    
    //多张图片布局
    
    for (NSInteger i = 0; i < 9; i++) {
         UIImageView *imageView= self.weiboImgArr[i];
        
        imageView.frame = [_layout.weiboImgFrameArr[i]CGRectValue];
       
    }

   
    
    
}

//显示多张图片的方法

- (void)showImgWithurls:(NSArray *)urls{
    
    for (NSInteger i = 0; i < urls.count; i++) {
        
        UIImageView *imageView= [self.weiboImgArr objectAtIndex:i];
        [imageView sd_setImageWithURL:urls[i][@"thumbnail_pic"]];
        
    }
    
    
    
    
    
}

//截取来源的方法

- (NSString *)parseWeiBoSource:(NSString *)scr{
    
    if (scr.length <= 0) {
        return nil;
    }
    
//    <a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
    
     NSInteger start= [scr rangeOfString:@">"].location;
    //默认从左往右,从右往左
    NSInteger end = [scr rangeOfString:@"<" options:NSBackwardsSearch].location;
    
     NSString *str = [scr substringWithRange:NSMakeRange(start + 1, end - start - 1)];
    

    
    return str;
}

//微博时间的转换
- (NSString *)parseWeiBoDate:(NSString *)dateStr{
    
    NSString *formater =@"E M d HH:mm:ss Z yyyy";
    
    NSDateFormatter *dateformater = [[NSDateFormatter alloc]init];
    //语言环境
    [dateformater setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    
    [dateformater setDateFormat:formater];
    //当前微博发送的时间
     NSDate *date = [dateformater dateFromString:dateStr];
    
    //现在的时间 - 当前微博发送的时间 (多少秒之前)
    
    
    
    
    
   
    
    return [date timeAgo];;;;;;;;;;;;;;;;;;;;
    
}
#pragma mark -----------LabelDelegate------

//检索文本的正则表达式的字符串
- (NSString *)contentsOfRegexStringWithLabel:(Label *)Label{
    
    
    return @"@[\\w_-]{2,30}|#[^#]+#|http(s)?://(([a-zA-Z0-9._-])+(/)?)*";
}

//设置当前链接文本的颜色
- (UIColor *)linkColorWithLabel:(Label *)Label{
    
    return [UIColor blueColor];
    
}

#pragma mark  PhotoDelegate----------

//需要显示的图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(PhotoBrowser *)photoBrowser{
    
    if (_layout.weibo.pic_urls.count > 0) {
        return _layout.weibo.pic_urls.count;
    }
    else{
    
        return  _layout.weibo.retweeted_status.pic_urls.count;
    }
    
   
}

//返回需要显示的图片对应的Photo实例,通过Photo类指定大图的URL,以及原始的图片视图
- (Photo *)photoBrowser:(PhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    
    Photo *photo = [[Photo alloc]init];
    
    NSArray *urls = nil;
    //原图(图片)
    photo.srcImageView = self.weiboImgArr[index];
    
    if (_layout.weibo.pic_urls.count > 0) {
        
         urls = _layout.weibo.pic_urls;
        
    }
    if (_layout.weibo.retweeted_status.pic_urls.count > 0) {
        
        urls = _layout.weibo.retweeted_status.pic_urls;
        
    }
    //缩略图的图片
     NSString *imgUrl= urls[index][@"thumbnail_pic"];
    //替换为大图的url
    imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
    //设置大图
    photo.url = [NSURL URLWithString:imgUrl];
    
    
    
    

    
    return photo;
}








@end
