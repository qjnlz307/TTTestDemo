//
//  ViewController.m
//  TTTestDemo
//
//  Created by Dou on 2018/5/10.
//  Copyright © 2018年 Dou. All rights reserved.
//

#import "ViewController.h"
#import "TTLabel.h"
#import "TTFeedbackViewController.h"

#define TT_WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()

@property(nonatomic, copy)NSString *content;
@property(nonatomic, copy)NSString *replacedContent;
@property(nonatomic, copy)NSString *replaceContent;

@property(nonatomic, strong)UILabel *label;
@property(nonatomic, strong)UIButton *button;
@property(nonatomic, strong)TTLabel *underLineLabel;

@end

@implementation ViewController

#pragma mark - Init
- (void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
  
    [self setupData];//初始化数据
    [self setupUI];//初始化视图
}

- (void)setupData{
    self.content = @"欢迎使用探探，在使用过程中有疑问请<a href=\"tantanapp://feedback\">反馈</a>";;
    self.replacedContent = @"<a href=\"tantanapp://feedback\">反馈</a>";
    self.replaceContent = @"反馈";
}

- (void)setupUI{
    [self.view addSubview:self.label];
    [self.view addSubview:self.button];
    [self.view addSubview:self.underLineLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.underLineLabel.content = [self convertContent:self.content];
    self.underLineLabel.underLine = self.replaceContent;
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - Action

/*
 转化标签内容
 注意:这里只是简单的实现了需求，其实可以用正则表达式更安全的替换标签内的数据
 */
- (NSString*)convertContent:(NSString*)string{
    if (!string) {
        return nil;
    }
    
    NSString *result = [string stringByReplacingOccurrencesOfString:self.replacedContent withString:self.replaceContent];
    return result;
}

- (void)convertAction:(id)sender{
    self.underLineLabel.hidden = NO;
}

#pragma mark - Get & Set

- (TTLabel*)underLineLabel{
    if (!_underLineLabel) {
        _underLineLabel = [[TTLabel alloc] init];
        _underLineLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _underLineLabel.backgroundColor = [UIColor lightGrayColor];
        _underLineLabel.hidden = YES;
        TT_WS(ws);
        _underLineLabel.underLineCallback = ^(){
            [ws feedbackAction];
        };
    }
    return _underLineLabel;
}

- (void)feedbackAction{
    TTFeedbackViewController *feedback = [TTFeedbackViewController new];
    [self.navigationController pushViewController:feedback animated:YES];
}

- (UILabel*)label{
    if (!_label) {
        _label = [UILabel new];
        _label.translatesAutoresizingMaskIntoConstraints = NO;
        _label.text = self.content;
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:15.0];
    }
    return _label;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"点这转换" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(convertAction:) forControlEvents:UIControlEventTouchUpInside];
        [_button setExclusiveTouch:YES];
        _button.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _button;
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
    
    [NSLayoutConstraint constraintWithItem:self.label
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.label
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                  constant:100.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.label
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    
    
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1.0
                                  constant:0.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeCenterX
                                multiplier:1.0
                                  constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:100.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.button
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:40.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.underLineLabel
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                  constant:10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.underLineLabel
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.button
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:100.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.underLineLabel
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.view
                                 attribute:NSLayoutAttributeRight
                                multiplier:1.0
                                  constant:-10.0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.underLineLabel
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:100.0].active = YES;
}

@end




