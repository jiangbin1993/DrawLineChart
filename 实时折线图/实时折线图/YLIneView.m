//
//  YLIneView.m
//  折线图绘制
//
//  Created by AS150701001 on 16/6/27.
//  Copyright © 2016年 lele. All rights reserved.
//

#import "YLIneView.h"
#import "UIView+Extension.h"
#define kStartX  50.0
#define kBottomHeight  30.0  // x 轴距离底部高度
#define kTopMargin    80.0   // y 轴距离顶部的高度
#define kLabelHeight  44.0


@interface YLIneView()

@property(nonatomic,assign)CGPoint perviousPoint;
@property (nonatomic,strong)UILabel *XLabel;
@end


@implementation YLIneView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}


// 系统自动调用方法
-(void)drawRect:(CGRect)rect
{
    // 间距
    CGFloat x_space=(rect.size.width - 10 - 5 - 20) / 100;
    CGFloat y_space=(rect.size.height - kBottomHeight -  kTopMargin - 10) / self.yKeDuValus.count;
    // 设置上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 画 x 轴
    // 初始化路径
    UIBezierPath* path = [UIBezierPath bezierPath];
    // x轴起始坐标点
    CGPoint startA=CGPointMake(kStartX, rect.size.height - kBottomHeight);
    // x轴终点坐标点
    CGPoint endA=CGPointMake(rect.size.width - 5, rect.size.height - kBottomHeight);
    // 从startA点开始画线
    [path moveToPoint:startA];
    // 画一条直线到endA点
    [path addLineToPoint:endA];
    // 路径转换
    CGContextAddPath(ctx, path.CGPath);
    // 线的颜色
    [[UIColor lightGrayColor] set];
    // 线的宽度
    CGContextSetLineWidth(ctx, 1);
    // 开始绘制
    CGContextStrokePath(ctx);
    // 绘制右侧箭头图片
    UIImage *xImg=[UIImage imageNamed:@"right"];
    [xImg drawInRect:CGRectMake(rect.size.width-5 - 5, rect.size.height - 35, 8, 10)];

    /** 画 y 轴 */
    UIBezierPath* yPath=[UIBezierPath bezierPath];
    CGPoint yStart=CGPointMake(kStartX, rect.size.height - kBottomHeight);
    CGPoint yEnd=CGPointMake(kStartX,  kTopMargin);
    [yPath moveToPoint:yStart];
    [yPath addLineToPoint:yEnd];
    CGContextAddPath(ctx, yPath.CGPath);
    CGContextStrokePath(ctx);
    UIImage *yImg=[UIImage imageNamed:@"up"];
    [yImg drawInRect:CGRectMake(kStartX - 4, kTopMargin, 8, 10)];
    
    /** 画 y 轴坐标横线*/
    for (int i = 0; i < self.yKeDuValus.count; i++) {
        // 颜色
        [[UIColor lightGrayColor] setStroke];
        // 宽度
        CGContextSetLineWidth(ctx, 1);
        CGContextBeginPath(ctx);
        // 起点
        CGContextMoveToPoint(ctx,kStartX - 4 , rect.size.height - kBottomHeight - y_space * i);
        // 终点
        CGContextAddLineToPoint(ctx,kStartX,rect.size.height - kBottomHeight - y_space * i);
        // 开始绘制
        CGContextDrawPath(ctx, kCGPathStroke);
        
        // 画数字
        CGFloat ykedu = [_yKeDuValus[i] floatValue];
        NSString* yStr=[NSString stringWithFormat:@"%.2f",ykedu];
        CGSize size=[yStr sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        [yStr drawInRect:CGRectMake(0, rect.size.height - 40 - y_space * i , kBottomHeight + 15, size.height) withAttributes:@{NSForegroundColorAttributeName : self.yValueColor}];
    }
    
    
    UIBezierPath* path1=[UIBezierPath bezierPath];
    // 计算曲线的起点坐标
//    endA=CGPointMake([self.xValues[0] intValue], [self.yValues[0] intValue]);
    startA=CGPointMake(kStartX, rect.size.height - kBottomHeight - y_space * (([self.yValues[0] floatValue] - [self.yKeDuValus[0] floatValue]) / ([self.yKeDuValus[1] floatValue] - [self.yKeDuValus[0] floatValue])));
    [path1 moveToPoint:startA];
    
    /** 计算移到 y 轴的位置*/
    for (int i = 1; i < self.xValues.count; i++) {
        CGFloat X = kStartX + x_space * i;
        
        CGFloat Y = rect.size.height - kBottomHeight - y_space * (([self.yValues[i] floatValue] - [self.yKeDuValus[0] floatValue]) / ([self.yKeDuValus[1] floatValue] - [self.yKeDuValus[0] floatValue]));
        [path1 addLineToPoint:CGPointMake(X, Y)];
    }
    
    CGContextAddPath(ctx, path1.CGPath);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetRGBStrokeColor(ctx, 214.0/255.0, 82.0/255.0, 16.0/255.0, 1.0);
    CGContextStrokePath(ctx);

    
    CGContextSetRGBFillColor(ctx,215.0/255.0, 236.0/255.0, 177.0/255.0, 1.0);
    CGContextFillPath(ctx);
    
    // 绘制矩形框
    NSString* text=[NSString stringWithFormat:@"%.2f",[self.yValues.lastObject floatValue]];    CGSize textSize=[text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0]}];

    CGRect texRrect=CGRectMake(kStartX + x_space * self.xValues.count, rect.size.height - kBottomHeight -  y_space * [self.yValues.lastObject intValue] * 0.1 - 20, textSize.width, textSize.height);
    CGRect juRect=CGRectMake(kStartX + x_space * self.xValues.count- 5, rect.size.height - kBottomHeight -  y_space * [self.yValues.lastObject intValue] * 0.1 - 20, textSize.width+10, textSize.height);
    UIBezierPath* path3=[UIBezierPath bezierPathWithRoundedRect:juRect cornerRadius:5];

    CGContextAddPath(ctx, path3.CGPath);
    CGContextSetRGBFillColor(ctx, 131.0/255.0, 190.0/255.0, 34.0/255.0, 1.0);
    CGContextFillPath(ctx);
    
    
    [text drawInRect:texRrect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // 绘制X轴的分割度线
    for (int i = 0; i < 6; i++) {
        [[UIColor  lightGrayColor] setStroke];
        CGContextSetLineWidth(ctx, 1);
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx,kStartX + (rect.size.width - kStartX) / 5 * i , rect.size.height - kBottomHeight);
        CGContextAddLineToPoint(ctx,kStartX + (rect.size.width - kStartX) / 5 * i, rect.size.height - 25);
        CGContextDrawPath(ctx, kCGPathStroke);
    }

    // 画X轴下面的字
    
            CGFloat currentY = [[_yValues lastObject] floatValue];

            NSString *textStr=[NSString stringWithFormat:@"5分钟后指数比当前（%.2f）是涨还是跌?",currentY];
    
            CGSize titleSize=[textStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0]}];

            [textStr drawInRect:CGRectMake(0, rect.size.height - 16, titleSize.width, titleSize.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.0],NSForegroundColorAttributeName:self.xValueColor}];
}


@end
