//
//  TTLabel.h
//  TTTestDemo
//
//  Created by Dou on 2018/5/10.
//  Copyright © 2018年 Dou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTLabel : UIView<UITextViewDelegate>

@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *underLine;

@property(nonatomic, copy)void (^underLineCallback)();

@end
