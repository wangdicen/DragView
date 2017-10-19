//
//  DragView.h
//  Exercise
//
//  Created by 谢豪杰 on 2017/10/19.
//  Copyright © 2017年 谢豪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DragView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic,assign) BOOL isDragable;

@property (nonatomic,assign) BOOL isRotatable;

@property (nonatomic,assign) BOOL isScalable;
@end
