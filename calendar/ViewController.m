//
//  ViewController.m
//  calendar
//
//  Created by qiulibi on 16/5/4.
//  Copyright © 2016年 qiulibi. All rights reserved.
//

#import "ViewController.h"
#import "VCCalendarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    VCCalendarView *calendarView = [[VCCalendarView alloc] initWithDateFrame:CGRectMake(0, 30, applicationWidth, 320)];
    [self.view addSubview:calendarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
