//
//  ViewController.m
//  MGActionSheetExample
//
//  Created by Luqiang on 2017/1/23.
//  Copyright © 2017年 Mango. All rights reserved.
//

#import "ViewController.h"
#import "MGActionSheet.h"
#import "MGActionSheetView_1.h"

@interface ViewController ()

@property (nonatomic, strong) MGActionSheetView_1 *sheetView_1;

@end

@implementation ViewController

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //actionSheetView_1
        MGActionSheet *actionSheet = [[MGActionSheet alloc] initWithSheetView:self.sheetView_1 sheetHeight:200.0f];
        self.sheetView_1.actionSheet = actionSheet;
        [actionSheet show];
        return;
    }
}

- (MGActionSheetView_1 *)sheetView_1 {
    if (!_sheetView_1) {
        _sheetView_1 = [MGActionSheetView_1 new];
    }
    return _sheetView_1;
}

@end
