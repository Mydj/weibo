//
//  FaceView.m
//  weibo
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 nihao. All rights reserved.
//

#import "FaceView.h"
#define itemSize 45
#define faceSize 30
#import "Common.h"
@implementation FaceView
{
    NSMutableArray *_faceArr;
}

- (UIImageView *)selectImgView{
    
    
    if (_selectImgView == nil) {
        _selectImgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _selectImgView.image = [UIImage imageNamed:@"emoticon_keyboard_magnifier.png"];
        //自适应(确定视图的宽和高)
        [_selectImgView sizeToFit];
        [self addSubview:_selectImgView];
        UIImageView *faceImg = [[UIImageView alloc]initWithFrame:CGRectMake((_selectImgView.width - faceSize)/2, 15, faceSize, faceSize)];
        faceImg.tag = 100;
        [_selectImgView addSubview:faceImg];

    }
    
    return _selectImgView;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        //1.加载表情文件
        [self _loadFaceFile];
        
    }
    return self;
}
- (void)_loadFaceFile{
   
    //切割数组[dic,dic]
//    [[表情,表情][表情,表情][表情,表情][表情,表情]]
    NSArray *faceFileArr = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle]pathForResource:@"emoticons.plist" ofType:nil]];
    /*
    [faceFileArr subarrayWithRange:NSMakeRange(28* 0, 28)];
    [faceFileArr subarrayWithRange:NSMakeRange(28 *1, 28)];
    [faceFileArr subarrayWithRange:NSMakeRange(28 *2, 28)];
    */
    //装分割完毕数组的大数组
    _faceArr = [NSMutableArray arrayWithCapacity:4];
    
    NSMutableArray *face2d = nil;
    
    for (NSInteger i = 0; i<faceFileArr.count;i++ ) {
        //104 字典
        if (face2d == nil || face2d.count == 28) {
            face2d  = [NSMutableArray arrayWithCapacity:28];
            
            [_faceArr addObject:face2d];
        }
        //分割了4个数组
        [face2d addObject:[faceFileArr objectAtIndex:i]];
        
        
    }
    
    //限制当前视图的宽和高
    
    self.width = 4 *kScreenWidth;
    self.height = 4 *itemSize;
    
    
    
}








//绘制
- (void)drawRect:(CGRect)rect {
    //只有在此方法里面才可以获取上下文
    
    //定义行 和列
    NSInteger row = 0;//行
    NSInteger clomn = 0;
    
    for (NSInteger i = 0; i <_faceArr.count; i ++) {
        //[表情,表情][表情,表情][表情,表情][表情,表情]
       //取出小数组,(每个小数组里面有28个元素)
        NSArray *face2D = _faceArr[i];
        
        for (NSInteger j = 0; j <face2D.count; j++) {
            
             NSDictionary *facedic = face2D[j];
            //取出表情字典中的图片名字
             NSString *imgName= facedic[@"png"];
            
            
            
            
             UIImage *image = [UIImage imageNamed:imgName];
            

            //绘制图片
            [image drawInRect:CGRectMake(clomn * itemSize +(itemSize - faceSize)/2 + kScreenWidth *i, row *itemSize + (itemSize - faceSize) / 2, faceSize, faceSize)];
            
            //更新行和列
            clomn ++;
            if (clomn  == 7) {
                //列数到达 7 的时候归0
                clomn = 0;
                //列数达到7的时候换行
                row ++;
            }
            
            if (row == 4) {
                row = 0;
            }
        }
        
        
    }
    
  
    


}
//手指开始触摸调用的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //禁止滑动视图的滑动
     UIScrollView *scrollView= (UIScrollView *)self.superview;
    scrollView.scrollEnabled = NO;
    
    self.selectImgView.hidden = NO;
    

    
    //点击的位置
    UITouch *touch = [touches anyObject];
    
     CGPoint point = [touch locationInView:self];
    [self touchFace:point];
    
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    [self touchFace:point];
    

   
}
//手指离开的时候调用
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //开启滑动视图的滑动
    UIScrollView *scrollView= (UIScrollView *)self.superview;
    scrollView.scrollEnabled = YES;
    
    self.selectImgView.hidden = YES;
    
    
    //将选中的表情传递出去
    [self.delegate faceViewDidSelectedFace:_faceName];
    
}

- (void)touchFace:(CGPoint)point{
    
    //判断当前页数
    NSInteger page = point.x / kScreenWidth;
    if (page < 0) return;
    if (page > 3) return;
    
    //2.通过当前页数,取得小数组
    NSArray *face2D= _faceArr[page];
    
    //小数组的下标
    //计算点击位置的行数与列数
    // x , y
    //  x =clomn * itemSize +(itemSize - faceSize)/2 + kScreenWidth *i;
    // y = row *itemSize + (itemSize - faceSize) / 2
    NSInteger row = (point.y - (itemSize - faceSize)/2)/ itemSize;
    
    NSInteger clomn =  (point.x - ((itemSize - faceSize) / 2 + kScreenWidth * page)) / itemSize;;
    
    //    row 0 - 3
    
    //colmn 0 - 6
    if (row > 3) row = 3;
    if (row < 0 ) row = 0;
    if (clomn > 6)clomn = 6;
    if (clomn < 0) clomn = 0;
    //计算数组的下标
    NSInteger index= row * 7 + clomn;
    
    if (index >=face2D.count) {
        
        _faceName =nil;
        
        return;
    }
    
    //t通过计算出的下标取出表情字典
    NSDictionary *faceDic= face2D[index];
    //取出图片的名字
    NSString *imageName = faceDic[@"png"];
    
    //获取兔子
    _faceName = faceDic[@"chs"];
    //显示放大镜
    
    UIImageView *faceImgView= [self.selectImgView viewWithTag:100];
    faceImgView.image = [UIImage imageNamed:imageName];
    
    CGFloat x = itemSize/ 2 + clomn *itemSize +page *kScreenWidth;
    
    self.selectImgView.center = CGPointMake(x, 0);
    
    self.selectImgView.bottom = itemSize / 2 + row *itemSize;
    
    //传递值
    
}






@end
