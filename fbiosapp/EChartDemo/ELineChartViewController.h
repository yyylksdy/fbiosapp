//
//  ELineChartViewController.h
//  EChartDemo
//
//  Created by 朱 建慧 on 13-12-25.
//  Copyright (c) 2013年 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELineChart.h"
#import "ELineChartDataModel.h"

@interface ELineChartViewController : UIViewController<ELineChartDataSource, ELineChartDelegate>{
 IBOutlet UILabel *statusLabel;
 IBOutlet UILabel *pointLabel;
 IBOutlet UILabel *indexLabel;
 IBOutlet UIImageView *plusimage;
 IBOutlet UIImageView *removeimage;
// UIImageView* mImageView;
    
}
@property (nonatomic, retain) IBOutlet UIImageView *removeimage;
@property (nonatomic, retain) IBOutlet UIImageView *plusimage;
@property (strong, nonatomic) ELineChart *eLineChart;
@property (weak, nonatomic) IBOutlet UILabel *numberTaped;

@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UILabel *pointLabel;
@property (nonatomic, strong) IBOutlet UILabel *indexLabel;
//- (IBAction)contentModeChanged:(UISegmentedControl*)segmentedControl;
@end
