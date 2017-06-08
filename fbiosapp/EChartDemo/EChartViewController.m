//
//  EChartViewController.m
//  EChart
//
//  Created by Efergy China on 11/12/13.
//  Copyright (c) 2013 Scott Zhu. All rights reserved.
//

#import "EChartViewController.h"
#import "Constants.h"

@interface EChartViewController ()

@end

@implementation EChartViewController
    @synthesize nameLabel,msg,msg2,msg3;
     NSString *mm=@"/1/user/-/activities/heart/date/";NSString *mt=@"/1d/1sec/time/";NSString *sp=@"/";NSString *js=@".json";
    -(IBAction)say:(id)sender{
        [dateField resignFirstResponder];
        [msg setText:[NSString stringWithFormat:@"%@",[dateField text]]];
        [msg2 setText:[NSString stringWithFormat:@"%@",[startField text]]];
        [msg3 setText:[NSString stringWithFormat:@"%@",[endField text]]];
    }
   
    - (void)didReceiveOAuthIOResponse:(OAuthIORequest *)request{
        NSLog(@"request received");
        NSString *ms=[mm stringByAppendingString:self.msg.text];
        NSString *ms2=[ms stringByAppendingString:mt];
        NSString *ms3=[ms2 stringByAppendingString:self.msg2.text];
        NSString *ms4=[ms3 stringByAppendingString:sp];
        NSString *ms5=[ms4 stringByAppendingString:self.msg3.text];
        NSString *ms6=[ms5 stringByAppendingString:js];

        
        NSDictionary *credentials = [request getCredentials];
        NSLog(@"creds: %@", credentials);
        
        //https://api.fitbit.com/5/user/-/profile.json
        [request get:@"/1/user/-/profile.json" success:^(NSDictionary *output, NSString *body, NSHTTPURLResponse *httpResponse)
         {
             NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
             
             if([[output allKeys] count] > 0){
                 NSLog(@"output exists: %@:", output);
             } else {
                 NSLog(@"output empty");
                 NSError *error;
                 NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                 if([[dictionary allKeys] count] > 0){
                     NSLog(@"dictionary: %@", dictionary);
                     NSDictionary *user = [dictionary objectForKey:@"user"];
                     NSString *name = [user objectForKey:@"displayName"];
                     nameLabel.text = [NSString stringWithFormat:@"Accessed %@!", name];
                     //TODO if we want imag,e use SDWebImage
                     
                     
                     // image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[user objectForKey:@"avatar"]]];
                 }
             }
             
             
             
         }];
        [request get:ms6 success:^(NSDictionary *output, NSString *body, NSHTTPURLResponse *httpResponse)
         {
             NSData* data = [body dataUsingEncoding:NSUTF8StringEncoding];
             NSError *error;//int point=0;
           //  int maxvalue=0;int minvalue=888;
             NSDictionary *dictionary =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
             NSDictionary *heartintraday= [dictionary objectForKey:@"activities-heart-intraday"];
         //    NSArray *type = [heartintraday objectForKey:@"dataset"];
          /*   NSUInteger count = type.count;
             NSString *string = @"";;NSString *vstring = @"";;
             NSUInteger flag=0; NSUInteger Flag[151];NSUInteger sflag=1;NSUInteger sFlag[181];Flag[150]=count-1;sFlag[0]=0;
             NSDictionary *dict0=(NSDictionary *)type[0];
             NSString *starttime = [dict0 objectForKey:@"time"];
             NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
             [dateFormat setDateFormat:@"HH:mm:ss"];
             [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
             NSDate *startTime = [dateFormat dateFromString:starttime];
             NSDate *endTime = [NSDate dateWithTimeInterval:60*10 sinceDate:startTime];
             startTime=[NSDate dateWithTimeInterval:20 sinceDate:startTime];
             // NSLog(@"s%@",startTime);
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
                 if([end compare:startTime]==NSOrderedSame || [end compare:startTime]==NSOrderedDescending){
                     sFlag[sflag]=i;
                     //       NSLog(@"%@",end);
                     sflag=sflag+1;
                     startTime=[NSDate dateWithTimeInterval:20 sinceDate:startTime];
                     
                     
                 }
                 
                 if([end compare:endTime]==NSOrderedSame || [end compare:endTime]==NSOrderedDescending){
                     Flag[flag]=i;
                     //       NSLog(@"%@",end);
                     flag=flag+1;
                     endTime=[NSDate dateWithTimeInterval:20 sinceDate:endTime];
                     
                     
                 }
                 /*    vstring=string;
                  NSArray *array0=[vstring componentsSeparatedByString:@" "];
                  for(NSString *heartrate0 in array0){
                  int compareValue=[heartrate0 intValue];
                  //      NSLog(@"cc:%d",compareValue);
                  if(compareValue!=0)
                  minvalue=MIN(minvalue,compareValue);
                  
                  
                  
                  if(compareValue>maxvalue){
                  maxvalue=compareValue;
                  
                  }
                  if(maxvalue-minvalue>=30){
                  NSLog(@"max:%d",maxvalue);
                  NSLog(@"min:%d",minvalue);
                  }
                  
                  
                  }*/
                 
                 //      heartrate=[value intValue];
                 
                 /*        NSString *starttime =time;//NSString *endtime=
                  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                  [dateFormat setDateFormat:@"HH:mm:ss"];
                  [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
                  NSDate *startTime = [dateFormat dateFromString:starttime];
                  NSDate *endTime = [NSDate dateWithTimeInterval:60*10 sinceDate:startTime];
                  
                  NSTimeInterval seconds=[endTime timeIntervalSinceDate:startTime];
                  NSLog(@"%@",endTime);
                  NSLog(@"%lf",seconds);
                  */
          /*   }
           */
          /*   for(NSUInteger c=0;c<151;c++){
                 //     int c=0;
                 
                 for(NSUInteger j=sFlag[c];j<=Flag[c];j++){
                     //  if(j<=count){
                     NSDictionary *dictj=(NSDictionary *)type[j];
                     NSString *value = [dictj objectForKey:@"value"];
                     vstring = [vstring stringByAppendingFormat:@"%@ ",value];
                     // }
                 }
                 NSArray *array=[vstring componentsSeparatedByString:@" "];
                 for(NSString *heartrate in array){
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
                 maxvalue=0;minvalue=888;
                 
             }*/
             NSDictionary *message = @{@"notification" : heartintraday};
             
             //创建通知对象（老板登陆boss账号）
             NSNotification * notification = [NSNotification notificationWithName:@"boss" object:self userInfo:message];
             
             //向通知中心发送消息（发布消息）
             [[NSNotificationCenter defaultCenter] postNotification:notification];
    //         goalLabel.text = [NSString stringWithFormat:@"%@",string];
             
             //     NSLog(@"type: %@", type);
             //      NSLog(@"heartrate:%d",heartrate);
             //   NSLog(@"max:%d",maxvalue);
             //     NSLog(@"min:%d",minvalue);
        /*     if(point>=0){
                 NSLog(@"positive");
             }
             NSLog(@"Point:%d",point);
             //      NSLog(@"Flag:%lu",Flag[0]);
             //     NSLog(@"sFlag:%lu",sFlag[0]);
             //       NSLog(@"count:%d",count);
             
             /*         NSString *starttime =@"16:00:00";
              NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
              [dateFormat setDateFormat:@"HH:mm:ss"];
              [dateFormat setTimeZone: [NSTimeZone timeZoneWithName:@"UTC"]];
              NSDate *startTime = [dateFormat dateFromString:starttime];
              NSLog(@"%@",startTime);
              */
         }];

    }
    - (void)didFailWithOAuthIOError:(NSError *)error{
        NSLog(@"error: %@", error.localizedDescription);
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)login:(id)sender{
    OAuthIOModal *oauthioModal = [[OAuthIOModal alloc] initWithKey:OAUTH_IO_PUBLIC_KEY delegate:self];
    //    [oauthioModal showWithProvider:@"fitbit"];
    NSLog(@"login tapped");
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:@"true" forKey:@"cache"];
    [oauthioModal showWithProvider:@"fitbit" options:options];
}
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
