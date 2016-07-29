//
//  ChartViewSample.m
//  KLineByManManNiu
//
//  Created by Apple on 16/1/6.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import "ChartViewSample.h"

@interface ChartViewSample()
{
    UIImageView *imageView;
    CGFloat _X0; // 表格的顶点.
    CGFloat _Y0;
    
}

@end

@implementation ChartViewSample

// 标题
- (void)setTitlesX:(NSArray *)titlesX {
    _titlesX = titlesX;
}

- (void)setTitlesY:(NSArray *)titlesY {
    _titlesY = titlesY;
}

// 点的数组. x轴
- (void)setXArray:(NSArray *)xArray {
    _xArray = xArray;
}

// 点的数组. y轴
- (void)setYArray:(NSArray *)yArray {
    _yArray = yArray;
}

- (void)setWidthCell:(CGFloat)widthCell {
    _widthCell = widthCell;
}

- (void)setHangShu:(NSInteger)hangShu {
    _hangShu = hangShu;
}

- (void)setLieShu:(NSInteger)lieShu {
    _lieShu = lieShu;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
}

- (void)setIsDong:(BOOL)isDong {
    _isDong = isDong;
    [self setNeedsDisplay];
    if (_isDong) {
        [self drawBiaoGeFirst];
    }
}

- (void)setChartStyle:(MMChartStyle)chartStyle {
    _chartStyle = chartStyle;
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
            self.backgroundColor = [UIColor whiteColor];
        // 表格第一个点的位置：
        int x = _widthCell, y = 10;
        _X0 = x, _Y0 = y;
        

    }
    return self;
}


- (void)drawRect:(CGRect)rect {
//    [self drawBiaoGeThird];
    [self drawBiaoGeSec]; //绘制表格.
    
    switch (_chartStyle) {
        case MMChartStyleLine:
            /*
            [self drawBiaoGeFirst]; // 1. 使用CGContext 绘制. 使用基于位图的方法.UIGraphicsBeginImage
            */
           //  使用CGContext 绘制
            [self addLines];
            break;
            
        case MMChartStyleDongLine:
            [self addChartLines]; // 画动态K线
            break;
            
        case MMChartStyleYuanBing: // 圆饼图  实心.
            [self  addBar];
            break;
            
        case MMChartStyleRect:
//            [self addRects];
            [self addRectSec];
            break;
            
        case MMChartStyleXuanHu:
            
            break;
        case MMChartStyleXuXian:
            
            break;
        default:
            break;
    }
    
    
}


- (void)drawLineViewWithX:(CGFloat)x Y:(CGFloat)y X2:(CGFloat)x2 Y2:(CGFloat)y2{
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _lineWidth);
    //    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
//    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());

    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x2, y2);
    CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制

    CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
    imageView.image = UIGraphicsGetImageFromCurrentImageContext(); // 绘制结果就是类似一张图片
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    UIGraphicsEndImageContext();//结束绘制.
    [self setNeedsDisplay];

}


//画表格 // 第一种  UIImageView
- (void)drawBiaoGeFirst {
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.backgroundColor = [UIColor cyanColor];
    [self addSubview:imageView];

//    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 1.0);//和
    
    UIGraphicsBeginImageContext(imageView.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);//线条颜色
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor lightGrayColor].CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    //1.
    // 绘制表格： 五行  六列.
    
    // 表格第一个点的位置：
    int x = _widthCell, y = 10;
    _X0 = _widthCell * 2, _Y0 = y;
    //列的坐标点：
    
    //第几条 按坐标由上到下 由左到右 依次递增
    //有n 行 m列 就有  n + 1 条横线，  m + 1 条竖线
    //横线
    for (int i = 0; i < _hangShu + 1; i++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _X0 , y+ i * _heightCell);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _X0 +_lieShu * _widthCell, y+ i * _heightCell);
        CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
    }
    
    for (int i = 0; i < _lieShu + 1; i ++) {
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _X0 + i * _widthCell, y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _X0 + i * _widthCell, y + _heightCell * _hangShu);
        CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
    }
    
    //2.
    [self addTitlesForX]; // x轴的标题.
    [self addTitlesForY]; // y轴的标题.
    
    [self addLines];
    
    
    CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
    imageView.image = UIGraphicsGetImageFromCurrentImageContext(); // 绘制结果就是类似一张图片
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    UIGraphicsEndImageContext();//结束绘制.

    
}

// 画表格第二种.
- (void)drawBiaoGeSec {
    //    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 1.0);//和
    
    //    UIGraphicsBeginImageContext(imageView.frame.size);
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    //    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 0.5);//线条颜色
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor lightGrayColor].CGColor);
    //    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    
    //1.
    // 绘制表格： 五行  六列.
    
    // 表格第一个点的位置：
    int x = _widthCell, y = 10;
    _X0 = _widthCell * 2, _Y0 = y;
    //列的坐标点：
    
    //第几条 按坐标由上到下 由左到右 依次递增
    //有n 行 m列 就有  n + 1 条横线，  m + 1 条竖线
    //横线
    for (int i = 0; i < _hangShu + 1; i++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _X0 , _Y0+ i * _heightCell);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _X0 +_lieShu * _widthCell, _Y0+ i * _heightCell);
        CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
        
    }
    
    
    for (int i = 0; i < _lieShu + 1; i ++) {
        
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _X0 + i * _widthCell, _Y0);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _X0 + i * _widthCell, _Y0 + _heightCell * _hangShu);
        CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
        
    }
    //    [self addChartViewSec];
    //2.
    [self addTitlesForX]; // x轴的标题.
    [self addTitlesForY]; // y轴的标题.

}



// 画表格
- (void)drawBiaoGeThird {
    
    int x = _widthCell, y = 10;
    _X0 = _widthCell * 2, _Y0 = y;
    
    CAShapeLayer *layer = [[CAShapeLayer  alloc] init];
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineWidth = 0.2;
    layer.lineCap = kCALineCapButt;
    [self.layer addSublayer:layer];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path closePath];
    
    for (int i = 0; i < _hangShu + 1; i ++) {
        [path moveToPoint:CGPointMake(_X0, _Y0 + i * _heightCell )];
        [path addLineToPoint:CGPointMake(_X0 + _lieShu * _widthCell, _Y0 + i * _heightCell)];
        layer.path = path.CGPath;
        
    }
    
    for (int i = 0; i < _lieShu + 1; i ++) {
        [path moveToPoint:CGPointMake(_X0 + _widthCell * i, _Y0 )];
        [path addLineToPoint:CGPointMake(_X0+ _widthCell * i, _Y0 +  _heightCell * _hangShu)];
        layer.path = path.CGPath;
        
    }
    //2.
    [self addTitlesForX]; // x轴的标题.
    [self addTitlesForY]; // y轴的标题.

    
}

//划线第一种
- (void)addLines {
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    //    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);//线条颜色
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor lightGrayColor].CGColor);
    //    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    

    //     划线
    //    rangeValueY: y轴显示的范围值.
    CGFloat rangeValueY = [[_titlesY firstObject] floatValue] - [[_titlesY lastObject] floatValue]; //看数值的顺序.
    
    NSInteger num = _yArray.count + 3;
    CGPoint points[num];
    
    for (int i = 0; i < _yArray.count  - 1; i ++) {
        CGFloat Dvalue = [_yArray[i]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i个值与起点的差值.
        CGFloat y = (1.0 - Dvalue / rangeValueY) *( _heightCell * _hangShu) + _Y0;
        CGFloat x = _X0 + _widthCell * i;
        points[i] = CGPointMake(x, y);
        
        
        CGFloat Dvalue1 = [_yArray[i + 1]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i + 1个值与起点的差值.
        CGFloat y1 = (1.0 - Dvalue1 / rangeValueY) *( _heightCell * _hangShu) + _Y0;
        CGFloat x1 = _X0  + _widthCell * (i + 1);
        if (i == _yArray.count - 1 - 1) {
            points[i + 1] = CGPointMake(x1, y1);
        }
        
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
        // 如果此处不设置颜色 颜色就是灰色.
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 180/ 255.0, 187/ 255.0, 1.0);//线条颜色
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x , y);

        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x1, y1);
        CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
        
    }
//    [self setNeedsDisplay];
    
    points[num - 3] = CGPointMake(_X0 + _widthCell * _lieShu, _Y0 + _heightCell * _hangShu);
    points[num - 2] = CGPointMake(_X0, _Y0 + _heightCell * _hangShu);
    points[num - 1] = CGPointMake(_X0, _Y0 + _heightCell * _hangShu);

    
    CGContextAddLines(UIGraphicsGetCurrentContext(), points, _yArray.count + 3);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [UIColor colorWithRed:0.0 / 255.0 green:180 /255.0 blue:157 / 255.0 alpha:0.6].CGColor);
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFill);

    //NO.8渐变
//    
//        CGContextClip(UIGraphicsGetCurrentContext());
//        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//        CGFloat colors[] =
//        {
//            204.0 / 255.0, 224.0 / 255.0, 244.0 / 255.0, 1.00,
//            29.0 / 255.0, 156.0 / 255.0, 215.0 / 255.0, 1.00,
//            0.0 / 255.0,  50.0 / 255.0, 126.0 / 255.0, 1.00,
//        };
//        CGGradientRef gradient = CGGradientCreateWithColorComponents
//        (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
//        CGColorSpaceRelease(rgb);
//        CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(), gradient,CGPointMake
//                                    (0.0,300.0) ,CGPointMake(0.0,self.frame.size.height),
//                                    kCGGradientDrawsBeforeStartLocation);
    
    
}



- (void)addChartLines {
    //3.
    // 划线
    //rangeValueY: y轴显示的范围值.
    CGFloat rangeValueY = [[_titlesY firstObject] floatValue] - [[_titlesY lastObject] floatValue]; //看数值的顺序.
    //    CGFloat Dvalue = [[_yArray firstObject] floatValue] - [[_titlesY lastObject] floatValue]; // 第一个值与起点的差值.
    //    CGFloat leftY = _Y0 + _heightCell * _hangShu; //最左边的最后一个顶点的y值.
    
    //划线
    CAShapeLayer *_chartLine = [CAShapeLayer layer];
    _chartLine.lineCap = kCALineCapRound; // 线的顶端类型： 圆角， 直的；
    _chartLine.lineJoin = kCALineJoinBevel;
    _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
    _chartLine.lineWidth   = 1.0;
//    _chartLine.strokeEnd   = 0.0;
    _chartLine.strokeColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:_chartLine];
    
    
    //绘制路径
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline setLineWidth:10.0];
    [progressline setLineCapStyle:kCGLineCapRound];
    [progressline setLineJoinStyle:kCGLineJoinRound];
    [progressline stroke];
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    //    pathAnimation.repeatCount = 100; // 重复次数.
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _chartLine.strokeEnd = 1.0; //停止.
    

    CGFloat Dvalue = [_yArray[0]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i个值与起点的差值.
    CGFloat y = (1.0 - Dvalue / rangeValueY) *( _heightCell * _hangShu)+ _Y0 ;
    CGFloat x = _X0 ;
    [progressline moveToPoint:CGPointMake(x,y)];
    
    
    for (int i = 1; i < _yArray.count; i++) {
        
        CGFloat Dvalue = [_yArray[i]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i个值与起点的差值.
        CGFloat y = (1.0 - Dvalue / rangeValueY) *( _heightCell * _hangShu )+ _Y0;
        CGFloat x = _X0 + _widthCell * i;
        _chartLine.path = progressline.CGPath;

        [progressline addLineToPoint:CGPointMake(x, y)];
        [progressline moveToPoint:CGPointMake(x,y)];
        
        
        if (i == _yArray.count - 1) {
            
            // 如果是最后一个点了
            CGFloat Dvalue = [_yArray[i]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i个值与起点的差值.
            CGFloat y = (1.0 - Dvalue / rangeValueY) *( _heightCell * _hangShu) + _Y0;
            CGFloat x = _X0 + _widthCell * i;
            _chartLine.path = progressline.CGPath;
            [progressline addLineToPoint:CGPointMake(x, y)];
            
        }
        
        
    }
    
}



// 柱状图  渐变色
- (void)addRects {
    
    //3.
    // 划线
    //rangeValueY: y轴显示的范围值.
    CGFloat rangeValueY = [[_titlesY firstObject] floatValue] - [[_titlesY lastObject] floatValue]; //看数值的顺序.
    //    CGFloat Dvalue = [[_yArray firstObject] floatValue] - [[_titlesY lastObject] floatValue]; // 第一个值与起点的差值.
    //    CGFloat leftY = _Y0 + _heightCell * _hangShu; //最左边的最后一个顶点的y值.
    
    
    //划线
    CAShapeLayer *_chartLine = [CAShapeLayer layer];
    _chartLine.lineCap = kCALineCapSquare; // 线的顶端类型： 圆角， 直的；
//    _chartLine.lineJoin = kCALineJoinBevel;
    _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
    _chartLine.lineWidth   = _widthCell;
//    _chartLine.strokeEnd = 0.0;  // 当设置动画的时候   此属性才可设置为0.0， 否则不显示线
    _chartLine.strokeColor = [UIColor yellowColor].CGColor;
    [self.layer addSublayer:_chartLine];

    //绘制路径
    UIBezierPath *progressline = [UIBezierPath bezierPath];
//   [progressline closePath];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    //    pathAnimation.repeatCount = 100; // 重复次数.
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    _chartLine.strokeEnd = 1.0; //停止.
    
    NSLog(@"===============%lf, %lf--", _X0, _Y0);
      for (int i = 0; i < _yArray.count; i++) {
          
        CGFloat x = _X0 + _widthCell * 3 / 2 + 3 * _widthCell * i;
        CGFloat Dvalue = [_yArray[i]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i个值与起点的差值.
        CGFloat y;
          if (Dvalue != 0.0) {
              
             y = (1.0 - Dvalue / rangeValueY) *( _heightCell * _hangShu)  + _Y0 + _widthCell / 2;
              _chartLine.lineWidth = _widthCell;
              [progressline moveToPoint:CGPointMake(x, _Y0 + _hangShu * _heightCell - _widthCell / 2)];
              [progressline addLineToPoint:CGPointMake(x, y)];
              _chartLine.path = progressline.CGPath; // 重要的一句话  只有当path路径的起点 和 终点都已经设置好之后赋值才有效.
          } else {
              // 此处只能使用UIBezierpath， 若设置layer的属性 则其他的也会跟着改变. 谨记！！！！！！！！
              UIBezierPath *path = [UIBezierPath bezierPath];
              y =  _heightCell * _hangShu + _Y0;
              path.lineWidth = 3.0f;
              [[UIColor yellowColor] setStroke];
              [path moveToPoint:CGPointMake(x - _widthCell / 2,y)];
              [path addLineToPoint:CGPointMake(x + _widthCell / 2, y)];
              [path stroke];
              
          }
          
    }
    
}



// 矩形第二种画法：
- (void)addRectSec {

    CGFloat rangeValueY = [[_titlesY firstObject] floatValue] - [[_titlesY lastObject] floatValue]; //看数值的顺序.
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    UIColor *color = [UIColor colorWithRed:255/255.0 green:205/255.0 blue:77/ 255.0 alpha:0.8];
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    
    
    for (int i = 0; i < _yArray.count; i++) {
        
        CGFloat Dvalue = [_yArray[0]  floatValue] - [[_titlesY lastObject] floatValue]; // 第i个值与起点的差值.
        CGFloat y = (1.0 - Dvalue / rangeValueY) *( _heightCell * _hangShu)+ _Y0 ;
        CGFloat x = _X0  + _widthCell + 3 * _widthCell * i;
        CGFloat height = _heightCell * _hangShu + _Y0 - y;
        CGContextAddRect(context, CGRectMake(x, y, _widthCell * 2, height));
        
        
        //NO.8渐变
        /**
         CGGradientRef: 渐变
         CGColorSpaceRef：不透明封装颜色空间信息类型
         */
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(x, y, 2 * _widthCell, height);
        gradient.colors = [NSArray arrayWithObjects:
                           
                           (id)[UIColor colorWithRed:255/255.0 green:149/255.0 blue:28/255.0 alpha:1.0].CGColor,
                           
                           (id)[UIColor colorWithRed:255/255.0 green:205/255.0 blue:77/255.0 alpha:1.0].CGColor,
                           
                           (id)[UIColor colorWithRed:255/255.0 green:235/255.0 blue:28/255.0 alpha:1.0].CGColor,
                           
                           nil];
        
        [self.layer insertSublayer:gradient atIndex:0];
        CGContextStrokePath(context);
    }
    
    
}


// 圆饼图
- (void)addBar {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextAddEllipseInRect(context, CGRectMake(100, 100, 100, 100));
    CGContextFillPath(context);
    
}



// 圆弧线
- (void)xuanHu {
    
}

//圆弧虚线图
- (void)xuanXian {
    
}

// X轴的标题
- (void)addTitlesForX {
    // 设置每一项标题的字体以及属性字典.
    CGFloat fontTitle = 14;
    NSDictionary *attributeTitle = @{NSFontAttributeName: [UIFont systemFontOfSize:fontTitle]};
    CGFloat width = _widthCell * 3;
    
    for (int i = 0; i < _titlesX.count; i++) {
        CGFloat  x1 = _X0 - width + 2 * width * i;
        CGFloat x2 = x1 + 2 * width;
        CGFloat y1 = _Y0 + _heightCell * (_hangShu);
        CGFloat y2 = _Y0 + _heightCell * (_hangShu + 1);
        NSString *title = _titlesX[i];
        [title drawInRect: [self getRectWithX1:x1 X2:x2 Y1:y1 Y2:y2 String:title withFont:fontTitle] withAttributes:attributeTitle];
        
    }
    
}

// Y轴的标题
- (void)addTitlesForY {
    // 设置每一项标题的字体以及属性字典.
    CGFloat fontTitle = 14;
    NSDictionary *attributeTitle = @{NSFontAttributeName: [UIFont systemFontOfSize:fontTitle]};
    
    
    for (int i = 0; i < _hangShu + 1; i++) {
        CGFloat  x1 = _X0 -  _widthCell;
        CGFloat x2 = _X0;
        CGFloat y1 = _Y0 - _heightCell / 2 + _heightCell * i;
        CGFloat y2 = _Y0 - _heightCell / 2 + _heightCell * (i + 1);
        NSString *title = _titlesY[i];
        [title drawInRect: [self getRectWithX1:x1 X2:x2 Y1:y1 Y2:y2 String:title withFont:fontTitle] withAttributes:attributeTitle];
        
    }

}

- (CGSize)getSizeWithString:(NSString *)str withFont:(CGFloat)font  {
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:font]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(320, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return size;
    
}


// x1: x2:标题左右两顶点的x      y1: y2: 标题上下两顶点的y
- (CGRect)getRectWithX1:(CGFloat)x1 X2:(CGFloat)x2 Y1:(CGFloat)y1 Y2:(CGFloat)y2 String:(NSString *)str withFont:(CGFloat)font   {
    
    CGSize size = [self getSizeWithString:str withFont:font];
    
    CGFloat x = (x2 - x1 - size.width) / 2 + x1;
    CGFloat y;
    
//    if (type == YES) {
//        // 表明是 x轴的.
//        y = (y2 - y1 - size.height) / 2 + y1;
//    } else {
        // 表明是y轴的
        y = (y2 - y1 - size.height) / 2 + y1;
//    }
    
    return CGRectMake(x, y, size.width, size.height);
    
}









@end
