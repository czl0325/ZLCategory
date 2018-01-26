//
//  ViewController.m
//  ZLCategory
//
//  Created by qipai on 2018/1/26.
//  Copyright © 2018年 czl. All rights reserved.
//

#import "ViewController.h"
#import "ZLCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"转化时间1-----%@",formatStringToDate(@"2017-01-01"));
    NSLog(@"转化时间2-----%@",formatDateToStringALL([NSDate date]));
    
    UIView* view = [UIView new];
    view.left = 100;
    view.top = 100;
    view.width = 100;
    view.height = 100;
    view.backgroundColor = [UIColor colorWithHexString:@"0xf0f0f0"];
    [self.view addSubview:view];
    
    UILabel* label = [UILabel new];
    label.left = view.left + 10;
    label.top = view.bottom + 20;
    label.width = view.width - 20;
    label.height = 20;
    label.backgroundColor = [UIColor colorWithRed:123 green:123 blue:123];
    label.textColor = [UIColor orangeColor];
    label.text = @"11111";
    [self.view addSubview:label];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
