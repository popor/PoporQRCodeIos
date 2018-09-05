//
//  PoporQRCodeIosViewController.m
//  PoporQRCodeIos
//
//  Created by popor on 09/05/2018.
//  Copyright (c) 2018 popor. All rights reserved.
//

#import "PoporQRCodeIosViewController.h"

#import <Masonry/Masonry.h>
#import <PoporFoundation/ScreenCommonSize.h>
#import <PoporFoundation/PrefixColor.h>
#import <PoporUI/UIImage+Tool.h>
#import <PoporUI/UIDevice+SaveImage.h>

#import "JPQRCodeTool.h"


#define ColorCyan1 RGB16(0X29CCB6)// 青色: 用于强调突出的按钮
#define ColorCyan2 RGB16(0X15bca5)// 青色按钮按下后状态的颜色

#define ColorBlue1 RGB16(0X4585F5)// 蓝色: 用于顶部bar底色，底部ab选中状态,用于按钮，突出、选中的文字
#define ColorBlue2 RGB16(0X266ff0)// 蓝色按钮点击按下状态 的颜色
#define ColorBlue3 RGB16(0X74a6fb)// 蓝色按钮禁用状态的颜色

@interface PoporQRCodeIosViewController ()

// self   : 自己的
@property (nonatomic, strong) UILabel * introL;
@property (nonatomic, strong) UIImageView * qrCodeIV;
@property (nonatomic, strong) UILabel * fromL;

// inject : 外部注入的
@property (nonatomic, strong) NSString * introText;
@property (nonatomic, strong) NSString * fromText;
@property (nonatomic, strong) NSString * qrCodeText;

@end

@implementation PoporQRCodeIosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.introText  = @"欢迎使用bing";
    self.qrCodeText = @"https://cn.bing.com";
    self.fromText   = @"-- 来自bing的邀请";
    
    [self addViews];
    [self addBTs];
}

- (void)addViews {
    UIFont * Font14 = [UIFont systemFontOfSize:14];
    for (int i = 0; i<2; i++) {
        UILabel * oneL = ({
            UILabel * l = [UILabel new];
            l.backgroundColor    = [UIColor clearColor];
            l.font               = Font14;
            l.textColor          = [UIColor darkGrayColor];
            
            
            [self.view addSubview:l];
            l;
        });
        oneL.preferredMaxLayoutWidth = 100;
        [oneL setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        oneL.numberOfLines =0;
        switch (i) {
            case 0:{
                oneL.textAlignment = NSTextAlignmentCenter;
                
                oneL.text = self.introText;
                self.introL = oneL;
                
                break;
            }
            case 1:{
                oneL.textAlignment = NSTextAlignmentRight;
                oneL.text = self.fromText;
                self.fromL = oneL;
                
                break;
            }
            default:
                break;
        }
        
    }
    
    UIImageView * oneIV = ({
        UIImageView * iv = [UIImageView new];
        iv.userInteractionEnabled = YES;
        [self.view addSubview:iv];
        iv;
    });
    self.qrCodeIV = oneIV;
    {
        ScreenCommonSize * scs = [ScreenCommonSize share];
        [self.introL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(scs.navBarHeight);
            make.right.mas_equalTo(-20);
        }];
        
        [self.qrCodeIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
            make.top.mas_equalTo(self.introL.mas_bottom).mas_offset(20);
            make.right.mas_equalTo(-40);
            make.height.mas_equalTo(oneIV.mas_width);
        }];
        [self.fromL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(self.qrCodeIV.mas_bottom).mas_offset(20);
            make.right.mas_equalTo(-20);
        }];
    }
    //NSArray *colors = @[RGBA(98, 152, 209, 1), RGBA(190, 53, 77, 1)];
    NSArray *colors = @[[UIColor blackColor], [UIColor blackColor]];
    //colors = @[RGBA(0, 0, 0, 1)];
    //colors = @[ColorBlue1];
    colors = @[RGB16(0X68D3FF), RGB16(0X4585F5)];
    
    NSString *codeStr = self.qrCodeText;
    
    UIImage *img = [JPQRCodeTool generateCodeForString:codeStr withCorrectionLevel:kQRCodeCorrectionLevelHight SizeType:kQRCodeSizeTypeCustom customSizeDelta:20 drawType:kQRCodeDrawTypeSquare gradientType:kQRCodeGradientTypeHorizontal gradientColors:colors];
    
    img = [UIImage imageFromImage:img bgColor:[UIColor whiteColor]];
    
    oneIV.image = img;
}

- (void)addBTs {
    UIButton * bt1;
    UIButton * bt2;
    for (int i = 0; i<2; i++) {
        UIButton * oneBT = ({
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =  CGRectMake(100, 100, 80, 44);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.layer.cornerRadius = 5;
            button.clipsToBounds = YES;
            
            [self.view addSubview:button];
            
            button;
        });
        switch (i) {
            case 0:
                bt1 = oneBT;
                [oneBT setTitle:@"分享" forState:UIControlStateNormal];
                
                break;
            case 1:
                bt2 = oneBT;
                [oneBT setTitle:@"保存" forState:UIControlStateNormal];
                
                break;
                
            default:
                break;
        }
    }
    
    float btH = 45;
    ScreenCommonSize * scs = [ScreenCommonSize share];
    
    [bt1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-scs.tabbarSafeBottomMargin -15);
        make.height.mas_equalTo(btH);
    }];
    [bt2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-scs.tabbarSafeBottomMargin -15);
        make.height.mas_equalTo(btH);
        
        make.width.mas_equalTo(bt1.mas_width);
        make.left.mas_equalTo(bt1.mas_right).mas_offset(10);
    }];
    [bt1 setBackgroundImage:[UIImage imageFromColor:ColorCyan1 size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [bt1 setBackgroundImage:[UIImage imageFromColor:ColorCyan2 size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    
    [bt2 setBackgroundImage:[UIImage imageFromColor:ColorBlue1 size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    [bt2 setBackgroundImage:[UIImage imageFromColor:ColorBlue2 size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    
    [bt1 addTarget:self action:@selector(shareQRCodeImageAction) forControlEvents:UIControlEventTouchUpInside];
    [bt2 addTarget:self action:@selector(saveQRCodeImageAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)saveQRCodeImageAction {
    NSData * data = UIImageJPEGRepresentation(self.qrCodeIV.image, 0.8);
    [UIDevice saveImageDataToPhotos:data showAlert:YES];
}

- (void)shareQRCodeImageAction {
    //分享的标题
    //NSString *textToShare = @"分享的标题。";
    //分享的图片
    //UIImage *imageToShare = self.qrCodeIV.image;
    NSData * data = UIImageJPEGRepresentation(self.qrCodeIV.image, 0.8);
    //分享的url
    //NSURL *urlToShare = [NSURL URLWithString:self.qrCodeText];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[data];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}


@end
