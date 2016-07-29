//
//  ZheXianViewController.m
//  KLineByManManNiu
//
//  Created by Apple on 16/1/6.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import "ZheXianViewController.h"
#import "ChartViewSample.h"
#import "YuanBingViewController.h"


@interface ZheXianViewController ()
{
    ChartViewSample *chartView;
    
}

@end

@implementation ZheXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"简单折线图";
    self.view.backgroundColor = [UIColor whiteColor];

    
    chartView = [[ChartViewSample alloc] initWithFrame:CGRectMake(0, 70, Screen_Width, 300)];
    [chartView setLieShu:24];
    [chartView setHeightCell:40];
    [chartView setHangShu:5];
    [chartView setWidthCell:15];
    [chartView setLineWidth:0.5];
    [chartView setTitlesX:@[@"00:00", @"06:00", @"12:00", @"18:00", @"24:00"]];
    [chartView setTitlesY:@[@"100", @"80", @"60", @"40", @"20", @"0"]];
    //    [chartView setXArray:@[@"22",@"54",@"15",@"30",@"42",@"77"]];
    [chartView setYArray:@[@"76",@"84",@"14",@"93",@"56", @"50", @"44", @"0"]];
    [chartView setChartStyle:MMChartStyleRect];
    [self.view addSubview:chartView];
    
    
    chartView = [[ChartViewSample alloc] initWithFrame:CGRectMake(0, Screen_Height - 300, Screen_Width, 300)];
    [chartView setLieShu:24];
    [chartView setHeightCell:40];
    [chartView setHangShu:5];
    [chartView setWidthCell:15];
    [chartView setLineWidth:0.5];
    [chartView setTitlesX:@[@"00:00", @"06:00", @"12:00", @"18:00", @"24:00"]];
    [chartView setTitlesY:@[@"100", @"80", @"60", @"40", @"20", @"0"]];
    //    [chartView setXArray:@[@"22",@"54",@"15",@"30",@"42",@"77"]];
    [chartView setYArray:@[@"76",@"84",@"14",@"93",@"56", @"50", @"44", @"0", @"88",@"76",@"84",@"14",@"93",@"56", @"12", @"44", @"0", @"88",@"76",@"84",@"14",@"93",@"80", @"12", @"66"]];
    [chartView setChartStyle:MMChartStyleLine];
    
    [self.view addSubview:chartView];

    
    UIBarButtonItem *iten = [[UIBarButtonItem alloc] initWithTitle:@"简单表格" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = iten;
    

}


- (void)rightItemAction:(UIBarButtonItem *)sender {
    
    YuanBingViewController *simnpleVC = [[YuanBingViewController alloc] init];
    [self.navigationController pushViewController:simnpleVC animated:YES];
    
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
