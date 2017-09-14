//
//  UITextView+ZWPlaceHolder.h
//  ZWPlaceHolderDemo
//
//  Created by 王子武 on 2017/6/6.
//  Copyright © 2017年 wang_ziwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ZWPlaceHolder)
/** 
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *zw_placeHolder;
/** 
 *  IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示
 */
@property (nonatomic, copy) NSString *placeholder;
/** 
 *  placeHolder颜色
 */
@property (nonatomic, strong) UIColor *zw_placeHolderColor;

@end
