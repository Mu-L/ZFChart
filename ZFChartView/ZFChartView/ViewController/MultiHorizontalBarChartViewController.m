//
//  MultiHorizontalBarChartViewController.m
//  ZFChartView
//
//  Created by apple on 16/6/1.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "MultiHorizontalBarChartViewController.h"
#import "ZFChart.h"

@interface MultiHorizontalBarChartViewController ()<ZFGenericChartDataSource, ZFHorizontalBarChartDelegate>

@property (nonatomic, strong) ZFHorizontalBarChart * barChart;

@property (nonatomic, assign) CGFloat height;

@end

@implementation MultiHorizontalBarChartViewController

- (void)setUp{
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.5;
        
    }else{
        //首次进入控制器为竖屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
    self.barChart = [[ZFHorizontalBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _height)];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.topicLabel.text = @"xx小学各年级男女人数";
    self.barChart.unit = @"人";
    self.barChart.topicLabel.textColor = ZFPurple;
//    self.barChart.isShadow = NO;
    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
//    self.barChart.isResetAxisLineMinValue = YES;
    self.barChart.isShowXLineSeparate = YES;
    self.barChart.isShowYLineSeparate = YES;
//    self.barChart.backgroundColor = ZFPurple;
//    self.barChart.unitColor = ZFWhite;
//    self.barChart.xAxisColor = ZFWhite;
//    self.barChart.yAxisColor = ZFWhite;
//    self.barChart.axisLineNameColor = ZFWhite;
//    self.barChart.axisLineValueColor = ZFWhite;
//    self.barChart.isShowAxisLineValue = NO;
    self.barChart.separateLineStyle = kLineStyleDashLine;
//    self.barChart.separateLineDashPhase = 0.f;
//    self.barChart.separateLineDashPattern = @[@(5), @(5)];
    
    self.barChart.isAnimated = NO;
    [self.view addSubview:self.barChart];
    [self.barChart strokePath];
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@[@"123", @"500", @"490", @"380", @"167", @"235"],
             @[@"256", @"283", @"236", @"240", @"183", @"200"],
             @[@"256", @"256", @"256", @"256", @"256", @"256"]];
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    return @[@"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级"];
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFBlue, ZFGold, ZFOrange];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 500;
}

//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return -150;
//}

//- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
//    return 10;
//}

//- (void)genericChartDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"当前偏移量 ------ %f", scrollView.contentOffset.y);
//}

#pragma mark - ZFHorizontalBarChartDelegate

//- (CGFloat)barHeightInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 60.f;
//}

//- (CGFloat)paddingForGroupsInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 20.f;
//}

//- (CGFloat)paddingForBarInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return 5.f;
//}

- (id)valueTextColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    return ZFBlue;
    return @[ZFBlue, ZFGold, ZFOrange];
}

//- (NSArray<ZFGradientAttribute *> *)gradientColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
//    //该组第1个bar渐变色
//    ZFGradientAttribute * gradientAttribute1 = [[ZFGradientAttribute alloc] init];
//    gradientAttribute1.colors = @[(id)ZFBlue.CGColor, (id)ZFWhite.CGColor];
//    gradientAttribute1.locations = @[@(0.5), @(0.99)];
//    gradientAttribute1.startPoint = CGPointMake(0, 0);
//    gradientAttribute1.endPoint = CGPointMake(0.5, 0.5);
//    
//    //该组第2个bar渐变色
//    ZFGradientAttribute * gradientAttribute2 = [[ZFGradientAttribute alloc] init];
//    gradientAttribute2.colors = @[(id)ZFGold.CGColor, (id)ZFWhite.CGColor];
//    gradientAttribute2.locations = @[@(0.5), @(0.99)];
//    gradientAttribute2.startPoint = CGPointMake(0, 0);
//    gradientAttribute2.endPoint = CGPointMake(0.5, 0.5);
//    
//    //该组第3个bar渐变色
//    ZFGradientAttribute * gradientAttribute3 = [[ZFGradientAttribute alloc] init];
//    gradientAttribute3.colors = @[(id)ZFOrange.CGColor, (id)ZFWhite.CGColor];
//    gradientAttribute3.locations = @[@(0.5), @(0.99)];
//    gradientAttribute3.startPoint = CGPointMake(0, 0);
//    gradientAttribute3.endPoint = CGPointMake(0.5, 0.5);
//    
//    return [NSArray arrayWithObjects:gradientAttribute1, gradientAttribute2, gradientAttribute3, nil];
//}

- (void)horizontalBarChart:(ZFHorizontalBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex horizontalBar:(ZFHorizontalBar *)horizontalBar popoverLabel:(ZFPopoverLabel *)popoverLabel{
    //特殊说明，因传入数据是3个subArray(代表3个类型)，每个subArray存的是6个元素(代表每个类型存了1~6年级的数据),所以这里的groupIndex是第几个subArray(类型)
    //eg：三年级第0个元素为 groupIndex为0，barIndex为2
    NSLog(@"第%ld个颜色中的第%ld个",(long)groupIndex,(long)barIndex);
    
    //可在此处进行bar被点击后的自身部分属性设置
//    horizontalBar.barColor = ZFYellow;
//    horizontalBar.isAnimated = YES;
//    horizontalBar.opacity = 0.5;
//    [horizontalBar strokePath];
    
    //可将isShowAxisLineValue设置为NO，然后执行下句代码进行点击才显示数值
//    popoverLabel.hidden = NO;
}

- (void)horizontalBarChart:(ZFHorizontalBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    //理由同上
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)labelIndex);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
//    popoverLabel.textColor = ZFSkyBlue;
//    [popoverLabel strokePath];
}

#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator NS_AVAILABLE_IOS(8_0){
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
}

@end
