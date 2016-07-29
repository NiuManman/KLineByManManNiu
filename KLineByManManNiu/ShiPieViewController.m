//
//  ShiPieViewController.m
//  KLineByManManNiu
//
//  Created by Apple on 16/1/11.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import "ShiPieViewController.h"
#import "PieYuanBingView.h"

@interface ShiPieViewController ()<PieYuanBingDataSource>
{
    PieYuanBingView *pieView1;
    PieYuanBingView *pieView2;
    NSArray *sliceArray;

}

@end

@implementation ShiPieViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    sliceArray = @[@"69", @"15", @"32", @"88", @"50"];
    pieView1 = [[PieYuanBingView alloc] initWithFrame:CGRectMake(0, 50, Screen_Width, 250)];
    [pieView1 setPieStyle:MMPieStyleShiXinPieAll];
    [pieView1 setSlicesArray:@[@"10", @"20", @"30", @"40"]];
    [pieView1 setRadiuds:100.0f];
    [self.view addSubview:pieView1];

    
    
    
    pieView2 = [[PieYuanBingView alloc] initWithFrame:CGRectMake(0, 320, Screen_Width, 350)];
    [pieView2 setRadiuds:150.0f]; // 先设置半径.
    [pieView2 setPieStyle:MMPieStyleShiXinPieOneByOne];
    [pieView2 setSlicesArray:sliceArray];
    pieView2.dataSource = self;
    [pieView2 setStartPieAngle:0.5 * M_PI_2];  // 开始的角度.

    [self.view addSubview:pieView2];

    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];

}

#pragma mark ===== PieViewDataSource
- (NSInteger)numberOfSlicesInPieView:(PieYuanBingView *)pieView {
    return sliceArray.count;
}

 //显示每一部分的值.
- (CGFloat)pieChart:(PieYuanBingView *)pieView valueForSliceAtIndex:(NSInteger)index {
    NSLog(@"============%d", [[sliceArray objectAtIndex:index] intValue]);
    return [[sliceArray objectAtIndex:index] intValue];

}

- (UIColor *)pieView:(PieYuanBingView *)pieView colorForSliceAtIndex:(NSInteger)index {
    
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];

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
