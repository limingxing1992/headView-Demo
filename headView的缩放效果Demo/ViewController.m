//
//  ViewController.m
//  headView的缩放效果Demo
//
//  Created by qianfeng on 15/12/3.
//  Copyright © 2015年 李明星. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIView *headView;

@property (strong, nonatomic) UIImageView *topImageView;

@property (strong, nonatomic) NSMutableArray *arry;

//记录头部视图Y坐标和高度
@property (assign, nonatomic) CGFloat originalY;

@property (assign, nonatomic) CGFloat sizeHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arry = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < 20; i++) {
        
        NSString *str = [NSString stringWithFormat:@"我是李明星:%ld",i];
        [self.arry addObject:str];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    
    //创建头部视图
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), 200)];
    self.tableView.tableHeaderView = self.headView;
    
    self.topImageView = [[UIImageView alloc] initWithFrame:self.headView.bounds];
    [self.topImageView setImage:[[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    self.topImageView.contentMode = UIViewContentModeScaleToFill;
    //自动调整布局
    self.topImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.headView addSubview:self.topImageView];
    
    //记录初始值
    self.originalY = self.topImageView.frame.origin.y;
    self.sizeHeight = self.topImageView.frame.size.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------tableview 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];

    cell.textLabel.text = self.arry[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"%f",offsetY);
    
    if (scrollView == self.tableView) {
        
        CGRect frame = self.topImageView.frame;
        
        if (offsetY < 0) {
            
            frame.origin.y = offsetY;
            frame.size.height = self.sizeHeight - offsetY;
            
            self.topImageView.frame = frame;
        }else{
            frame.origin.y = self.originalY + offsetY;
            frame.size.height = self.sizeHeight - offsetY;
            
            self.topImageView.frame = frame;
        }
    }
}
@end
