//
//  DragView.m
//  Exercise
//
//  Created by 谢豪杰 on 2017/10/19.
//  Copyright © 2017年 谢豪杰. All rights reserved.
//

#import "DragView.h"
#import "UIView+Transform.h"

@implementation DragView
{
//    CGPoint startLocation;
    CGPoint previousLocation;
    
    CGFloat tx;
    CGFloat ty;
    CGFloat scale;
    CGFloat theta;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self customInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)customInit{
    self.userInteractionEnabled = YES;
    _isDragable = YES;
    _isScalable = YES;
    _isRotatable = YES;
    
    self.transform = CGAffineTransformIdentity;
    tx = 0.0f;
    ty = 0.0f;
    scale = 1.0f;
    theta = 0.0f;
    
    UIRotationGestureRecognizer *rot = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    self.gestureRecognizers = @[rot,pinch,pan];
    for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
        recognizer.delegate = self;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    startLocation = [[touches anyObject] locationInView:self];
    previousLocation = self.center;
    
    tx = self.transform.tx;
    ty = self.transform.ty;
    scale = self.scaleX;
    theta = self.rotation;
    
    [self.superview bringSubviewToFront:self];
}

//点三下重置
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 3)
    {
        self.transform = CGAffineTransformIdentity;
        tx = 0.0f;
        ty = 0.0f;
        scale = 1.0f;
        theta = 0.0f;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGPoint pt = [[touches anyObject] locationInView:self];
//    float dx = pt.x - startLocation.x;
//    float dy = pt.y - startLocation.y;
//    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
//    if (_isDragable == YES) {
//        self.center = newcenter;
//    }
//}


- (void)updateTransformWithOffset:(CGPoint)translation
{
    if (_isDragable) {
        self.transform = CGAffineTransformMakeTranslation(translation.x + tx, translation.y + ty);
    }
    if (_isRotatable == YES) {
        self.transform = CGAffineTransformRotate(self.transform, theta);
    }
    if (_isScalable == YES) {
        if(self.scaleX > 1.5f){
            self.transform = CGAffineTransformScale(self.transform, 1.5, 1.5);
        }
        
        else if (self.scaleX > 0.5f) {
            self.transform = CGAffineTransformScale(self.transform, scale, scale);
        }
        else
        {
            self.transform = CGAffineTransformScale(self.transform, 0.5f, 0.5f);
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)uigr
{
    CGPoint translation = [uigr translationInView:self.superview];
//    [self updateTransformWithOffset:translation];
    CGPoint newcenter = CGPointMake(previousLocation.x + translation.x, previousLocation.y + translation.y);
    
    float halfx = CGRectGetMinX(self.bounds);
    newcenter.x = MAX(halfx, newcenter.x);
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    float halfy = CGRectGetMinY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    if (_isDragable) {
       self.center = newcenter;
    }
}

- (void)handleRotation:(UIRotationGestureRecognizer *)uigr
{
    theta  = uigr.rotation;
    [self updateTransformWithOffset:CGPointZero];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)uigr
{
    
    NSLog(@"%f",uigr.scale);
    scale = uigr.scale;
    [self updateTransformWithOffset:CGPointZero];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
