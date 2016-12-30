//
//  Timer.m
//  Timer_test
//
//  Created by zeb－Apple on 16/12/29.
//  Copyright © 2016年 zeb－Apple. All rights reserved.
//

#import "Timer.h"
#import "TableViewCell.h"

@interface Timer ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) NSMutableArray *dataSource;
@end

@implementation Timer

+ (instancetype)sharedTimer {
    static Timer *timer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timer = [[self alloc] init];
    });
    return timer;
}
- (instancetype)init {
    self = [super init];
    if (self) {
     //   [self createTimer];
    }
    return self;
}
/// 回传时间的变化
-(void)countDownWithZEBBlock:(void (^)())ZEBBlock{
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                ZEBBlock(); // 回传时间的变化
            });
        });
        dispatch_resume(_timer); // 启动定时器
    }
}
- (void)countDownWithTableView :(UITableView *)tableView dataSource:(NSMutableArray *)dataSource {
    
    self.tableView = tableView;
    self.dataSource = dataSource;
    if (self.timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(self.timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *arr = tableView.visibleCells; //取出屏幕可见ceLl
                NSMutableArray  *tempCells = [NSMutableArray arrayWithArray:arr];
              
                [tempCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    if ([obj isKindOfClass:[TableViewCell class]]) {
                        TableViewCell *cell1 = (TableViewCell *)obj;
                        NSString *str = cell1.label.text;
                        NSInteger i = [str integerValue];
                        NSString *string = [NSString stringWithFormat:@"%ld",--i];
                        cell1.label.text = string;
                        
                        if ([string integerValue] == 0) {
                            *stop = YES;
                            if (*stop == YES) {
                                [tempCells removeObject:cell1];
                            }
                            [self.dataSource removeObjectAtIndex:cell1.index];
                            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cell1.index inSection:0];
                            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                            [tableView reloadData];
                        }else {
                            [self.dataSource replaceObjectAtIndex:cell1.index withObject:string];
                        }
                    }
                    
                    if (*stop) {
                        
                        NSLog(@"array is %@",tempCells);
                        
                    }
                    
                }];

            });
        });
        dispatch_resume(_timer); // 启动定时器
    }
    
}
- (void)dealloc {
    dispatch_cancel(self.timer);
    _timer = nil;
}
@end
