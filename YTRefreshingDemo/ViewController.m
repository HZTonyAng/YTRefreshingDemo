//
//  ViewController.m
//  YTRefreshingDemo
//
//  Created by TonyAng on 16/4/5.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import "ViewController.h"
#import "YTSunnyRefreshController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *ytTableView;

@property (nonatomic, strong) YTSunnyRefreshController *sunnyRefreshController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"YTRefresh";
    self.navigationController.navigationBar.translucent = NO;
    [self createNavigationItem];
    [self createTableView];
    [self setupRefreshControl];
}
-(void)createNavigationItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(show:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结束" style:UIBarButtonItemStylePlain target:self action:@selector(hiden:)];
}

- (void)show:(id)sender
{
    [self.sunnyRefreshController beginRefreshing];
}

- (void)hiden:(id)sender
{
    [self.sunnyRefreshController endRefreshing];
}

-(void)createTableView{
    _ytTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _ytTableView.delegate = self;
    _ytTableView.dataSource = self;
    _ytTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_ytTableView];
}

#pragma mark -
#pragma mark 返回某个分区的单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

#pragma mark -
#pragma mark 返回有多少分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -
#pragma mark 返回一个分区有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark -
#pragma mark 返回表的单元格对象
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"identifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        // 设置单元格附件样式
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1.0];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"你点击了第%ld分区第%ld行", indexPath.section ,indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

# pragma mark - YALSunyRefreshControl methods

-(void)setupRefreshControl{
    
    self.sunnyRefreshController = [YTSunnyRefreshController new];
    [self.sunnyRefreshController addTarget:self
                                 action:@selector(sunnyControlDidStartAnimation)
                       forControlEvents:UIControlEventValueChanged];
    [self.sunnyRefreshController attachToScrollView:self.ytTableView];
}

-(void)sunnyControlDidStartAnimation{
    // start loading something
    NSLog(@"下拉刷新。。。。。");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
