//
//  PieYuanBingView.m
//  KLineByManManNiu
//
//  Created by Apple on 16/1/8.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import "PieYuanBingView.h"
#import <QuartzCore/QuartzCore.h>

@interface PieLayer : CAShapeLayer
@property (nonatomic, assign) CGFloat   value;
@property (nonatomic, assign) CGFloat   percentage;
@property (nonatomic, assign) double    startAngle;
@property (nonatomic, assign) double    endAngle;
@property (nonatomic, assign) BOOL      isSelected;
- (void)createArcAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to Delegate:(id)delegate;

@end


@implementation PieLayer

@synthesize value = _value;
@synthesize percentage = _percentage;
@synthesize startAngle = _startAngle;
@synthesize endAngle = _endAngle;
@synthesize isSelected = _isSelected;



+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    else {
        return [super needsDisplayForKey:key];
    }
}

- (id)initWithLayer:(id)layer
{
    if (self = [super initWithLayer:layer])
    {
        if ([layer isKindOfClass:[PieLayer class]]) {
            self.startAngle = [(PieLayer *)layer startAngle];
            self.endAngle = [(PieLayer *)layer endAngle];
        }
    }
    return self;
}

- (void)createArcAnimationForKey:(NSString *)key fromValue:(NSNumber *)from toValue:(NSNumber *)to Delegate:(id)delegate
{
    CABasicAnimation *arcAnimation = [CABasicAnimation animationWithKeyPath:key];
    NSNumber *currentAngle = [[self presentationLayer] valueForKey:key];
    if(!currentAngle) currentAngle = from;
    [arcAnimation setFromValue:from];
    [arcAnimation setToValue:to];
    [arcAnimation setDelegate:delegate];
    [arcAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];

    [self addAnimation:arcAnimation forKey:key];
    [self setValue:to forKey:key];
    
}


@end


@interface PieYuanBingView()
{
    CGPoint point; // 圆饼的中心
    NSTimer *animationTimer; // 动画控制的
    UIView *pieView;
    NSMutableArray *animations;

}

@end

@implementation PieYuanBingView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:1.0];
        animations = [[NSMutableArray alloc] init];

      
      


    }
    return self;
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)setPieStyle:(MMPieStyle)pieStyle {
    _pieStyle = pieStyle;
    if (_pieStyle == MMPieStyleShiXinPieOneByOne || _pieStyle == MMPieStyleShiXinPieAll) {
        pieView = [[UIView alloc] init];
        pieView.backgroundColor = [UIColor redColor];
        [pieView setCenter:point];
        CGRect frame = CGRectMake(point.x - _radiuds, point.y - _radiuds, _radiuds * 2, _radiuds * 2);
        pieView.frame = frame;
//        pieView.clipsToBounds = YES;
        pieView.layer.cornerRadius = _radiuds;
         [self insertSubview:pieView atIndex:0];
    }
    
}

// 圆饼的半径.
- (void)setRadiuds:(CGFloat)radiuds {
    _radiuds = radiuds;
    CGFloat centerX = (self.frame.size.width - 2 * _radiuds) / 2 + _radiuds;
    CGFloat centerY = _radiuds + 20;
    point = CGPointMake(centerX, centerY);
    
}

- (void)setSlicesArray:(NSArray *)slicesArray {
    _slicesArray = slicesArray;
    
}


- (void)addVIews {
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 180 - 60, Screen_Width - 200, 20)];
    label.text = @"今日步数";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 180 - 25, Screen_Width - 200, 50)];
    label1.text = @"1713";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor orangeColor];
    label1.font = [UIFont boldSystemFontOfSize:40];
    [self addSubview:label1];
    
    
}



- (void)drawRect:(CGRect)rect {

    switch (_pieStyle) {
        case MMPieStyleXuXian:
            [self drawXuXian];
            break;
        case MMPieStyleShiXinPieAll:
            [self drawShiPie];
            break;
        case MMPieStyleShiXinPieOneByOne:
            [self drawShiXinPieView];
            break;
        case MMPieStyleNSString:
            [self drawNSString];
            break;

        default:
            break;
    }
    
    
}


- (void)drawXuXian {
    
    [self addVIews];

//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    
//    /*
//     绘制贝兹曲线
//     //贝兹曲线是通过移动一个起始点，然后通过两个控制点,还有一个中止点，调用CGContextAddCurveToPoint() 函数绘制
//     CGContextSetLineWidth(context, 2.0);
//     CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//     CGContextMoveToPoint(context, 10, 10);
//     CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400);
//     
//     CGContextStrokePath(context);
//     */
//    
//    
//    //    //绘制二次贝兹曲线
//    //    CGContextSetLineWidth(context, 2.0);
//    //    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    //    CGContextMoveToPoint(context, 10, 500);
//    //    CGContextAddQuadCurveToPoint(context, 150, 10, 400, 400);
//    //    CGContextStrokePath(context);
//    //
//    
//    
//    //绘制虚线
//    CGContextSetLineWidth(context, 7.0);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    //    //lengths的值｛10,10｝表示先绘制10个点，再跳过10个点，如此反复，
//    //    //如果把lengths值改为｛10, 20, 10｝，则表示先绘制10个点，跳过20个点，绘制10个点，跳过10个点，再绘制20个点，如此反复
//    CGFloat dashArray[] = {1,4};
//    CGContextSetLineDash(context, 0, dashArray, 2);//跳过3个再画虚线，所以刚开始有6-（3-2）=5个虚点
//    
//    
//    /*
//     *
//     画弧
//     */
//    //画弧的方法.
//    //CGContextAddArc(CGContextRef __nullable c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise);
//    // 参数说明：
//    //x:   y: 中心点的坐标
//    //radius: 半径
//    //startAngle: endAngle:
//    //clockwise: 顺时针.
//    //    CGContextAddArc(context, (Screen_Width - 200) / 2 + 100, 180, 100, -100, 600, 1);
//    //    CGContextAddArc(context, 160, 200, 100, M_PI_2,  15/180*M_PI, 0);
//    CGContextAddArc(context, (Screen_Width - 200) / 2 + 100, 180, 100, 50*(M_PI / 180), 130*(M_PI / 180), 1);
//    
//    CGContextStrokePath(context);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    
//    CGContextAddArc(context, (Screen_Width - 200) / 2 + 100, 180, 100, 160*(M_PI / 180), 130*(M_PI / 180), 1);
//    
//    CGContextStrokePath(context);
    
    
    
//    return;
    
    CAShapeLayer *dotteLine =  [CAShapeLayer layer];
    //CGMutablePathRef： 创建一个可变路径.
    CGMutablePathRef dottePath =  CGPathCreateMutable();
    dotteLine.lineWidth = 6.0f ;
    dotteLine.strokeColor = [UIColor whiteColor].CGColor;
    dotteLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(dottePath, nil, CGRectMake(50.0f,  50.0f, 200.0f, 200.0f));
    dotteLine.path = dottePath;
    NSArray *arr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1.0],[NSNumber numberWithInt:4], nil];
    dotteLine.lineDashPhase = 3.0;
    dotteLine.lineDashPattern = arr;
    CGPathRelease(dottePath);
    [self.layer addSublayer:dotteLine];
    
    
    
    
    // 关于CGMutablePathRef 的学习:
    //    1、CGPathCreateMutable 函数
    //    创建一个CGMutablePathRef 的可变路径，并返回其句柄。
    //    2、CGPathMoveToPoint 过程
    //    在路径上移动当前画笔的位置到一个点，这个点由CGPoint 类型的参数指定。
    //    3、CGPathAddLineToPoint 过程
    //    从当前的画笔位置向指定位置（同样由CGPoint类型的值指定）绘制线段
    //    4、CGContextAddPath 过程
    //    添加一个由句柄指定的路径的图形上下文，准备用于绘图
    //    5、CGContextDrawPath 过程
    //    在图形上下文中绘制给出的路径。
    //    6、CGPathRelease 过程
    //    释放为路径句柄分配的内存。
    //    7、CGPathAddRect 过程
    //    向路径添加一个矩形。矩形的边界由一个CGRect 结构体指定。
    //
    
    
    /*
     *创建一个新的可变路径（CGPathCreateMutable）,把该路径加到你的图形上下文（CGContextAddPath）
     *并把它绘制到图形上下文中（CGContextDrawPath）
     */
    
    //    CGMutablePathRef path = CGPathCreateMutable();
    //
    //    /* How big is our screen? We want the X to cover the whole screen */
    //    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //
    //    /* Start from top-left */
    //    CGPathMoveToPoint(path, NULL,screenBounds.origin.x, screenBounds.origin.y);
    //
    //    /* Draw a line from top-left to bottom-right of the screen */
    //    CGPathAddLineToPoint(path, NULL,screenBounds.size.width, screenBounds.size.height);
    //
    //    /* Start another line from top-right */
    //    CGPathMoveToPoint(path, NULL,screenBounds.size.width, screenBounds.origin.y);
    //
    //    /* Draw a line from top-right to bottom-left */
    //    CGPathAddLineToPoint(path, NULL,screenBounds.origin.x, screenBounds.size.height);
    //
    //    /* Get the context that the path has to be drawn on */
    //    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //
    //    /* Add the path to the context so we can draw it later */
    //    CGContextAddPath(currentContext, path);
    //
    //    /* Set the blue color as the stroke color */
    //    [[UIColor blueColor] setStroke];
    //    
    //    /* Draw the path with stroke color */
    //    CGContextDrawPath(currentContext, kCGPathStroke);
    //    
    //    /* Finally release the path object */
    //    CGPathRelease(path);
    
    
    
    

}
static NSInteger count = 0;

-(void)reDraw {
    
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(slicesReload) userInfo:nil repeats:YES];
    
    
}

- (void)slicesReload {
    if (count > _slicesArray.count) {
        return;
    }
    __block  CGFloat allCount;
    [_slicesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        allCount = allCount +  [obj floatValue];
        
    }];
    
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    for (int i = 0; i < _slicesArray.count; i++) {
        count ++;
        CGFloat percentage = [_slicesArray[i] floatValue] / allCount;
        CGFloat radius = _radiuds;
        CGFloat centerX = point.x;
        CGFloat centerY = point.y;
        UIColor *color =  [UIColor colorWithHue:(( i /8)%20)/20.0+0.02 saturation:( i %8+3)/10.0 brightness:91/100.0 alpha:1];
        
        
        CAShapeLayer *chartLine;
        //        if (chartLine != nil) {
        //            [chartLine removeAllAnimations];
        //        } else {
        
        chartLine = [CAShapeLayer layer];
        //        }
        chartLine.lineWidth = _radiuds;//这里设置填充线的宽度，这个参数很重要
        chartLine.lineCap = kCALineCapButt;  //设置线端点样式，这个也是非常重要的一个参数
        //        self.clipsToBounds = NO;//该属性表示如果图形绘制超过的容器的范围是否被裁掉，这里我们设置为YES ，表示要裁掉超出范围的绘制
        chartLine.strokeColor = [color CGColor];//绘制的线的颜色
        chartLine.fillColor = nil;
        
        
        CGMutablePathRef pathRef  = CGPathCreateMutable();
        endAngle = percentage * 2 * M_PI + startAngle;
        CGPathAddArc(pathRef, &CGAffineTransformIdentity, centerX, centerY, _radiuds / 2, startAngle, endAngle, NO);
        startAngle = endAngle;
        //        CGPathAddLineToPoint(pathRef, &CGAffineTransformIdentity, centerX, centerY);
        chartLine.path = pathRef;
        [self.layer addSublayer:chartLine];
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 1.1;//设置绘制动画持续的时间
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;//是否翻转绘制
        pathAnimation.fillMode = kCAFillModeBackwards;
        pathAnimation.repeatCount = 1;
        [chartLine addAnimation:pathAnimation forKey:@"strokeEnd"];
        
        chartLine.strokeEnd = 1.0f;//表示绘制到百分比多少就停止，这个我们用1表示完全绘制
        
    }

}


- (void)drawShiXinPieView {
    /**圆饼图的思路：
     每一个扇形图都添加一个layer，每一个layer添加一个动画.
     */
    
    CALayer *parentLayer = [pieView layer];
//    NSArray *slicelayers = [parentLayer sublayers];

    NSUInteger sliceCount = [_dataSource numberOfSlicesInPieView:self];
    
    double sum = 0.0;
    double values[sliceCount];
    // 求出所有数值的总和.
    for (int index = 0; index < sliceCount; index++) {
        values[index] = [_dataSource pieChart:self valueForSliceAtIndex:index];
        sum += values[index];
    }
    
    // 求出每一个部分所占的比例角度.
    double angles[sliceCount];
    for (int index = 0; index < sliceCount; index++) {
        double div;
        if (sum == 0)
            div = 0;
        else
            div = values[index] / sum;
           angles[index] = M_PI * 2 * div;
    }
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:2.0];
    
    double startToAngle = 0.0;
    double endToAngle = startToAngle;

    for (int i = 0; i < sliceCount; i++) {

        double angle = angles[i];// 每一部分的角度.
        NSLog(@"每一部分的角度是：  %f--", angle);
        endToAngle += angle;

        double startFromAngle = _startPieAngle + startToAngle;
        double endFromAngle = _startPieAngle + endToAngle;

        PieLayer *pieLayer = [PieLayer layer];
        [pieLayer setZPosition:0];
        [pieLayer setStrokeColor:NULL];
        startFromAngle = endFromAngle = _startPieAngle;

        [parentLayer addSublayer:pieLayer];
        

        pieLayer.value = values[i];
        pieLayer.percentage = (sum)?pieLayer.value/sum:0;
        
        UIColor *color = nil;
        if([_dataSource respondsToSelector:@selector(pieView:colorForSliceAtIndex:)])
        {
            color = [_dataSource pieView:self colorForSliceAtIndex:i];
            NSLog(@"===================%@", color);
        }
        
        if(!color)
        {
            color = [UIColor colorWithHue:((i/8)%20)/20.0+0.02 saturation:(i%8+3)/10.0 brightness:91/100.0 alpha:1];
        }
        
        [pieLayer setFillColor:color.CGColor];

         NSLog(@"=====///////////////==============%@", color);
        [pieLayer createArcAnimationForKey:@"startAngle"
                              fromValue:[NSNumber numberWithDouble:startFromAngle]
                                toValue:[NSNumber numberWithDouble:startToAngle+_startPieAngle]
                               Delegate:self];
        [pieLayer createArcAnimationForKey:@"endAngle"
                              fromValue:[NSNumber numberWithDouble:endFromAngle]
                                toValue:[NSNumber numberWithDouble:endToAngle+_startPieAngle]
                               Delegate:self];
        
        startToAngle = endToAngle;


    }
    

    [CATransaction commit];
    
    
}

// 当动画开始的时候自动调用.
- (void)animationDidStart:(CAAnimation *)anim {
    
    if (animationTimer == nil) {
        static float timeInterval = 1.0/60.0;
        animationTimer= [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(theTimerFired:) userInfo:nil repeats:YES];
    }
    
    [animations addObject:anim];

    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [animations removeObject:anim];
    
    if ([animations count] == 0) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
    
}

#pragma mark - Animation Delegate + Run Loop Timer
static CGPathRef CGPathCreateArc(CGPoint center, CGFloat radius, CGFloat startAngle, CGFloat endAngle)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, center.x, center.y);
    
    CGPathAddArc(path, NULL, center.x, center.y, radius, startAngle, endAngle, 0);
    CGPathCloseSubpath(path);
    
    return path;
}


- (void)theTimerFired:(NSTimer *)timer {
    
    CALayer *parentLayer = [pieView layer];
    NSArray *pieLayers = [parentLayer sublayers];
    
    [pieLayers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSNumber *presentationLayerStartAngle = [[obj presentationLayer] valueForKey:@"startAngle"];
        CGFloat interpolatedStartAngle = [presentationLayerStartAngle doubleValue];
        
        NSNumber *presentationLayerEndAngle = [[obj presentationLayer] valueForKey:@"endAngle"];
        CGFloat interpolatedEndAngle = [presentationLayerEndAngle doubleValue];
        
        CGPoint point1 = CGPointMake(_radiuds, _radiuds);
        CGPathRef path = CGPathCreateArc(point1, _radiuds, interpolatedStartAngle, interpolatedEndAngle);
        [obj setPath:path];
        CFRelease(path);
        
    }];

}


//  实心的圆饼.
- (void)drawShiPie {
    
    [self  reDraw];


    return;
     __block  CGFloat allCount;
    [_slicesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        allCount = allCount +  [obj floatValue];
        
    }];
    
    CGFloat startAngle = 0;
    CGFloat endAngle = 0;
    
    for (int i = 0; i < _slicesArray.count; i++) {
        CGFloat percentage = [_slicesArray[i] floatValue] / allCount;
        CGFloat radius = _radiuds;
        CGFloat centerX = point.x;
        CGFloat centerY = point.y;

        
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        endAngle = percentage * 2 * M_PI + startAngle;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, NULL, centerX, centerY, radius,startAngle, endAngle, 0);
        
        startAngle = endAngle;
        
        CGPathAddLineToPoint(path, NULL, centerX, centerY);
        CGPathCloseSubpath(path);
        
        CGContextSaveGState(context);
        CGContextAddPath(context, path);

        UIColor *color =  [UIColor colorWithHue:(( i /8)%20)/20.0+0.02 saturation:( i %8+3)/10.0 brightness:91/100.0 alpha:1];
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
//        CGPathRelease(path);
        
        CAShapeLayer *chartLine = [[CAShapeLayer alloc] init];
        chartLine.path = path;
        [self.layer addSublayer:chartLine];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
        pathAnimation.duration = 1.1;//设置绘制动画持续的时间
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;//是否翻转绘制
        pathAnimation.fillMode = kCAFillModeBackwards;
        pathAnimation.repeatCount = 1;
        [chartLine addAnimation:pathAnimation forKey:@"transform.translation"];
        
        chartLine.strokeEnd = 1.0f;//表示绘制到百分比多少就停止，这个我们用1表示完全绘制

        
        
        

        
    }
    
    
//    CGPoint center = CGPointMake(125, 125);
//    CGFloat radius = 100;
//    CGFloat startA = 0;
//    CGFloat endA = 0;
//    CGFloat angle = 25 / 100.0 * M_PI * 2;
//    endA = startA + angle;
//    
//    
// // 第一中绘制 扇形的 方法. UIKit
//    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
//    
//    [path addLineToPoint:center];
//    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextAddPath(ctx, path.CGPath);
//    CGContextFillPath(ctx);
//    
    
    
    
    
    
    
    
    
    
    
    
    
}



- (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

- (void)drawNSString {
    
}

@end
