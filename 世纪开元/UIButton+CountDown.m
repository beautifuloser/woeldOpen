//
//  UIButton+CountDown.m
//  倒计时
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 syx. All rights reserved.
//

#import "UIButton+CountDown.h"
#import <AFHTTPRequestOperationManager.h>
@implementation UIButton (CountDown)


- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
   
    __block NSInteger timeOut = timeLine; // 倒计时时间
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setInteger:@3543170 forKey:@"userID"];
//    [defaults setObject:@"3543320" forKey:@"userID"];
    __block NSInteger userID = [defaults integerForKey:@"userID"];
    
//    __block NSInteger userID = 
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    dispatch_source_set_event_handler(_timer, ^{
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                });
        }else{
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
            NSInteger randomNo = [self getRandomNumber];
            userID = userID - randomNo;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:[NSString stringWithFormat:@"%ld",userID] forKey:@"userID"];
            NSLog(@"%ld",(long)userID);
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"attention"] = @"1";
            if ([subTitle isEqualToString:@"vicky"]) {
                params[@"shareId"] = @"8922568";
                NSLog(@"vicky");
            }else{
                params[@"shareId"] = @"8920614";
                NSLog(@"kevin");
            }
            //8922568、3669125
            NSString *string = [NSString stringWithFormat:@"%ld",(long)userID];
            params[@"userId"] = string;
            //3578527芳姐
            //8920614我
            //3669125 dora
            //8922568 vicky
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager POST:@"http://www.36588.com.cn/wx/assist_friend.do" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                NSLog(@"成功！");
            } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
                NSLog(@"失败！");
            }];
        }
    });
    dispatch_resume(_timer);
}



-(NSInteger) getRandomNumber
{
    int x = arc4random() % 10;
    NSLog(@"xxxxxx%d",x);
    return x;
}








@end
