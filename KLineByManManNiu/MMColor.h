//
//  MMColor.h
//  KLineByManManNiu
//
//  Created by Apple on 15/12/30.
//  Copyright © 2015年 NiuWenMan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef  struct Range {
    CGFloat max;
    CGFloat min;
} CGRange;


// static inline ：  static 标识此内联联函数只能在本文件中使用，限制了内联函数的作用域
//关于内联函数的了解：
// 有函数的结构，但不具备函数的性质，类似于宏替换

CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min);

CG_INLINE CGRange CGRangeMake(CGFloat max, CGFloat min) {
    CGRange p;
    p.max = max;
    p.min = min;
    return p;
}


static const CGRange CGRangeZero = {0, 0};

@interface MMColor : UIColor

+ (UIColor *)randomColor;









@end
