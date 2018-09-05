//
//  ScreenCommonSize.h
//  linRunShengPi
//
//  Created by popor on 2018/3/27.
//  Copyright © 2018年 popor. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark - iOS
#if TARGET_OS_IOS || TARGET_OS_WATCH
@interface ScreenCommonSize : NSObject

+ (instancetype)share;


/** 状态栏 size */
@property (nonatomic) CGSize statusSize;

/** 状态栏 size */
@property (nonatomic, getter=isPhoneX) BOOL phoneX;

/** 导航栏的高度，包含状态栏 */
@property (nonatomic) CGFloat navBarHeight;

/** iphoneX 底部安全距离 */
@property (nonatomic) CGFloat tabbarSafeBottomMargin;


@end

#pragma mark - macOX
#elif TARGET_OS_MAC


#endif


