//
//  SendViewController.m
//  weibo
//
//  Created by liuwei on 16/1/26.
//  Copyright (c) 2016年 baidu. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeButton.h"
#import "Common.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationTableViewController.h"
#import "BaseNavController.h"
#import "MMDrawerController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "DataService.h"
#import "MBProgressHUD.h"
#import "FacePannel.h"



@interface SendViewController ()<SinaWeiboRequestDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)FacePannel *facePannel;
@property(nonatomic,strong)UIImageView *selectImageView;
@end

@implementation SendViewController{

    //1.编辑输入框
    UITextView *_textView;
    //2.工具栏
    UIView *_editorBar;
}
//表情面板

-(FacePannel *)facePannel{
    
    if (_facePannel == nil) {
        _facePannel =[[FacePannel alloc]initWithFrame:CGRectMake(0, kScreenHeight, 0, 0)];
        _facePannel.faceView.delegate = self;
        [self.view addSubview:_facePannel];
    }
    
    return _facePannel;
    
}

- (UIImageView *)selectImageView{
    
    if (_selectImageView == nil) {
        _selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 100, 100)];
        
        _selectImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _selectImageView.clipsToBounds = YES;
        _selectImageView.bottom = _editorBar.top;
        
        [self.view addSubview:_selectImageView];
    }
    return _selectImageView;
    
    
}
- (UILabel *)addressLabel{
    
    if (_addressLabel == nil) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, (kScreenWidth - 20), 30)];
        
        _addressLabel.font = [UIFont systemFontOfSize:12];
        [_editorBar addSubview:_addressLabel];
    }
    
    return _addressLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createNavigationViews];
    [self _loadEditorViews];
    
    //1.监听键盘的弹出
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //弹出键盘
    [_textView becomeFirstResponder];
}
// 代理 通知 KVO  block
- (void)keyBoardShow:(NSNotification *)notification{
    
    //获取键盘的高度
    
    NSLog(@"%@",notification.userInfo);
    
     CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    CGFloat height = rect.size.height;
    
    //设置输入框的高度
    _textView.height = kScreenHeight - height - _editorBar.height;
    
    
    //设置工具栏的y
    _editorBar.top = _textView.bottom;
    

    
    
    
    
}

#pragma mark - create UI  创建子视图
//1.创建导航栏上的视图
- (void)_createNavigationViews {
    
    //1.关闭按钮
    ThemeButton *closeButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeButton.imageName = @"button_icon_close.png";
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    
    //2.发送按钮
    ThemeButton *sendButton = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.imageName = @"button_icon_ok.png";
    [sendButton addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:sendItem];
    
}
//2.创建编辑工具栏的视图
- (void)_loadEditorViews {
    
    //1.创建输入框视图
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = YES;
    [self.view addSubview:_textView];
    
    //2.创建编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 55)];
    
    _editorBar.backgroundColor = [UIColor redColor
                                  ];
    [self.view addSubview:_editorBar];
    
    //3.创建多个编辑按钮
    NSArray *imgs = @[
                      @"compose_toolbar_1.png",
                      @"compose_toolbar_4.png",
                      @"compose_toolbar_3.png",
                      @"compose_toolbar_5.png",
                      @"compose_toolbar_6.png"
                      ];
    for (int i=0; i<imgs.count; i++) {
        NSString *imgName = imgs[i];
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(15+(kScreenWidth/5)*i, 20, 40, 33)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10+i;
        button.imageName = imgName;
        [_editorBar addSubview:button];
    }
}
#pragma mark - 按钮事件
- (void)closeAction {
 
    
    //关闭侧滑
    //1.获取根视图控制器(MMDrawController)
    
//
    
//    [self dismissViewControllerAnimated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:^{
//        
//        MMDrawerController *drawController = (MMDrawerController *)self.view.window.rootViewController;
        
         MMDrawerController *drawController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
       [drawController closeDrawerAnimated:YES completion:nil];
        
    }];
    
}
- (void)clickAction:(UIButton *)btn{
    
    
    //定位
    
    // 调用手机的定位功能获取到当前的经纬度
    //位置反编码(通过经纬度转换到实际位置)
    //百度 谷歌 苹果自带   新浪
    
    //iOS8之后想要使用定位服务 plist
    
    if (btn.tag == 10) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
        
        [sheet showInView:self.view];
        
    }

    
    if (btn.tag == 13) {

        
        LocationTableViewController *locationVC = [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"locationCtrl"];
        //显示地理信息
        locationVC.locationBlock = ^(NSString *address){
            
            
            [self addressLabel].text = address;
        };
        
        
        
        
        BaseNavController *baseVC = [[BaseNavController alloc]initWithRootViewController:locationVC];
        
        
    
        
        [self presentViewController:baseVC animated:YES completion:nil];
        
        
        
    }
    
    if (btn.tag == 14) {
        
        
        if ([_textView isFirstResponder]) {
            //显示面板
            [self showFace];
        }else{
            //显示键盘
            [self hideFacePannel];
        }
      
      
        
    }

    
    
    
}
- (void)hideFacePannel{
    
    
    //1.显示键盘
    [_textView becomeFirstResponder];
    //隐藏表情
    [UIView animateWithDuration:.3 animations:^{
        
        self.facePannel.transform = CGAffineTransformIdentity;
    }];
}

//显示表情

- (void)showFace{
    
    //1.隐藏键盘
    [_textView resignFirstResponder];
    
    //2.显示表情
    [UIView animateWithDuration:.3 animations:^{
        
        //平移表情面板
        self.facePannel.transform = CGAffineTransformMakeTranslation(0, -self.facePannel.height);
        _editorBar.bottom = self.facePannel.top;
        _textView.height = kScreenHeight - _editorBar.height - self.facePannel.height;
        
        
        
    }];
}



#pragma mark ---------UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    //弹出系统的相册
    UIImagePickerController *imagePickCtrl = [[UIImagePickerController alloc]init];
    imagePickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePickCtrl.delegate = self;
    
    [self presentViewController:imagePickCtrl animated:YES completion:nil];
    
    
    
    
}
#pragma mark ------imagePickCtrlDelagate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //取得用户选择的照片
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    [_textView resignFirstResponder];
    
     UIImage *image= info[UIImagePickerControllerOriginalImage];
    
    
    self.selectImageView.image = image;
    
    
}

//发送微博调用的方法
- (void)sendAction{
    
    
    NSString *error = nil;
    if (_textView.text.length <= 0) {
        error = @"微博内容不能为空";
    }
    else if (_textView.text.length > 140){
        
        error = @"微博内容不能超过140字";
    }
    
    if (error) {
        UIAlertView  *aleartView = [[UIAlertView alloc]initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        
        [aleartView show];
        
        return;
        
    }
    
    //发送微博的代码
    [self sendStatus];
    
    
}

//发送微博
- (void)sendStatus{
    
   
    
    NSString *url = nil;
    NSDictionary *params = @{@"status" : _textView.text};
    NSDictionary *fileDic = nil;
    
    //发送带图片的微博
    if (self.selectImageView.image !=nil) {
        
        url = @"statuses/upload.json";
        fileDic = @{@"pic": UIImageJPEGRepresentation(self.selectImageView.image, 1)};
        
    }else{
        
        url = @"statuses/update.json";
    }
    
    //.使用自己封装的网络请求
    
    [DataService requestWithUrl:url httpMethod:@"POST" params:params fileData:fileDic success:^(id result) {
        
        NSLog(@"发送成功");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"发送成功";
        [hud hide:YES afterDelay:2];
        
        
        [self closeAction];
        
    } failure:^(NSError *error) {

    }];
   
    
    
    
    
}
- (void)faceViewDidSelectedFace:(NSString *)faceName{
    
    if (faceName.length >0) {
        
        _textView.text = [_textView.text stringByAppendingString:faceName];

    }
    
    
}





@end
