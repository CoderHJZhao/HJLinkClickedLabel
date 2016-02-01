//
//  ViewController.m
//  HJLinkClickedLabel
//
//  Created by ZhaoHanjun on 16/1/27.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import "ViewController.h"
#import "HJContentTextView.h"
#import "HJPresentListView.h"

// 程序主窗体
#define KeyWindow [UIApplication sharedApplication].keyWindow

@interface ViewController () <HJPresentListViewDelegate>
@property (nonatomic, strong) HJPresentListView *presentView;
@property (nonatomic, strong) HJAttributeTextModel *attributeTextmodel;
@end

@implementation ViewController

- (HJPresentListView *)presentView
{
    if (!_presentView) {
        NSArray *titlesArr = @[@"取消",@"用Safari打开"];
        _presentView = [[HJPresentListView alloc] initWithFrame:KeyWindow.bounds Titles:titlesArr ColorStyle:HJOrange];
        _presentView.delegate = self;
    }
    return _presentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //需要添加点击事件的文本
    NSMutableString *text = [[NSMutableString alloc] initWithString:@"磨房网成立于2000年，http://www.baidu.com哈哈哈哈哈哈，怎么样，有没有很酷哈哈哈哈"];
    //实例化
    _attributeTextmodel = [[HJAttributeTextModel alloc] init];
    HJContentTextView *speciaView = [[HJContentTextView alloc] initWithFrame:CGRectMake(10, 20, 300, 200)];
    //赋值，这一步不可以少，specialSegments保存了查询到的结果
    speciaView.specialSegments = _attributeTextmodel.specialSegments;
    //设置查询文本和查询的关键字
    speciaView.tv.attributedText = [_attributeTextmodel hilightClickedText:text HightText:@"网页链接"];
    //点击事件实现
    speciaView.clickedBlock = ^()
    {
        [self.presentView show];
    };
    [self.view addSubview:speciaView];

}

#pragma mark presentListViewDelegate

- (void)PresentListView:(HJPresentListView *)presentListView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            //_attributeTextmodel.linkUrl为跳转链接
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_attributeTextmodel.linkUrl]];
        }
            break;
            
        default:
            break;
    }
}


@end
