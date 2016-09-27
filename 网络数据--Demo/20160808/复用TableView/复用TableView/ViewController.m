//
//  ViewController.m
//  复用TableView
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "TopScrollView.h"
#import "Common.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *leftTable;
@property (nonatomic, strong) UITableView *middleTable;
@property (nonatomic, strong) UITableView *rightTable;
@property (nonatomic, copy) NSArray *leftArr;
@property (nonatomic, copy) NSArray *middleArr;
@property (nonatomic, copy) NSArray *rightArr;
@property (nonatomic, strong) UIScrollView *bottomView;
@property (nonatomic, strong) TopScrollView *topView;
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopView];
    [self setupBottomView];
}
- (void)setupTopView{
    _titles = @[@"首页",@"军事",@"国家",@"国际",@"游戏",@"星座",@"八卦",@"社会"];
    _topView = [[TopScrollView alloc] initWithFrame:CGRectMake(0, 20, kScreenW, 40) Titles:_titles];
    __weak typeof(self) weakSelf;
    _topView.callBack = ^(NSInteger currentIndex){
        weakSelf.currentIndex = currentIndex;
    };
    [self.view addSubview:_topView];
}
- (void)setupBottomView{
    _bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreenW, kScreenH - CGRectGetMaxY(_topView.frame))];
    _bottomView.showsVerticalScrollIndicator = NO;
    _bottomView.showsHorizontalScrollIndicator = NO;
    
    _bottomView.pagingEnabled = YES;
    
    _bottomView.contentSize = CGSizeMake(3*kScreenW, 0);
    [self.view addSubview:_bottomView];
    
    _leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, _bottomView.frame.size.height) style:UITableViewStylePlain];
    _leftTable.delegate = self;
    _leftTable.dataSource = self;
    [_bottomView addSubview:_leftTable];
    
    _middleTable = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW, 0, kScreenW, _bottomView.frame.size.height) style:UITableViewStylePlain];
    _middleTable.delegate = self;
    _middleTable.dataSource = self;
    [_bottomView addSubview:_middleTable];
    
    _rightTable = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW * 2, 0, kScreenW, _bottomView.frame.size.height) style:UITableViewStylePlain];
    _rightTable.delegate = self;
    _rightTable.dataSource = self;
    [_bottomView addSubview:_rightTable];
    
    _bottomView.contentOffset = CGPointMake(0, 0);
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@==%ld",_titles[indexPath.row],(long)indexPath.row];
    
    return cell;
}
- (void)changeTableView{
    if (_currentIndex == 0) {
        _leftArr = _titles[_currentIndex];
        _middleArr = _titles[_currentIndex + 1];
        
        [_leftTable reloadData];
        [_middleTable reloadData];
        self.bottomView.contentOffset = CGPointMake(0, 0);
    }else if (_currentIndex == _titles.count -1) {
        _middleArr = _titles[_currentIndex];
        _rightArr = _titles[_currentIndex +1];
        
        [_rightTable reloadData];
        [_middleTable reloadData];
        self.bottomView.contentOffset = CGPointMake(2*kScreenW, 0);
    }else{
        _leftArr = _titles[_currentIndex-1];
        _middleArr = _titles[_currentIndex];
        _rightArr = _titles[_currentIndex +1];
        
        [_leftTable reloadData];
        [_middleTable reloadData];
        [_rightTable reloadData];
        self.bottomView.contentOffset = CGPointMake(kScreenW, 0);
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:_bottomView]) {
        CGPoint point = _bottomView.contentOffset;
        if (point.x > kScreenW) {
            _currentIndex ++;
            if (_currentIndex > _titles.count - 1) {
                _currentIndex = _titles.count-1;
            }
            [self changeTableView];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
