//
//  ViewController.m
//  Timer_test
//
//  Created by zeb－Apple on 16/12/29.
//  Copyright © 2016年 zeb－Apple. All rights reserved.
//

#import "ViewController.h"
#import "Timer.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
    Timer *timer;
    UIRefreshControl*_control;
    BOOL _isLoading;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"-1",@"-1",@"-1"];
    self.dataArray = [NSMutableArray arrayWithArray:arr];
    [self createTableView];
    timer = [Timer sharedTimer];
    [timer countDownWithTableView:_tableView dataSource:self.dataArray];

    //刷新的控件
    
    _control=[[UIRefreshControl alloc] init];
    
    [_tableView addSubview:_control];
    
    [_control addTarget:self action:@selector(refresh)forControlEvents:UIControlEventValueChanged];
    
}
//刷新时调用的方法

-(void)refresh

{
    
    if(_isLoading)
        
    {
        
        [_control endRefreshing];
        
        return;
        
    }
    //模拟下载数据
    
    _isLoading=YES;
    NSArray *arr = @[@"-1"];
    [self.dataArray addObjectsFromArray:arr];
    
    [_tableView reloadData];
    
    [_control endRefreshing];
    
    _isLoading=NO;
    
}
#pragma mark -
#pragma mark 创建UITableView
- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma mark -
#pragma mark 返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
#pragma mark -
#pragma mark 返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
#pragma mark -
#pragma mark UITableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.index = indexPath.row;
    cell.dataArray = self.dataArray;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:@"10"];
    [_tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 60;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
