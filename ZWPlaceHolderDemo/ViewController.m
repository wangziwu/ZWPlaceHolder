//
//  ViewController.m
//  ZWPlaceHolderDemo
//
//  Created by 王子武 on 2017/6/6.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+ZWPlaceHolder.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *firstTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.firstTextView.zw_placeHolder = @"向厂家反馈同业相关活动、产品信息、用于市场分析。";
//    self.firstTextView.layer.borderWidth = 1;
//    self.firstTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 300, [UIScreen mainScreen].bounds.size.width, 80)];
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.zw_placeHolder = @"向厂家反馈同业相关活动、产品信息、用于市场分析。向厂家反馈同业相关活动、产品信息、用于市场分析。向厂家反馈同业相关活动、产品信息、用于市场分析。向厂家反馈同业相关活动、产品信息、用于市场分析。向厂家反馈同业相关活动、产品信息、用于市场分析。";
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
