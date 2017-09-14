//
//  UITextView+ZWLimitCounter.m
//  BYDingGu
//
//  Created by 王子武 on 2017/5/26.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import "UITextView+ZWLimitCounter.h"
#import <objc/runtime.h>
static char limitCountKey;
static char labMarginKey;
static char labHeightKey;
@implementation UITextView (ZWLimitCounter)
+ (void)load {
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(zwlimitCounter_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(zwlimitCounter_swizzled_dealloc)));
}
#pragma mark - swizzled
- (void)zwlimitCounter_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    @try {
        [self removeObserver:self forKeyPath:@"layer.borderWidth"];
        [self removeObserver:self forKeyPath:@"text"];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    [self zwlimitCounter_swizzled_dealloc];
}
- (void)zwlimitCounter_swizzling_layoutSubviews {
    [self zwlimitCounter_swizzling_layoutSubviews];
    if (self.zw_limitCount) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        textContainerInset.bottom = self.zw_labHeight;
        self.contentInset = textContainerInset;
        CGFloat x = CGRectGetMinX(self.frame)+self.layer.borderWidth;
        CGFloat y = CGRectGetMaxY(self.frame)-self.contentInset.bottom-self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds)-self.layer.borderWidth*2;
        CGFloat height = self.zw_labHeight;
        self.zw_inputLimitLabel.frame = CGRectMake(x, y, width, height);
        if ([self.superview.subviews containsObject:self.zw_inputLimitLabel]) {
            return;
        }
        [self.superview insertSubview:self.zw_inputLimitLabel aboveSubview:self];
    }
}
#pragma mark - associated
-(NSInteger)zw_limitCount{
    return [objc_getAssociatedObject(self, &limitCountKey) integerValue];
}
- (void)setZw_limitCount:(NSInteger)zw_limitCount{
    objc_setAssociatedObject(self, &limitCountKey, @(zw_limitCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}
-(CGFloat)zw_labMargin{
    return [objc_getAssociatedObject(self, &labMarginKey) floatValue];
}
-(void)setZw_labMargin:(CGFloat)zw_labMargin{
    objc_setAssociatedObject(self, &labMarginKey, @(zw_labMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}
-(CGFloat)zw_labHeight{
    return [objc_getAssociatedObject(self, &labHeightKey) floatValue];
}
-(void)setZw_labHeight:(CGFloat)zw_labHeight{
    objc_setAssociatedObject(self, &labHeightKey, @(zw_labHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateLimitCount];
}
#pragma mark -config
- (void)configTextView{
    self.zw_labHeight = 20;
    self.zw_labMargin = 10;
}
#pragma mark - update
- (void)updateLimitCount{
    if (self.text.length > self.zw_limitCount) {
        UITextRange *markedRange = [self markedTextRange];
        if (markedRange) {
            return;
        }
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:self.zw_limitCount];
        self.text = [self.text substringToIndex:range.location];
    }
    NSString *showText = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,(long)self.zw_limitCount];
    self.zw_inputLimitLabel.text = showText;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString
                                              alloc] initWithString:showText];
    NSUInteger length = [showText length];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -self.zw_labMargin; //设置与尾部的距离
    style.alignment = NSTextAlignmentRight;//靠右显示
    [attrString addAttribute:NSParagraphStyleAttributeName value:style
                       range:NSMakeRange(0, length)];
    self.zw_inputLimitLabel.attributedText = attrString;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"layer.borderWidth"]||
        [keyPath isEqualToString:@"text"]) {
        [self updateLimitCount];
    }
}
#pragma mark - lazzing
-(UILabel *)zw_inputLimitLabel{
    UILabel *label = objc_getAssociatedObject(self, @selector(zw_inputLimitLabel));
    if (!label) {
        label = [[UILabel alloc] init];
        label.backgroundColor = self.backgroundColor;
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentRight;
        objc_setAssociatedObject(self, @selector(zw_inputLimitLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLimitCount)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        [self addObserver:self forKeyPath:@"layer.borderWidth" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self configTextView];
    }
    return label;
}
@end
