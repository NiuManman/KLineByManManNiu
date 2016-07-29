//
//  PieYuanBingView.h
//  KLineByManManNiu
//
//  Created by Apple on 16/1/8.
//  Copyright © 2016年 NiuWenMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, MMPieStyle)  {
    MMPieStyleXuXian = 0,
    MMPieStyleShiXinPieAll,
    MMPieStyleShiXinPieOneByOne,
    MMPieStyleNSString

};

@class PieYuanBingView;
// 负责展示圆饼的协议
@protocol PieYuanBingDataSource <NSObject>

@required
- (NSInteger)numberOfSlicesInPieView:(PieYuanBingView *)pieView;
- (CGFloat)pieChart:(PieYuanBingView *)pieView valueForSliceAtIndex:(NSInteger)index;
@optional

- (UIColor *)pieView:(PieYuanBingView *)pieView colorForSliceAtIndex:(NSInteger)index;

@end


// 处理事件.
@protocol PieYuanBingDelegate <NSObject>


@end

@interface PieYuanBingView : UIView

@property (nonatomic, assign) id<PieYuanBingDataSource>dataSource;
@property (nonatomic, assign) MMPieStyle pieStyle;
@property (nonatomic, assign) NSInteger slicesCount;
@property(nonatomic, assign) CGPoint pieCenter;
@property (nonatomic, strong) NSArray *slicesArray;
@property (nonatomic, assign) CGFloat radiuds; // 圆饼的半径
@property (nonatomic, assign) CGFloat startPieAngle; //开始展示的角度.


- (void)reloadData;



@end
