//
//  Timer.h
//  Timer_test
//
//  Created by zeb－Apple on 16/12/29.
//  Copyright © 2016年 zeb－Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Timer : NSObject


+ (instancetype)sharedTimer;
///每秒走一次，回调block
-(void)countDownWithZEBBlock:(void (^)())ZEBBlock;
- (void)countDownWithTableView :(UITableView *)tableView dataSource:(NSMutableArray *)dataSource;
@end
