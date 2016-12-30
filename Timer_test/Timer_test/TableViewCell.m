//
//  TableViewCell.m
//  Timer_test
//
//  Created by zeb－Apple on 16/12/30.
//  Copyright © 2016年 zeb－Apple. All rights reserved.
//

#import "TableViewCell.h"
#import "Timer.h"

@interface TableViewCell ()


@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    self.label = [[UILabel alloc] init];
    self.label.frame = self.frame;
    self.label.backgroundColor = [UIColor whiteColor];
    self.label.textColor = [UIColor blackColor];
    [self addSubview:self.label];
    
}
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    if ([_dataArray[_index] integerValue] > 0) {
        self.label.hidden = NO;
       self.label.text = _dataArray[_index];
    }else {
        self.label.hidden = YES;
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
