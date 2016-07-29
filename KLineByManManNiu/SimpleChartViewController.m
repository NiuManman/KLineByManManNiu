//
//  SimpleChartViewController.m
//  KLineByManManNiu
//
//  Created by Apple on 16/1/6.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import "SimpleChartViewController.h"
#import "ChartViewSample.h"
#import "ZheXianViewController.h"

@interface SimpleChartViewController ()
{
    UIImageView *imageView;
    ChartViewSample *chartView;
}

@end

@implementation SimpleChartViewController
@synthesize hangShu, lieShu;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    
    //1.绘制表格.........
    [self drawNSString];

   
    
    //2.折线图.
     chartView = [[ChartViewSample alloc] initWithFrame:CGRectMake(0, Screen_Height - 300, Screen_Width, 350)];
    [chartView setLieShu:24];
    [chartView setHeightCell:40];
    [chartView setHangShu:5];
    [chartView setWidthCell:15];
    [chartView setLineWidth:0.5];
    [chartView setTitlesX:@[@"00:00", @"06:00", @"12:00", @"18:00", @"24:00"]];
    [chartView setTitlesY:@[@"100", @"80", @"60", @"40", @"20", @"0"]];
//    [chartView setXArray:@[@"22",@"54",@"15",@"30",@"42",@"77"]];
    [chartView setYArray:@[@"76",@"84",@"14",@"93",@"56", @"50", @"44", @"0", @"88",@"76",@"84",@"14",@"93",@"56", @"12", @"44", @"0", @"88",@"76",@"84",@"14",@"93",@"80", @"12", @"66"]];
    [chartView setChartStyle:MMChartStyleDongLine];
    [self.view addSubview:chartView];
    
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(120, Screen_Height - 40, Screen_Width - 240, 40);
    [button setTitle:@"简单折线（直线）图" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(zheXianTuAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, Screen_Height - 40, 50, 40);
    [button1 setTitle:@"动画" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor lightGrayColor];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(dongHuaAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button1];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(70, Screen_Height - 40, 50, 40);
    [button2 setTitle:@"直观" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor lightGrayColor];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(zhiGuanAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];

    
    
}


- (void)zheXianTuAction:(UIButton *)sender {
    ZheXianViewController *zheXinVC = [[ZheXianViewController alloc] init];
    [self.navigationController pushViewController:zheXinVC animated:YES];
    
}

- (void)dongHuaAction: (UIButton *)sender {
    [chartView setIsDong:YES];
}

- (void)zhiGuanAction:(UIButton *)sender {
    [chartView setChartStyle:MMChartStyleLine];
}

//绘制表格。。。。。。。
- (void)drawNSString {
    
//划横线的第一种方法：
    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(10,100)];
//    [path addLineToPoint:CGPointMake(300, 100)];
//    [path closePath];
//    shapeLayer.path = path.CGPath;
//    shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
//    shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
//    shapeLayer.lineWidth = 1;
//    [self.view.layer addSublayer:shapeLayer];

    
    //划线
//    CAShapeLayer *_chartLine = [CAShapeLayer layer];
//    _chartLine.lineCap = kCALineCapRound; // 线的顶端类型： 圆角， 直的；
//    _chartLine.lineJoin = kCALineJoinBevel;
//    _chartLine.fillColor   = [[UIColor whiteColor] CGColor];
//    _chartLine.lineWidth   = 10.0;
//    _chartLine.strokeEnd   = 0.0;
//    _chartLine.strokeColor = [UIColor greenColor].CGColor;
//    [self.view.layer addSublayer:_chartLine];
//    
//   //绘制路径
//    UIBezierPath *progressline = [UIBezierPath bezierPath];
//    [progressline moveToPoint:CGPointMake(10,100)];
//    [progressline setLineWidth:10.0];
//
//    [progressline setLineCapStyle:kCGLineCapRound];
//    [progressline setLineJoinStyle:kCGLineJoinRound];
//    [progressline addLineToPoint:CGPointMake(300, 400)];
//    [progressline stroke];
//    
//    _chartLine.path = progressline.CGPath;
//    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 4;
//    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    pathAnimation.autoreverses = NO;
////    pathAnimation.repeatCount = 100; // 重复次数.
//    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
//    _chartLine.strokeEnd = 1.0; //停止.
//    
    

    
    
    
//    return;
    //第二种：
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height - 64)];
    [self.view addSubview:imageView];
    
//    UIGraphicsBeginImageContext(imageView.frame.size);//和
    UIGraphicsBeginImageContextWithOptions(imageView.frame.size, NO, 1.0);
    [[UIColor whiteColor] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(), imageView.bounds);
    [[UIColor blackColor] set];
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 1.0);
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor yellowColor].CGColor);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
 
    // 标题
    NSString *piti = @"满满的小屋";
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:30]};
    CGSize size = [piti boundingRectWithSize:CGSizeMake(320, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    CGContextSetRGBFillColor (UIGraphicsGetCurrentContext(), 0.5, 0.5, 0.5, 0.5);

    [piti drawInRect:CGRectMake((Screen_Width - size.width) / 2, 0, 200, 50) withAttributes:attribute];
    
    
    //副标题
    NSString *title1 = @"满满的正能量";
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
    CGSize size1 = [title1 boundingRectWithSize:CGSizeMake(320, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute1 context:nil].size;
    [title1 drawInRect:CGRectMake((Screen_Width - size1.width) / 2, 60, 200, 40) withAttributes:attribute1];

    
    // 绘制表格： 五行  六列.
    // 表格第一个点的位置：
    int x = 10, y = 100;
    int h = 50; // 每行表格的高度
    //列的坐标点：
    int  x1 =  100, x2 = 160, x3 = 230, x4 = 310, x5 = Screen_Width - 10;
 
    //第几条 按坐标由上到下 由左到右 依次递增
    //第一条横线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y);
    
    //第二条横线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y + h);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y + h);
    
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y + 2 * h);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y +2 * h);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y +3 * h);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y +3 * h);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y + 4 *h);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y + 4 *h);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y + 5 *h);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5,  y + 5 *h);
    
    
    // 设置每一项标题的字体以及属性字典.
    CGFloat fontTitle = 14;
    NSDictionary *attributeTitle = @{NSFontAttributeName: [UIFont systemFontOfSize:fontTitle]};
    
    NSString *stringName = @"姓名";
    [stringName drawInRect: [self getRectWithX1:x X2:x1 Y1:y Y2:y + h String:stringName withFont:fontTitle] withAttributes:attributeTitle];

    stringName = @"年龄";
    [stringName drawInRect:[self getRectWithX1: x1 X2:x2 Y1:y Y2:y + h String:stringName withFont:fontTitle] withAttributes:attributeTitle];
    
    stringName = @"性别";
    [stringName drawInRect:[self getRectWithX1:x2 X2:x3 Y1:y Y2:y + h String:stringName withFont:fontTitle] withAttributes:attributeTitle];
    stringName = @"质量";
    [stringName drawInRect:[self getRectWithX1:x3 X2:x4 Y1:y Y2:y + h String:stringName withFont:fontTitle] withAttributes:attributeTitle];

    stringName = @"类别";
    [stringName drawInRect:[self getRectWithX1:x4 X2:x5 Y1:y Y2:y + h String:stringName withFont:fontTitle] withAttributes:attributeTitle];

    
    
    
    //第一条竖线
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x, y + h * 5);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x1, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x1, y + h * 5);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x2, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x2, y + h * 5);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x3, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x3, y + h * 5);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x4, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x4, y + h * 5);
    
   //
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), x5, y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), x5, y + h * 5);
    
    
    CGContextStrokePath(UIGraphicsGetCurrentContext()); // 绘制
    imageView.image = UIGraphicsGetImageFromCurrentImageContext(); // 绘制结果就是类似一张图片
    UIGraphicsEndImageContext();//结束绘制.
    
    
    
}

- (CGSize)getSizeWithString:(NSString *)str withFont:(CGFloat)font  {
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:font]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(320, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size;
}


- (CGRect)getRectWithX1:(CGFloat)x1 X2:(CGFloat)x2 Y1:(CGFloat)y1 Y2:(CGFloat)y2 String:(NSString *)str withFont:(CGFloat)font  {
    
    CGSize size = [self getSizeWithString:str withFont:font];
    
    CGFloat x = (x2 - x1 - size.width) / 2 + x1;
    CGFloat y = (y2 - y1 - size.height) / 2 + y1;
    return CGRectMake(x, y, size.width, size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
