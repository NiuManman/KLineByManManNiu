//
//  YuanBingViewController.m
//  KLineByManManNiu
//
//  Created by Apple on 16/1/8.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import "YuanBingViewController.h"
#import "ChartViewSample.h"
#import "PieYuanBingView.h"
#import "ShiPieViewController.h"

@interface YuanBingViewController ()
{
    ChartViewSample *chartView;
    PieYuanBingView *pieView1;
    PieYuanBingView *pieView2;
    UIImageView *imgView;

}

@end

@implementation YuanBingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:55 / 255.0 green:55 / 255.0 blue:55 / 255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"圆饼图";
    
    UIBarButtonItem *iten = [[UIBarButtonItem alloc] initWithTitle:@"实心圆饼图" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = iten;

    pieView1 = [[PieYuanBingView alloc] initWithFrame:CGRectMake(0, 50, Screen_Width, 250)];
    [pieView1 setPieStyle:MMPieStyleXuXian];
    [self.view addSubview:pieView1];
    
    
    pieView2 = [[PieYuanBingView alloc] initWithFrame:CGRectMake(0, Screen_Height - 400, Screen_Width, 300)];
//    [self.view addSubview:pieView2];
    
    
    [self addPaths];
    
    [self addViews];

}

- (void)rightItemAction:(UIBarButtonItem *)sender {
    ShiPieViewController *simnpleVC = [[ShiPieViewController alloc] init];
    [self.navigationController pushViewController:simnpleVC animated:YES];
    
}



- (void)addPaths {
    //创建CGContextRef
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    
    
    //=== 绘画逻辑 ===
    
    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(50, 450);
    
    //创建CGMutablePathRef
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // CGContextAddArc 参数含义是一样的。 NO: 顺时针， YES: 逆时针.
//    CGPathAddArc(path, &transform, 50, 50, 50, 0, 1.5 * M_PI, NO);
    
    CGPathAddRelativeArc(path, &transform, 10, 20, 30,  0, 1/ 4 * (M_PI / 180));
    
//    CGPathMoveToPoint(path, &transform, 50, 0);
//    
//    CGPathAddLineToPoint(path, &transform, 50, 50);
//    
//    CGPathAddLineToPoint(path, &transform, 100, 50);
    
    
    
    //将CGMutablePathRef添加到当前Context内
    
    CGContextAddPath(gc, path);
    
    [[UIColor grayColor] setFill];
    
    [[UIColor blueColor] setStroke];
    
    CGContextSetLineWidth(gc, 2);
    
    //执行绘画
    
    CGContextDrawPath(gc, kCGPathFillStroke);
    
    
    
    //从Context中获取图像，并显示在界面上
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    imgView = [[UIImageView alloc] initWithImage:img];
    
    [self.view addSubview:imgView];

}

- (void)addViews {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(120, Screen_Height - 40, Screen_Width - 240, 40);
    [button setTitle:@"旋转 缩放 移动" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(xuanZhuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}


- (void)xuanZhuanAction:(UIButton *)sender {
    
    // 旋转
//     imgView.transform = CGAffineTransformRotate(imgView.transform, M_PI_4);
    
    // 缩放
//       imgView.transform = CGAffineTransformScale(imgView.transform, 0.9, 0.9);
    
    // 移动  每次向下移动 10 .  上：负的. 左边：负的
      imgView.transform = CGAffineTransformTranslate(imgView.transform, -20, 10);
    
    
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
