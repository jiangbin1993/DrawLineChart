//
//  UIView+Extension.h
//  view 的扩展
//
//  Created by AS150701001 on 16/6/6.
//  Copyright © 2016年 lele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 @brief x 的位置
 */
@property (nonatomic, assign) CGFloat yl_x;
/**
 @brief y 的位置
 */
@property (nonatomic, assign) CGFloat yl_y;
/**
 @brief 竖直方向 x 的值
 */
@property (nonatomic, assign) CGFloat yl_centerX;
/**
 @brief 水平方向 y 的值
 */
@property (nonatomic, assign) CGFloat yl_centerY;
/**
 @brief 宽度
 */
@property (nonatomic, assign) CGFloat yl_width;
/**
 @brief 高度
 */
@property (nonatomic, assign) CGFloat yl_height;
/**
 @brief 大小
 */
@property (nonatomic, assign) CGSize yl_size;
/**
 @brief 原点
 */
@property (nonatomic, assign) CGPoint yl_origin;
/**
 @brief 顶部 -- 最小 y 值
 */
@property CGFloat yl_top;
/**
 @brief 左边 -- 最小 x 值
 */
@property CGFloat yl_left;
/**
 @brief 底部 -- 最大 y 值
 */
@property CGFloat yl_bottom;
/**
 @brief 右边 -- 最大 x 值
 */
@property CGFloat yl_right;

@end
