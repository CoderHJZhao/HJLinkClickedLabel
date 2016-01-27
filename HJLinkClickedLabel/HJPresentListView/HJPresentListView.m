//
//  HJPopListView.m
//  
//
//  Created by ZhaoHanjun on 15/12/28.
//  Copyright © 2015年 http://weibo.com/hanjunzhao All rights reserved.
//

#import "HJPresentListView.h"
#import "UIView+Extension.h"

// 程序主窗体
#define KeyWindow [UIApplication sharedApplication].windows.lastObject
#define IphoneWidth [UIScreen mainScreen].bounds.size.width
#define IphoneHeight [UIScreen mainScreen].bounds.size.height


static NSInteger const ButtonHeight = 44;
static NSInteger const CancelButtonMargin = 10;
static NSInteger const DefaultMargin = 1;
static NSInteger const TitleFont = 16;


@interface HJPresentListView ()

@property (nonatomic, strong) UIControl *coverControl;

@property (nonatomic, strong) UIView *contentView;

@end

@implementation HJPresentListView


- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ColorStyle:(HJColorStyle)colorStyle
{
    //super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, IphoneWidth, ButtonHeight * (titles.count) + CancelButtonMargin + titles.count>2?(titles.count-2):0)]
    if ([super initWithFrame:frame]) {
  
        [self createViewWithTitles:titles ColorStyle:colorStyle];
    }
    return self;
}

- (void)createViewWithTitles:(NSArray *)titles ColorStyle:(HJColorStyle)colorStyle
{
    //遮罩层
    self.coverControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, IphoneWidth, IphoneHeight)];
    [self.coverControl addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    self.coverControl.backgroundColor = [UIColor blackColor];
    self.coverControl.alpha = 0;
    [self addSubview:self.coverControl];
    
    //按钮背景View
    CGFloat buttonMargin = titles.count>2?(titles.count-2):0;
    CGFloat contentViewHeight = ButtonHeight * (titles.count) + CancelButtonMargin + buttonMargin;

    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, IphoneHeight, IphoneWidth, contentViewHeight)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        //  创建需要的毛玻璃特效类型
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        //  毛玻璃view 视图
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        //添加到要有毛玻璃特效的控件中
        effectView.frame = self.contentView.bounds;
        //设置模糊透明度
        //    effectView.alpha = .85f;
        [self.contentView addSubview:effectView];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    [self addSubview:self.contentView];
    
    //创建按钮
    for (NSInteger i=0; i != titles.count ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        if (i == 0) {
             button.frame = CGRectMake(0, self.contentView.height - ButtonHeight*(i+1), IphoneWidth, ButtonHeight);
            [button setTitleColor:[UIColor blackColor] forState:
             UIControlStateNormal];

        }
        else
        {
            button.frame = CGRectMake(0, self.contentView.height - ButtonHeight*(i+1)- CancelButtonMargin - DefaultMargin * (i-1), IphoneWidth, ButtonHeight);
            switch (colorStyle) {
                case HJNomal:
                    [button setTitleColor:[UIColor blackColor] forState:
                     UIControlStateNormal];
                    break;
                case HJOrange:
                    [button setTitleColor:[UIColor orangeColor] forState:
                     UIControlStateNormal];
                    break;
                default:
                    break;
            }

        }
       
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(roleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:TitleFont];
        [self.contentView addSubview:button];
        

    }
    
}

- (void)show
{
    [KeyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.y = IphoneHeight-self.contentView.height;
        self.coverControl.alpha = 0.4;
    }];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.y = IphoneHeight-self.contentView.height;
        self.coverControl.alpha = 0.4;
    }];
    
}

- (void)dismissView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.y = IphoneHeight;
        self.coverControl.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)roleBtnClicked:(UIButton *)btn
{
    [self dismissView];
    if ([self.delegate respondsToSelector:@selector(PresentListView:clickedButtonAtIndex:)]) {
        [self.delegate PresentListView:self clickedButtonAtIndex:btn.tag];
    }
}



@end
