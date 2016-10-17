//
//  UIView+Extension.m
//  view 的扩展
//
//  Created by AS150701001 on 16/6/6.
//  Copyright © 2016年 lele. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
-(void)setYl_x:(CGFloat)yl_x
{
    CGRect frame = self.frame;
    frame.origin.x = yl_x;
    self.frame = frame;

}

-(void)setYl_y:(CGFloat)yl_y
{
    CGRect frame = self.frame;
    frame.origin.y = yl_y;
    self.frame = frame;
}

- (CGFloat)yl_x
{
    return self.frame.origin.x;
}

- (CGFloat)yl_y
{
    return self.frame.origin.y;
}

-(void)setYl_centerX:(CGFloat)yl_centerX
{
    CGPoint center = self.center;
    center.x = yl_centerX;
    self.center = center;
}

-(void)setYl_centerY:(CGFloat)yl_centerY
{
    CGPoint center = self.center;
    center.y = yl_centerY;
    self.center = center;
}


-(CGFloat)yl_centerX
{
    return self.center.x;
}

-(CGFloat)yl_centerY
{
    return self.center.y;
}

-(void)setYl_width:(CGFloat)yl_width
{
    CGRect frame = self.frame;
    frame.size.width = yl_width;
    self.frame = frame;

}

-(void)setYl_height:(CGFloat)yl_height
{
    CGRect frame = self.frame;
    frame.size.height = yl_height;
    self.frame = frame;
}

- (CGFloat)yl_height
{
    return self.frame.size.height;
}

- (CGFloat)yl_width
{
    return self.frame.size.width;
}

- (void)setYl_size:(CGSize)yl_size
{
    CGRect frame = self.frame;
    frame.size = yl_size;
    self.frame = frame;
}

- (CGSize)yl_size
{
    return self.frame.size;
}

- (void)setYl_origin:(CGPoint)yl_origin
{
    CGRect frame = self.frame;
    frame.origin = yl_origin;
    self.frame = frame;
}

- (CGPoint)yl_origin
{
    return self.frame.origin;
}

- (CGFloat) yl_top
{
    return self.frame.origin.y;
}

- (void) setYl_top: (CGFloat) yl_newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = yl_newtop;
    self.frame = newframe;
}

- (CGFloat) yl_left
{
    return self.frame.origin.x;
}

- (void) setYl_left: (CGFloat) yl_newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = yl_newleft;
    self.frame = newframe;
}

- (CGFloat) yl_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setYl_bottom: (CGFloat) yl_newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = yl_newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) yl_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setYl_right: (CGFloat) yl_newright
{
    CGFloat delta = yl_newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


@end
