//
//  ViewController.m
//  KLineByManManNiu
//
//  Created by Apple on 15/12/30.
//  Copyright © 2015年 NiuWenMan. All rights reserved.
//

#import "ViewController.h"
#import "SimpleChartViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *iten = [[UIBarButtonItem alloc] initWithTitle:@"简单表格" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = iten;
 
//    [self drawRect];
    [self drawRectSec];
    
}



- (void)drawRectSec {
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    //    [self.view addSubview:imageView];
        imageView.backgroundColor = [UIColor redColor];
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    

    CGContextRef context = UIGraphicsGetCurrentContext();
  
    NSArray *colors = [NSArray arrayWithObjects:
                  
                       [UIColor colorWithRed:1.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1.0],
                    
                       [UIColor colorWithRed:168.0 / 255.0 green:168.0 / 255.0 blue:168.0 / 255.0 alpha:1.0],
                   
                       nil];
   
    [self _drawGradientColor:context
   
                        rect:CGRectMake(100, 100, 50, 200)
 
                     options:kCGGradientDrawsAfterEndLocation
     
                      colors:colors];
    
    CGContextStrokePath(context);// 描线,即绘制形状
    
    CGContextFillPath(context);// 填充形状内的颜色
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [imageView.image drawInRect:CGRectMake(100, 100, 300, 300)];
    
    UIGraphicsEndImageContext();

}

/**
 02
 * 绘制背景色渐变的矩形，p_colors渐变颜色设置，集合中存储UIColor对象（创建Color时一定用三原色来创建）
 03
 **/

- (void)_drawGradientColor:(CGContextRef)p_context rect:(CGRect)p_clipRect options:(CGGradientDrawingOptions)p_options

colors:(NSArray *)p_colors {
    
    CGContextSaveGState(p_context);// 保持住现在的context
    
    CGContextClipToRect(p_context, p_clipRect);// 截取对应的context
   
    int colorCount = (int)p_colors.count;
    
    int numOfComponents = 4;
   
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
  
    CGFloat colorComponents[colorCount * numOfComponents];
   
    for (int i = 0; i < colorCount; i++) {
        
        UIColor *color = p_colors[i];
       
        CGColorRef temcolorRef = color.CGColor;
     
        const CGFloat *components = CGColorGetComponents(temcolorRef);
    
        for (int j = 0; j < numOfComponents; ++j) {
         
            colorComponents[i * numOfComponents + j] = components[j];
           
        }
     
    }
   
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(rgb, colorComponents, NULL, colorCount);
    
    CGColorSpaceRelease(rgb);
    
    CGPoint startPoint = p_clipRect.origin;
    CGPoint endPoint = CGPointMake(CGRectGetMinX(p_clipRect), CGRectGetMaxY(p_clipRect));
    CGContextDrawLinearGradient(p_context, gradient, startPoint, endPoint, p_options);
    CGGradientRelease(gradient);
    CGContextRestoreGState(p_context);// 恢复到之前的context
    
}


- (void)drawRect {
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
//    [self.view addSubview:imageView];
//    imageView.backgroundColor = [UIColor redColor];
    UIGraphicsBeginImageContext(CGSizeMake(300, 300));
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 矩形
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokeRect(context, CGRectMake(100, 100, 30, 100));
    CGContextBeginPath(context);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 100, 200);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 200, 200);
    

    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = CGRectMake(100, 100, 30, 100);
    
    gradient.colors = [NSArray arrayWithObjects:
                       
                       (id)[UIColor blackColor].CGColor,
                       
                       (id)[UIColor grayColor].CGColor,
                       
                       (id)[UIColor blackColor].CGColor,
                       
                       nil];
    
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [imageView.image drawInRect:CGRectMake(100, 100, 300, 300)];

    UIGraphicsEndImageContext();
    
    
}



- (void)rightItemAction:(UIBarButtonItem *)sender {
    
    SimpleChartViewController *simnpleVC = [[SimpleChartViewController alloc] init];
    [self.navigationController pushViewController:simnpleVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
