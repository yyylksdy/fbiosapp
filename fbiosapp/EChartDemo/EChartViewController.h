//
//  EChartViewController.h
//  EChart
//
//  Created by Efergy China on 11/12/13.
//  Copyright (c) 2013 Scott Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OAUthiOS/OAuthiOS.h>
@interface EChartViewController : UIViewController<OAuthIODelegate>{
    IBOutlet UILabel *nameLabel;
    IBOutlet UITextField *dateField;
    IBOutlet UITextField *startField;
    IBOutlet UITextField *endField;
    IBOutlet UILabel *msg;
    IBOutlet UILabel *msg2;
    IBOutlet UILabel *msg3;

}

    @property (nonatomic, strong) IBOutlet UILabel *nameLabel;
    @property (nonatomic, strong) IBOutlet UILabel *msg;
    @property (nonatomic, strong) IBOutlet UILabel *msg2;
    @property (nonatomic, strong) IBOutlet UILabel *msg3;
-(IBAction)login:(id)sender;
-(IBAction)say:(id)sender;
@end
