//
//  MGActionSheet.m
//  MGActionSheet
//
//  Created by Luqiang on 2017/1/22.
//  Copyright © 2017年 Mango. All rights reserved.
//

#import "MGActionSheet.h"

@interface MGActionSheet ()

@property (nonatomic, strong) UIView *sheetView;
@property (nonatomic, assign) CGFloat sheetHeight;
@property (nonatomic, strong) UIView *sheetBackgroundView;

@property (nonatomic, strong) UITapGestureRecognizer *backgroundTap;
@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;

@end

@implementation MGActionSheet

- (instancetype)initWithSheetView:(UIView *)sheetView sheetHeight:(CGFloat)sheetHeight {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.sheetView = sheetView;
        self.sheetHeight = sheetHeight;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.sheetBackgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        self.sheetView.translatesAutoresizingMaskIntoConstraints = NO;
        [self setupAction];
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupAction {
    [self addGestureRecognizer:self.backgroundTap];
}

- (void)setupUI {
    self.backgroundColor = [self blackColorWithAlpha:0.0];
    [self.sheetBackgroundView addSubview:self.sheetView];
    [self addSubview:self.sheetBackgroundView];
}

- (void)setupLayout {
    [self layoutContentView];
}

- (void)show {
    __weak typeof(self) weakSelf = self;
    if (!self.superview) {
        [self layoutActionSheet];
    }
    [UIView animateWithDuration:MGActionSheet_Alert_Duration animations:^{
        weakSelf.backgroundColor = [weakSelf blackColorWithAlpha:0.2];
        weakSelf.bottomConstraint.constant = 0;
        [weakSelf layoutIfNeeded];
    }];
}

- (void)hide {
    [self dismissWithComplete:nil];
}

- (void)dismissWithComplete:(void(^)())complete {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:MGActionSheet_Alert_Duration animations:^{
        weakSelf.backgroundColor = [weakSelf blackColorWithAlpha:0.0];
        weakSelf.bottomConstraint.constant = weakSelf.sheetHeight;
        [weakSelf layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
        if (finished) {
            [weakSelf removeFromSuperview];
        }
    }];
}

#pragma mark - Getter And Setter
- (UITapGestureRecognizer *)backgroundTap {
    if (!_backgroundTap) {
        _backgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapAction:)];
    }
    return _backgroundTap;
}

- (UIView *)sheetBackgroundView {
    if (!_sheetBackgroundView) {
        _sheetBackgroundView = [UIView new];
        _sheetBackgroundView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *interceptTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(interceptTapAction:)];
        [_sheetBackgroundView addGestureRecognizer:interceptTap];
    }
    return _sheetBackgroundView;
}

#pragma mark - Action
- (void)backgroundTapAction:(UITapGestureRecognizer *)tap {
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self hide];
    }
}

- (void)interceptTapAction:(UITapGestureRecognizer *)tap {
    
}

#pragma mark - Private Method
- (UIColor *)blackColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithWhite:0 alpha:alpha];
}

- (void)layoutContentView {
    NSLayoutConstraint *sheetLeft = [NSLayoutConstraint constraintWithItem:self.sheetView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.sheetBackgroundView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *sheetRight = [NSLayoutConstraint constraintWithItem:self.sheetView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.sheetBackgroundView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *sheetBottom = [NSLayoutConstraint constraintWithItem:self.sheetView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.sheetBackgroundView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    NSLayoutConstraint *sheetTop = [NSLayoutConstraint constraintWithItem:self.sheetView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.sheetBackgroundView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.sheetBackgroundView addConstraints:@[sheetLeft,sheetRight,sheetTop,sheetBottom]];
    
    NSLayoutConstraint *sheetBackgroundLeft = [NSLayoutConstraint constraintWithItem:self.sheetBackgroundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *sheetBackgroundRight = [NSLayoutConstraint constraintWithItem:self.sheetBackgroundView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    _bottomConstraint = [NSLayoutConstraint constraintWithItem:self.sheetBackgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:_sheetHeight];
    [self addConstraints:@[sheetBackgroundLeft,sheetBackgroundRight,_bottomConstraint]];
    NSLayoutConstraint *sheetBackgroundHeight = [NSLayoutConstraint constraintWithItem:self.sheetBackgroundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:_sheetHeight];
    [self.sheetBackgroundView addConstraint:sheetBackgroundHeight];
}

- (void)layoutActionSheet {
    UIView * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [window addConstraints:@[left,right,top,bottom]];
    [self layoutIfNeeded];
}

@end






