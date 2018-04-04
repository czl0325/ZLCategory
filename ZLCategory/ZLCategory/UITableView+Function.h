//
//  UITableView+Function.h
//  SevenDressHD
//
//  Created by czl on 15/11/25.
//  Copyright © 2015年 chi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Function)

//是否隐藏多余的cell
@property (nonatomic,assign) BOOL hideExtraCell;

//IOS11 tableview的通用设置
- (void)commonSetTableView;

//当UITableView没有数据的时候需要展示的内容
- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
