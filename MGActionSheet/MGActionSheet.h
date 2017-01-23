//
//  MGActionSheet.h
//  MGActionSheet
//
//  Created by Luqiang on 2017/1/22.
//  Copyright © 2017年 Mango. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MGActionSheet_Alert_Duration 0.3

@interface MGActionSheet : UIView

- (instancetype)initWithSheetView:(UIView *)sheetView sheetHeight:(CGFloat)sheetHeight;
- (void)show;
- (void)hide;

@end
