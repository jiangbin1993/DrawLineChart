//
//  YLIneView.h
//  折线图绘制
//
//  Created by AS150701001 on 16/6/27.
//  Copyright © 2016年 lele. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLIneView : UIView
/**
 @brief x 轴上的值
 */
@property(nonatomic,strong)NSMutableArray* xValues;
/**
 @brief y 轴上的值
 */
@property(nonatomic,strong)NSMutableArray* yValues;
/**
 @brief x 轴的刻度值
 */
@property(nonatomic,strong)NSArray* xKeDuValus;

 

 /**
 @brief y 轴的刻度值
 */
@property(nonatomic,strong)NSArray* yKeDuValus;
/**
 @brief x 轴上文字颜色
 */
@property(nonatomic,strong)UIColor* xValueColor;
/**
 @brief y 轴上文字颜色
 */
@property(nonatomic,strong)UIColor* yValueColor;

@end
