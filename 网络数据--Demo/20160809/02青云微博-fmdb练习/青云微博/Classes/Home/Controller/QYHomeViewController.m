//
//  QYHomeViewController.m
//  青云微博
//
//  Created by qingyun on 16/7/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//

// 1, 先搭建UI

#import "QYHomeViewController.h"
#import "QYStatusModel.h"
#import "QYStatusCell.h"
#import "QYFooterView.h"
#import "QYDetailViewController.h"
#import "QYLoginViewController.h"
#import "QYAccessToken.h"
#import "QYRequestManager.h"
#import "StudatusDb.h"
@interface QYHomeViewController () <NSObject>

/** 很多条微博的模型 */
@property (nonatomic, copy) NSArray *arrStatusModels;

@end

@implementation QYHomeViewController

- (NSArray *)arrStatusModels {
    if (!_arrStatusModels) {
        NSString *strFilePath=[[NSBundle mainBundle] pathForResource:@"status" ofType:@"plist"];
        NSDictionary *dicStatuses=[NSDictionary dictionaryWithContentsOfFile:strFilePath];
        NSArray *arrStatuses=dicStatuses[@"statuses"];
        NSMutableArray *arrMStatusModels=[NSMutableArray arrayWithCapacity:arrStatuses.count];
        for (NSDictionary *dicData in arrStatuses) {
            QYStatusModel *status = [QYStatusModel statusModelWithDictionary:dicData];
            [arrMStatusModels addObject:status];
        }
        _arrStatusModels = [arrMStatusModels copy];
    }
    return _arrStatusModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    //判断accessToken是否存在,如果存在就在sqlite数据库中查询主页中所有的记录
    if ([QYAccessToken shareInstance].access_token) {
        _arrStatusModels=[[StudatusDb shareIntance] Query];
        [self.tableView reloadData];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    //1.判断accessToken值是否存在
    NSLog(@"viewWillAppear %@",[QYAccessToken shareInstance].access_token);
    if ([QYAccessToken shareInstance].access_token) {
        //导航条右侧按钮置空,不显示
        self.navigationItem.rightBarButtonItem=nil;
        [self requestHomeList];
    }
}
-(void) rightBtn:(id)sender{
    QYLoginViewController *lgVC=[[QYLoginViewController alloc] init];
    [self.navigationController pushViewController:lgVC animated:YES];
}

/** 加载默认设置和UI */
- (void)loadDefaultSetting {
    [self.view setBackgroundColor:QLColorWithRGB(239, 239, 244)];
    // 自动设置当前控制器中的ScrollView的内边距(UIEdgeInsets)
    //[self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.tableView.estimatedRowHeight = 40;
    self.tableView.sectionFooterHeight = 30;
}

-(void) requestHomeList{
    __weak QYHomeViewController *home=self;
    //在此不用afnetworking请求服务器,用RequestManager中封装的方法
    [[QYRequestManager shareInstance] request_HomeList:[QYAccessToken shareInstance].access_token sucess:^(NSMutableArray *arrList){
        //微博的主页数据保存至数据库sqlite
       [[StudatusDb shareIntance] InsertStatues:arrList];
        //刷新ui
        dispatch_async(dispatch_get_main_queue(), ^{
            self.arrStatusModels=arrList;
            
            [home.tableView reloadData];
        });
    } failure:^(NSError *err){
    
    }];
}
#pragma mark - 🔌 Delegate Methods
/** TableView中有多少个Section(分组) */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrStatusModels.count;
}
/** 在当前的Section中有多少cell(row) */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// 只要dequeue的方法中有IndexPath, 就说明, 这个cell不是通过注册, 就是通过Storyboard中ProtoType类型创建的
/** 在IndexPath位置显示的cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYStatusCell *cell = [QYStatusCell cellWithTableView:tableView];
    
    QYStatusModel *status = self.arrStatusModels[indexPath.section];
    cell.status = status;
    //// textLabel是懒加载的
    //cell.textLabel.text = status.strText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消IndexPath位置cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    QYDetailViewController *vcDetail = [QYDetailViewController new];
    vcDetail.status = self.arrStatusModels[indexPath.section];
    [self.navigationController pushViewController:vcDetail animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    QYFooterView *footer = [QYFooterView footerViewWithTableView:tableView];
    footer.contentView.backgroundColor = [UIColor whiteColor];
    footer.status = self.arrStatusModels[section];
    footer.vc=self;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    } else {
        return 20;
    }
}

@end
