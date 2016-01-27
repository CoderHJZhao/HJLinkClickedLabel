//
//  HJContentTextView.h
//  HJLinkClickedLabel
//
//  Created by ZhaoHanjun on 16/1/27.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJAttributeTextModel.h"
typedef void(^ClickedBlock)(void);
@interface HJContentTextView : UIView

@property (nonatomic, strong) NSArray *specialSegments;
@property (nonatomic, weak) UITextView *tv;
@property (nonatomic, copy) ClickedBlock clickedBlock;

@end
