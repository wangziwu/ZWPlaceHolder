//
//  UITextView+ZWPlaceHolder.h
//  ZWPlaceHolderDemo
//
//  Created by 王子武 on 2017/6/6.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZWPlaceHolder)
/** placeHolder*/
@property (nonatomic, copy) NSString *zw_placeHolder;
/** placeHolderColor*/
@property (nonatomic, strong) UIColor *zw_placeHolderColor;
/** placeHolderLabel*/
@property (nonatomic, readonly) UILabel *zw_placeHolderLabel;
@end
