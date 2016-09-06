//
//  HCSideSlipTransmition.h
//  HelperCar
//
//  Created by Jentle on 15/9/1.
//  Copyright © 2015年 Jentle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCSideSlipTransmition : NSObject

/**
 *  初始化侧滑动画
 *
 *  @param frame      点击弹出后的View的位置
 *  @param view       上层的可以侧滑的View
 *  @param parentView View的父视图
 *  @param show       是否显示底部黑框
 */
- (instancetype)initWithframe:(CGRect)frame withView:(UIView *)view withParentView:(UIView *)parentView showBlackBottom:(BOOL)show;

/**
 *  点击出现侧滑框
 */
- (void)show;

/**
 *  点击隐藏侧滑框
 */
- (void)dismiss:(BOOL)animated;
@end
