//
//  HJAttributeTextModel.h
//  HJLinkClickedLabel
//
//  Created by ZhaoHanjun on 16/1/27.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HJAttributeTextModel : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, strong) NSMutableArray *specialSegments;
@property (nonatomic, assign, getter=isSpecial) BOOL special;
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;


- (NSMutableAttributedString *)hilightClickedText:(NSString *)text HightText:(NSString *)hightText;
@end
