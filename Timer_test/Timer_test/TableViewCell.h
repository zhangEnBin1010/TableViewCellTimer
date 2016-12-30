//
//  TableViewCell.h
//  Timer_test
//
//  Created by zeb－Apple on 16/12/30.
//  Copyright © 2016年 zeb－Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableViewCell : UITableViewCell

@property (nonatomic, weak) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UILabel *label;


@end
