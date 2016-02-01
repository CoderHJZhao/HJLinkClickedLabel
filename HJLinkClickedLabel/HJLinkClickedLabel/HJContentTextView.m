//
//  HJContentTextView.m
//  HJLinkClickedLabel
//
//  Created by ZhaoHanjun on 16/1/27.
//  Copyright © 2016年 https://github.com/CoderHJZhao. All rights reserved.
//

#import "HJContentTextView.h"

static const NSInteger coverTag = 11;
@implementation HJContentTextView

- (instancetype) initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        UITextView *tv = [[UITextView alloc] init];
        tv.textContainerInset = UIEdgeInsetsZero;
        tv.textContainer.lineFragmentPadding = 0;
        tv.editable = NO;
        tv.scrollEnabled = NO;
        tv.userInteractionEnabled = NO;
        tv.backgroundColor = [UIColor clearColor];
        [self addSubview:tv];
        _tv = tv;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tv.frame = self.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    BOOL selected = NO;
    for (HJAttributeTextModel *spec in self.specialSegments) {
        self.tv.selectedRange = spec.range;
        NSArray *rects = [self.tv selectionRectsForRange:self.tv.selectedTextRange];
        self.tv.selectedRange = NSMakeRange(0, 0);
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            if (CGRectContainsPoint(rect, pt)) {
                selected = YES;
                break;
            }
        }
        if (selected) {
            //点击事件处理
            self.clickedBlock();
            
            for (UITextSelectionRect *selectionRect in rects) {
                //                self.clickedBlock();
                CGRect rect = selectionRect.rect;
                if(rect.size.width == 0 || rect.size.height == 0) continue;
                UIView *cover = [[UIView alloc] initWithFrame:rect];
                cover.layer.cornerRadius = 5;
                cover.layer.shouldRasterize = YES;
                cover.backgroundColor = [UIColor blueColor];
                cover.alpha = 0.3;
                cover.tag = coverTag;
                [self.tv insertSubview:cover atIndex:0];
                
            }
            break;
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *view in self.tv.subviews) {
            if (view.tag == coverTag) {
                [view removeFromSuperview];
                
                
            }
        }
    });
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.tv.subviews) {
        if (view.tag == 110) {
            [view removeFromSuperview];
            
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self clickInside:point withEvent:event]) {
        return [super hitTest:point withEvent:event];
        
    }
    else
    {
        return nil;
    }
}



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [self clickInside:point withEvent:event];
}

- (BOOL)clickInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (HJAttributeTextModel *spec in self.specialSegments) {
        self.tv.selectedRange = spec.range;
        NSArray *rects = [self.tv selectionRectsForRange:self.tv.selectedTextRange];
        self.tv.selectedRange = NSMakeRange(0, 0);
        for (UITextSelectionRect *selectionRect in rects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) continue;
            if (CGRectContainsPoint(rect, point)) {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    return NO;
}

@end
