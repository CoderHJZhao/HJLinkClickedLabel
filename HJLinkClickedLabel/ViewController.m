//
//  ViewController.m
//  HJLinkClickedLabel
//
//  Created by ZhaoHanjun on 16/1/27.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import "ViewController.h"
#import "HJContentTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //需要添加点击事件的文本
    NSString *text = @"网页链接磨房网成立于2000年，哈哈哈哈哈哈，怎么样，有没有很酷哈哈哈哈";
    
    //实例化
    HJAttributeTextModel *ts = [[HJAttributeTextModel alloc] init];
    HJContentTextView *speciaView = [[HJContentTextView alloc] initWithFrame:CGRectMake(10, 20, 300, 200)];
    //赋值，这一步不可以少，specialSegments保存了查询到的结果
    speciaView.specialSegments = ts.specialSegments;
    //设置查询文本和查询的关键字
    speciaView.tv.attributedText = [ts hilightClickedText:text HightText:@"网页链接"];
    //点击事件实现
    speciaView.clickedBlock = ^()
    {
        NSLog(@"hahhah");
    };
    [self.view addSubview:speciaView];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
