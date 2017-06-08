//
//  ELineChartViewController.m
//  EChartDemo
//
//  Created by 朱 建慧 on 13-12-25.
//  Copyright (c) 2013年 Scott Zhu. All rights reserved.
//

#import "ELineChartViewController.h"
#include <stdlib.h>

@interface ELineChartViewController ()
@property (strong, nonatomic) NSArray *eLineChartData;

@property (nonatomic) float eLineChartScale;
@end
static NSDictionary *bossInfo=nil;
@implementation ELineChartViewController

@synthesize eLineChart = _eLineChart;
@synthesize eLineChartData = _eLineChartData;
@synthesize numberTaped = _numberTaped;
@synthesize eLineChartScale = _eLineChartScale;
@synthesize statusLabel,pointLabel,indexLabel,plusimage,removeimage;

- (instancetype)init
    {
        self = [super init];
        if (self) {
            //现在通知中心注册，确定要接受谁的消息，（登陆论坛，关注老板）
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"boss" object:nil];
        }
        return self;
    }
    
-(void)doSomething:(NSNotification *)notification
    {
        
        //接受消息，（从论坛上看到啦boss的消息）
        bossInfo = [notification userInfo];
        //输出收到的信息
        //   NSLog(@"人力资源部门收到：%@", bossInfo[@"notification"]);
        //  PCChartViewController * fs = [[PCChartViewController alloc] init];
        
    }
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *type = [bossInfo[@"notification"] objectForKey:@"dataset"];
    NSUInteger count = type.count;
    NSString *string = @"";;NSString *vstring = @"";;NSString *endstring = @"";;NSString *mendstring = @"";;NSString *mvstring = @"";;NSString *mstartstring= @"";;NSString *avgtimestring=@"";;NSString *startstring =@"";;

    int point=0;double index=0.0;
    double maxvalue=0.0;double  minvalue=888.0; double mx=0.0;double mn=0.0;
 //   NSUInteger flag=0; NSUInteger Flag[151];NSUInteger sflag=1;NSUInteger sFlag[181];Flag[150]=count-1;sFlag[0]=0;
    NSDictionary *dict0=(NSDictionary *)type[0];
    NSString *starttime = [dict0 objectForKey:@"time"];
    //NSString *mstartstring=starttime;
   //  NSString *startstring = starttime;;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm:ss"];
    [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
    NSDate *startTime = [dateFormat dateFromString:starttime];
    NSDate *mstartTime=startTime;
    
    NSDate *mendTime = [NSDate dateWithTimeInterval:10 sinceDate:mstartTime];
    startTime=[NSDate dateWithTimeInterval:5 sinceDate:mstartTime];
    NSDate *endTime = [NSDate dateWithTimeInterval:60*10 sinceDate:startTime];
//    startTime=[NSDate dateWithTimeInterval:30 sinceDate:startTime];

  //    NSLog(@"type：%@", type);
 /*   for(int i=0;i<count;i++){
        NSDictionary *dict=(NSDictionary *)type[i];
        NSString *value = [dict objectForKey:@"value"];
        NSString *time = [dict objectForKey:@"time"];
        //       string = [string stringByAppendingFormat:@"%@ ",time];
        
        
        
        
        string = [string stringByAppendingFormat:@"%@ ",value];
        
        vstring = [vstring stringByAppendingFormat:@"%@ ",time];
    }*/
    
    _eLineChartScale = 1;
    
    /** Generate data for _eLineChart*/
	NSMutableArray *tempArray = [NSMutableArray array];
 /*   for (int i = 0 ; i < 300; i++)
    {
        int number = arc4random() % 100;
        ELineChartDataModel *eLineChartDataModel = [[ELineChartDataModel alloc] initWithLabel:[NSString stringWithFormat:@"%d", i] value:number index:i unit:@"kWh"];
        [tempArray addObject:eLineChartDataModel];
    }*/
    ///new
    for(int i=0;i<count;i++){
        NSDictionary *dict=(NSDictionary *)type[i];
    //    NSString *value = [dict objectForKey:@"value"];
        NSString *time0 = [dict objectForKey:@"time"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm:ss"];
        [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *end = [dateFormat dateFromString:time0];
        
        if([end compare:mstartTime]==NSOrderedSame || [end compare:mstartTime]==NSOrderedDescending){
            //     sFlag[sflag]=i;
            //       NSLog(@"%@",end);
            //      sflag=sflag+1;
            //      NSNumber*average=[ma valueForKeyPath:@"@avg.self"];
            //      NSLog(@"average:%@",average);
            //    [ma removeAllObjects];
            //   NSString *averagestring=[average stringValue];
            // meanstring = [meanstring stringByAppendingFormat:@"%@ ",averagestring];
            mstartstring = [mstartstring stringByAppendingFormat:@"%@ ",time0];
            mstartTime=[NSDate dateWithTimeInterval:10 sinceDate:mstartTime];
            
            
        }
        if([end compare:mendTime]==NSOrderedSame || [end compare:mendTime]==NSOrderedDescending){
            //     Flag[flag]=i;
            //       NSLog(@"%@",end);
            //      flag=flag+1;
            mendstring = [mendstring stringByAppendingFormat:@"%@ ",time0];
            mendTime=[NSDate dateWithTimeInterval:10 sinceDate:endTime];
            
            
        }

        
    }
    starttime = [dict0 objectForKey:@"time"];
  
    startTime = [dateFormat dateFromString:starttime];
    mstartTime=startTime;
    mendTime = [NSDate dateWithTimeInterval:10 sinceDate:mstartTime];
    NSArray *mstartarray=[mstartstring componentsSeparatedByString:@" "];
    NSArray *mendarray=[mendstring componentsSeparatedByString:@" "];
    NSUInteger mstartcount=mstartarray.count;
    NSUInteger mendcount=mendarray.count;
    NSUInteger mflag=0; NSUInteger mFlag[mendcount];NSUInteger msflag=0;NSUInteger msFlag[mstartcount];mFlag[mendcount-1]=count-1;msFlag[0]=0;
    NSLog(@"%lu",(unsigned long)mstartcount);
    NSLog(@"%lu",(unsigned long)mendcount);
    for(int i=0;i<count;i++){
        NSDictionary *dict=(NSDictionary *)type[i];
        NSString *value = [dict objectForKey:@"value"];
        NSString *time = [dict objectForKey:@"time"];
        //       string = [string stringByAppendingFormat:@"%@ ",time];
        
        
        
        
        string = [string stringByAppendingFormat:@"%@ ",value];
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm:ss"];
        [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *end = [dateFormat dateFromString:time];
        //  NSTimeInterval seconds=[end timeIntervalSinceDate:endTime];
        if([end compare:mstartTime]==NSOrderedSame || [end compare:mstartTime]==NSOrderedDescending){
            msFlag[msflag]=i;
            //       NSLog(@"%@",end);
            msflag=msflag+1;
            mstartTime=[NSDate dateWithTimeInterval:10 sinceDate:mstartTime];
            
            
        }
        
        if([end compare:mendTime]==NSOrderedSame || [end compare:mendTime]==NSOrderedDescending){
            mFlag[mflag]=i;
            //       NSLog(@"%@",end);
            mflag=mflag+1;
            mendTime=[NSDate dateWithTimeInterval:10 sinceDate:mendTime];
            
            
        }
    }
    NSMutableArray *averages = [[NSMutableArray alloc] initWithCapacity:0];
  for(NSUInteger c=0;c<MIN(mendcount,mstartcount);c++){
        //     int c=0;
  //    NSLog(@"mFlag:%lu",mFlag[c]);
    //  NSLog(@"msFlag:%lu",msFlag[c]);
      
      if(mFlag[c]<count){
                  for(NSUInteger j=msFlag[c];j<=mFlag[c];j++){
            //  if(j<=count){
            NSDictionary *dictj=(NSDictionary *)type[j];
            NSString *value = [dictj objectForKey:@"value"];
            mvstring = [mvstring stringByAppendingFormat:@"%@ ",value];
            // }
        }
        NSArray *array=[mvstring componentsSeparatedByString:@" "];
        int total=0;
        for(NSString *heartrate in array){
            int compareValue=[heartrate intValue];
            //      NSLog(@"cc:%d",compareValue);
            
            if(compareValue!=0)
            {
                total=total+compareValue;
            }
    /*            minvalue=MIN(minvalue,compareValue);
            
            
            
            if(compareValue>maxvalue){
                maxvalue=compareValue;
                
            }*/
            //   NSLog(@"max:%d",maxvalue);NSLog(@"min:%d",minvalue);
            
      }
        double average=(double)total/(mFlag[c]-msFlag[c]+1);
      //     NSMutableArray *averages;
        //  [averages addObject:average];
          
          [averages addObject:[NSNumber numberWithDouble:average]];
               //    NSLog(@"average:%f",average);
   /*     if(maxvalue-minvalue>=30){
            //NSLog(@"positive");
            point=point+1;
            NSLog(@"max:%d",maxvalue);NSLog(@"min:%d",minvalue);
            NSLog(@"Flag:%lu",Flag[c]);
            NSLog(@"sFlag:%lu",sFlag[c]);
            
        }*/
        
        mvstring = @"";;
 //       maxvalue=0;minvalue=888;
      }
      
    }
  //  NSLog(@"averages:%@",averages[1]);
    NSUInteger avgcount=[averages count];
    NSLog(@"averagecount:%lu",(unsigned long)avgcount);
    NSDate *avgtime=[NSDate dateWithTimeInterval:5 sinceDate:startTime];
   // NSLog(@"avgtime:%@",avgtime);
    for(int i=0;i<avgcount;i++){
        NSString *timestring=[[NSString alloc]initWithString:[dateFormat stringFromDate:avgtime]];
        avgtimestring= [avgtimestring stringByAppendingFormat:@"%@ ",timestring];
        avgtime=[NSDate dateWithTimeInterval:10 sinceDate:avgtime];
    }
    NSLog(@"avgtimestring:%@",avgtimestring);
NSArray *avgtimearray=[avgtimestring componentsSeparatedByString:@" "];
    NSLog(@"avgtimearraycount:%lu",[avgtimearray count]);
    
     NSLog(@"avgendtime:%@",avgtimearray[[avgtimearray count]-2 ]);
    ///new
    for(int i=0;i<avgcount;i++){
        //   NSDictionary *dict=(NSDictionary *)type[i];
        //    NSString *value = [dict objectForKey:@"value"];
        //     NSString *time0 = [dict objectForKey:@"time"];
        //       string = [string stringByAppendingFormat:@"%@ ",time];
        
        
        
        
        //   string = [string stringByAppendingFormat:@"%@ ",value];
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm:ss"];
        [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *end = [dateFormat dateFromString:avgtimearray[i]];
        //  NSTimeInterval seconds=[end timeIntervalSinceDate:endTime];
        if([end compare:startTime]==NSOrderedSame || [end compare:startTime]==NSOrderedDescending){
            //     sFlag[sflag]=i;
            //       NSLog(@"%@",end);
            //      sflag=sflag+1;
            startstring = [startstring stringByAppendingFormat:@"%@ ",avgtimearray[i]];
            
            startTime=[NSDate dateWithTimeInterval:30 sinceDate:startTime];
            
            
        }
        
        if([end compare:endTime]==NSOrderedSame || [end compare:endTime]==NSOrderedDescending){
            //     Flag[flag]=i;
            //       NSLog(@"%@",end);
            //      flag=flag+1;
            endstring = [endstring stringByAppendingFormat:@"%@ ",avgtimearray[i]];
            endTime=[NSDate dateWithTimeInterval:30 sinceDate:endTime];
            
            
        }
        
    }
    
    //    NSLog(@"sss%@",startstring);
    //  NSLog(@"eeeee%@",endstring);
    //    NSDictionary *dict0=(NSDictionary *)type[0];
    starttime = [dict0 objectForKey:@"time"];
    //   NSString *startstring = starttime;;//NSString *endstring = starttime;;
    //     NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   [dateFormat setDateFormat:@"HH:mm:ss"];
    // [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
    startTime = [dateFormat dateFromString:starttime];
    startTime=[NSDate dateWithTimeInterval:5 sinceDate:startTime];
    endTime = [NSDate dateWithTimeInterval:60*10 sinceDate:startTime];
    
  //  startTime=[NSDate dateWithTimeInterval:30 sinceDate:startTime];
    NSArray *startarray=[startstring componentsSeparatedByString:@" "];
    NSArray *endarray=[endstring componentsSeparatedByString:@" "];
    NSUInteger startcount=startarray.count;
    NSUInteger endcount=endarray.count;
    NSLog(@"%lu",(unsigned long)startcount);
    NSLog(@"%lu",(unsigned long)endcount);
    NSUInteger flag=0; NSUInteger Flag[endcount];NSUInteger sflag=0;NSUInteger sFlag[startcount];Flag[endcount-1]=avgcount-1;sFlag[0]=0;

    for(int i=0;i<avgcount;i++){
        //    NSDictionary *dict=(NSDictionary *)type[i];
        //  NSString *value = [dict objectForKey:@"value"];
        //NSString *time = [dict objectForKey:@"time"];
        //       string = [string stringByAppendingFormat:@"%@ ",time];
        
        
       //  NSLog(@"avgcount%lu",(unsigned long)avgcount);
        
        //  string = [string stringByAppendingFormat:@"%@ ",averages[i]];
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm:ss"];
        [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
        NSDate *end = [dateFormat dateFromString:avgtimearray[i]];
     //   NSLog(@"endtime%@",end);
        //  NSTimeInterval seconds=[end timeIntervalSinceDate:endTime];
        if([end compare:startTime]==NSOrderedSame || [end compare:startTime]==NSOrderedDescending){
            sFlag[sflag]=i;
            //       NSLog(@"%@",end);
            sflag=sflag+1;
            startTime=[NSDate dateWithTimeInterval:30 sinceDate:startTime];
            
            
        }
        
        if([end compare:endTime]==NSOrderedSame || [end compare:endTime]==NSOrderedDescending){
            Flag[flag]=i;
            //       NSLog(@"%@",end);
            flag=flag+1;
            endTime=[NSDate dateWithTimeInterval:30 sinceDate:endTime];
            
            
        }
        
    }
  //  NSLog(@"%lu",(unsigned long)sFlag[0]);
   // NSLog(@"%lu",(unsigned long)Flag[0]);
    NSMutableArray *varray=[[NSMutableArray alloc]init];
  //  NSLog(@"Flag:%lu",Flag[3]);
 //   NSLog(@"sFlag:%lu",sFlag[3]);
    for(NSUInteger c=0;c<MIN(endcount,startcount);c++){
 
             for(NSUInteger j=sFlag[c];j<Flag[c];j++){
         //  if(j<=count){
         //     NSDictionary *dictj=(NSDictionary *)type[j];
         NSString *value = [averages[j] stringValue];
      //   NSLog(@"value%@",value);
         
         //      vstring = [vstring stringByAppendingFormat:@"%@ ",value];
         [varray addObject:value];
      //   NSString *test=[varray objectAtIndex:j];
        // NSLog(@"test%@", test);
                 
             }//
        for(NSString *heartrate in varray){
            double compareValue=[heartrate doubleValue];
            //               NSLog(@"cc:%f",compareValue);
            if(compareValue!=0)
                minvalue=MIN(minvalue,compareValue);
            
            
            
            if(compareValue>maxvalue){
                maxvalue=compareValue;
                
            }
         //      NSLog(@"max:%f",maxvalue);NSLog(@"min:%f",minvalue);
            
        }
       

        if(maxvalue-minvalue>=30){
      //      NSLog(@"positive");
            if(maxvalue!=mx){
            point=point+1;
    //        NSLog(@"point:%d",point)
                
            NSLog(@"max:%f",maxvalue);
            NSLog(@"min:%f",minvalue);
            NSLog(@"Flag:%lu",Flag[c]);
            NSLog(@"sFlag:%lu",sFlag[c]);
           }
            
        }
        
    

        [varray removeAllObjects];
       mx=maxvalue;mn=minvalue;
        maxvalue=0.0;minvalue=888.0;

   //   }
   /*     for(NSString *heartrate in varray){
            int compareValue=[heartrate intValue];
            //      NSLog(@"cc:%d",compareValue);
            if(compareValue!=0)
            minvalue=MIN(minvalue,compareValue);
            
            
            
            if(compareValue>maxvalue){
                maxvalue=compareValue;
                
            }
            //   NSLog(@"max:%d",maxvalue);NSLog(@"min:%d",minvalue);
            
        }
        if(maxvalue-minvalue>=30){
            //NSLog(@"positive");
            point=point+1;
            NSLog(@"max:%d",maxvalue);NSLog(@"min:%d",minvalue);
            NSLog(@"Flag:%lu",Flag[c]);
            NSLog(@"sFlag:%lu",sFlag[c]);
            
        }
        
        vstring = @"";;
        maxvalue=0;minvalue=888;*/
        
    }
       //         goalLabel.text = [NSString stringWithFormat:@"%@",string];
    
    //     NSLog(@"type: %@", type);
    //      NSLog(@"heartrate:%d",heartrate);
    //   NSLog(@"max:%d",maxvalue);
    //     NSLog(@"min:%d",minvalue);
    index=(double)100*point/avgcount;
     NSLog(@"index:%f",index);
    if(index<3.0){
      //  NSLog(@"positive");
        self.plusimage.hidden=YES;
        self.removeimage.hidden=NO;
        statusLabel.text = [NSString stringWithFormat:@"Negative"];
        indexLabel.text = [NSString stringWithFormat:@"Index: %.1f(<3.0)",index];
    }
    if(index>=3.0){
        statusLabel.text = [NSString stringWithFormat:@"Positive"];
        indexLabel.text = [NSString stringWithFormat:@"Index: %.1f(>3.0)",index];

    }
    
  
    pointLabel.text = [NSString stringWithFormat:@"Score: %d",point];
    
//    for (int i = 0 ; i < avgcount; i++)
    for (int i = 0 ; i < avgcount; i++)
    { // NSDictionary *dict=(NSDictionary *)type[i];
        //NSString *value = [dict objectForKey:@"value"];
        //NSString *time = [dict objectForKey:@"time"];
        double number=[averages[i] doubleValue];
   //     int number = arc4random() % 100;
        ELineChartDataModel *eLineChartDataModel = [[ELineChartDataModel alloc] initWithLabel:[NSString stringWithFormat:@"%d", i] value:number index:i unit:@"kWh"];
        [tempArray addObject:eLineChartDataModel];
    }
    _eLineChartData = [NSArray arrayWithArray:tempArray];
    
    /** The Actual frame for the line is half height of the frame you specified, because the bottom half is for the touch control, but it's empty */
    //_eLineChart = [[ELineChart alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 400)];
    _eLineChart = [[ELineChart alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 300)];
    //[_eLineChart setELineIndexStartFromRight: YES];
	[_eLineChart setDelegate:self];
    [_eLineChart setDataSource:self];
    [self.view addSubview:_eLineChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -mark- ELineChart DataSource
- (NSInteger) numberOfPointsInELineChart:(ELineChart *) eLineChart
{
    return [_eLineChartData count];
}

- (NSInteger) numberOfPointsPresentedEveryTime:(ELineChart *) eLineChart
{
//    NSInteger num = 20 * (1.0 / _eLineChartScale);
//    NSLog(@"%d", num);
    return [_eLineChartData count];
}

- (ELineChartDataModel *)     highestValueELineChart:(ELineChart *) eLineChart
{
    ELineChartDataModel *maxDataModel = nil;
    float maxValue = -FLT_MIN;
    for (ELineChartDataModel *dataModel in _eLineChartData)
    {
        if (dataModel.value > maxValue)
        {
            maxValue = dataModel.value;
            maxDataModel = dataModel;
        }
    }
    return maxDataModel;
}

- (ELineChartDataModel *)     eLineChart:(ELineChart *) eLineChart
                             valueForIndex:(NSInteger)index
{
    if (index >= [_eLineChartData count] || index < 0) return nil;
    return [_eLineChartData objectAtIndex:index];
}

#pragma -mark- ELineChart Delegate

- (void)eLineChartDidReachTheEnd:(ELineChart *)eLineChart
{
    NSLog(@"Did reach the end");
}

- (void)eLineChart:(ELineChart *)eLineChart
     didTapAtPoint:(ELineChartDataModel *)eLineChartDataModel
{
    NSLog(@"%ld %f", (long)eLineChartDataModel.index, eLineChartDataModel.value);
    [_numberTaped setText:[NSString stringWithFormat:@"%.f", eLineChartDataModel.value]];
    
}

- (void)    eLineChart:(ELineChart *)eLineChart
 didHoldAndMoveToPoint:(ELineChartDataModel *)eLineChartDataModel
{
    [_numberTaped setText:[NSString stringWithFormat:@"%.f", eLineChartDataModel.value]];
}

- (void)fingerDidLeaveELineChart:(ELineChart *)eLineChart
{
    
}

- (void)eLineChart:(ELineChart *)eLineChart
    didZoomToScale:(float)scale
{
   _eLineChartScale = scale;
   
    [_eLineChart removeFromSuperview];
    _eLineChart = nil;
    _eLineChart = [[ELineChart alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 300)];
	[_eLineChart setDelegate:self];
    [_eLineChart setDataSource:self];
    [self.view addSubview:_eLineChart];
}

#pragma -mark- Actions

- (IBAction)chartDirectionChanged:(id)sender
{
    UISwitch *mySwith = (UISwitch *)sender;
    if ([mySwith isOn])
    {
        [_eLineChart removeFromSuperview];
        _eLineChart = nil;
        _eLineChart = [[ELineChart alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 300)];
        [_eLineChart setELineIndexStartFromRight:YES];
        [_eLineChart setDelegate:self];
        [_eLineChart setDataSource:self];
        [self.view addSubview:_eLineChart];
    }
    else
    {
        [_eLineChart removeFromSuperview];
        _eLineChart = nil;
        _eLineChart = [[ELineChart alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 300)];
        [_eLineChart setDelegate:self];
        [_eLineChart setDataSource:self];
        [self.view addSubview:_eLineChart];
    }
}

@end
