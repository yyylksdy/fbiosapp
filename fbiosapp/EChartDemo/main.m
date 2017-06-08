//
//  main.m
//  EChart
//
//  Created by Efergy China on 11/12/13.
//  Copyright (c) 2013 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EChartViewController.h"
#import "EChartAppDelegate.h"
#import "ELineChartViewController.h"
int main(int argc, char * argv[])
{
    EChartViewController * boss = [[EChartViewController alloc] init];
    ELineChartViewController * finance = [[ELineChartViewController alloc] init];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([EChartAppDelegate class]));
    }
}
