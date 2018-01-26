//
//  UITableView+Function.m
//  SevenDressHD
//
//  Created by czl on 15/11/25.
//  Copyright © 2015年 chi. All rights reserved.
//

#import "UITableView+Function.h"

@implementation UITableView (Function)

- (BOOL)hideExtraCell {
    return NO;
}

- (void)setHideExtraCell:(BOOL)hideExtraCell {
    if (hideExtraCell) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    }
}

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount {
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
