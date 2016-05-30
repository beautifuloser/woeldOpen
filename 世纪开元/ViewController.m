//
//  ViewController.m
//  世纪开元
//
//  Created by ZhaoYachao on 16/2/17.
//  Copyright © 2016年 ZhaoYachao. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+CountDown.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"kevin！" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 200, 50)];
    [button2 setBackgroundColor:[UIColor greenColor]];
    [button2 setTitle:@"vicky！" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btnTouch2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    //
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger userID = [defaults integerForKey:@"userID"];
    if (userID == 0 ) {
        [defaults setObject:@"3454655" forKey:@"userID"];
    }
}
-(void)btnTouch:(UIButton *)button
{
    [button startWithTime:(NSInteger)5 title:@"完成！" countDownTitle:@"kevin" mainColor:[UIColor orangeColor] countColor:[UIColor orangeColor]];
}
-(void)btnTouch2:(UIButton *)button
{
    [button startWithTime:(NSInteger)5 title:@"完成！" countDownTitle:@"vicky" mainColor:[UIColor orangeColor] countColor:[UIColor orangeColor]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
