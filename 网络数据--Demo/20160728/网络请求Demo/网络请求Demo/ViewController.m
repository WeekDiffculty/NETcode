//
//  ViewController.m
//  网络请求Demo
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "HotModel.h"
#import "HotCell.h"
#define APIURL @"http://www.zhihuiluanchuan.com/index.php?s=/Api/document/zxrd"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *datas;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (NSArray *)datas
{
    if (!_datas) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        NSDictionary *dict = @{@"page":@(2)};
        [manager GET:APIURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray *data = responseObject[@"data"];
            NSMutableArray *muarr = [NSMutableArray array];
            for (NSDictionary *dict in data) {
                HotModel *model = [HotModel modelWithDictionary:dict];
                [muarr addObject:model];
                NSLog(@"%@",model.description);
                
            }
            _datas = muarr;
            
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];

    }
    return _datas;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.estimatedRowHeight = 80;
        [self.view addSubview:tableView];
        tableView.backgroundColor = [UIColor greenColor];
        _tableView = tableView;
    }
    
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *identifier = @"hotCell";
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HotCell" owner:nil options:nil][0];
    }
    [cell setModel:self.datas[indexPath.row]];
    
    return cell;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:self.tableView]) {
        if (self.tableView.contentOffset.y > self.tableView.contentSize.height - self.tableView.frame.size.height) {
            NSLog(@"刷新啦");
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
