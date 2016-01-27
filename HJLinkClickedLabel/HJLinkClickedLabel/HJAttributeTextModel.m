//
//  HJAttributeTextModel.m
//  HJLinkClickedLabel
//
//  Created by ZhaoHanjun on 16/1/27.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import "HJAttributeTextModel.h"

@implementation HJAttributeTextModel

- (NSMutableArray *)specialSegments
{
    if (!_specialSegments) {
        _specialSegments  = [[NSMutableArray alloc] init];
        
    }
    return _specialSegments;
    
}

- (NSMutableAttributedString *)hilightClickedText:(NSString *)text HightText:(NSString *)hightText;
{
    [self.specialSegments removeAllObjects];
    NSMutableArray *parts = [NSMutableArray array];
    if ([text rangeOfString:hightText].location != NSNotFound) {
        HJAttributeTextModel *seg = [[HJAttributeTextModel alloc] init];
        seg.text = hightText;
        seg.range = [text rangeOfString:hightText];
        seg.special = YES;
        [parts addObject:seg];
    }
    
    
    
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, text.length)];
    NSInteger cnt = parts.count;
    for (NSInteger i=0; i<cnt; i++) {
        HJAttributeTextModel *ts = parts[i];
        if (ts.special) {
            [attributeText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:ts.range];
            //生成富文本中的图片
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            attch.image = [UIImage imageNamed:@"share"];
            attch.bounds = CGRectMake(0, 0, 20, 20);
            NSAttributedString *emotionStr = [NSAttributedString attributedStringWithAttachment:attch];
            //插入图片
            [attributeText insertAttributedString:emotionStr atIndex:ts.range.location];
            HJAttributeTextModel *spec = [[HJAttributeTextModel alloc] init];
            spec.text = ts.text;
            NSInteger loc = ts.range.location;
            NSInteger len = ts.text.length + 1;
            spec.range = NSMakeRange(loc, len);
            [self.specialSegments addObject:spec];
            
        }
    }
    return attributeText;
}

@end
