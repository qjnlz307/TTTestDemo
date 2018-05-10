//
//  TTLabel.m
//  TTTestDemo
//
//  Created by Dou on 2018/5/10.
//  Copyright © 2018年 Dou. All rights reserved.
//

#import "TTLabel.h"

@interface TTLabel()

@property(nonatomic, strong)UITextView *textView;


@end

@implementation TTLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.textView];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [NSLayoutConstraint constraintWithItem:self.textView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.textView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.textView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.textView
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:0.0].active = YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{

     if ([[URL scheme] isEqualToString:@"click"]) {
         if (self.underLineCallback) {
             self.underLineCallback();
         }
        return NO;
    }
    return YES;
}

- (void)setContent:(NSString *)content{
    _content = content;
    [self setNeedsUpdateConstraints];
}

- (void)setUnderLine:(NSString *)underLine{
    _underLine = underLine;
    
    NSRange range = [self.content rangeOfString:_underLine];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.content];
    [attStr addAttribute:NSLinkAttributeName value:@"click://" range:NSMakeRange(range.location, range.length)];
    self.textView.attributedText = attStr;
    self.textView.linkTextAttributes = @{NSForegroundColorAttributeName: [UIColor blueColor],
                                         NSUnderlineStyleAttributeName: [NSNumber numberWithInt:NSUnderlineStyleSingle]};
    
    [self setNeedsUpdateConstraints];
}

- (UITextView*)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.delegate = self;
        _textView.editable = NO;
        _textView.scrollEnabled = NO;
        _textView.allowsEditingTextAttributes = YES;
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textView;
}



@end
