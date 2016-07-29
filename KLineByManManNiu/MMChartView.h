//
//  MMChartView.h
//  KLineByManManNiu
//
//  Created by Apple on 15/12/31.
//  Copyright © 2015年 NiuWenMan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MMChartStyle)  {
    MMChartStyleLine = 0,
    MMChartStyleBar
    
};




@interface MMChartView : UIView


@property (nonatomic) MMChartStyle chartStyle;






@end
