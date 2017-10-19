//
//  UIView+Transform.m
//  Exercise
//
//  Created by 谢豪杰 on 2017/10/19.
//  Copyright © 2017年 谢豪杰. All rights reserved.
//

#import "UIView+Transform.h"

@implementation UIView (Transform)

/**
CGAffineTransform是一个3*3的变换矩阵
 x缩放比例为a平方+c平方的开根号
 y缩放比例是b平方+d平方的开根号
 旋转角度是a/b的反正切
**/
- (CGFloat)scaleX
{
    CGAffineTransform t = self.transform;
    return sqrt(t.a * t.a + t.c * t.c);
}

- (CGFloat)scaleY
{
    CGAffineTransform t = self.transform;
    return sqrt(t.b *t.b + t.d * t.d);
}

- (CGFloat)rotation
{
    CGAffineTransform t = self.transform;
    return atan2f(t.b, t.a);
}

@end
