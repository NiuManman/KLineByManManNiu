//
//  ChartViewSample.h
//  KLineByManManNiu
//
//  Created by Apple on 16/1/6.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MMChartStyle) {
    MMChartStyleDongLine = 0,
    MMChartStyleLine,
    MMChartStyleRect, //柱状
    MMChartStyleYuanBing, //圆饼
    MMChartStyleXuXian, //虚线
    MMChartStyleXuanHu  //弦弧
};

@interface ChartViewSample : UIView

//非均匀的
@property (nonatomic, assign) CGFloat lineWidth;//线宽.
@property (nonatomic, assign) NSInteger hangShu; //行数
@property (nonatomic, assign) NSInteger lieShu; //列数


//平均的
@property (nonatomic, assign) CGFloat widthCell; // // 横轴每格宽度
@property (nonatomic, assign) CGFloat heightCell; // // 竖轴每格宽度
@property (nonatomic, strong) NSArray *xArray; //横坐标的值
@property (nonatomic, strong) NSArray *yArray; // 纵坐标的值.
@property (nonatomic, strong) NSArray *titlesX; // x轴的标题数组.
@property (nonatomic, strong) NSArray *titlesY; //y轴的标题数组.

@property (nonatomic, assign) BOOL isDong;
@property (nonatomic, assign) MMChartStyle chartStyle; // 样式.



@end
