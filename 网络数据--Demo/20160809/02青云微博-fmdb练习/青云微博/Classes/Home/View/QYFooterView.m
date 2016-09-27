//
//  QYFooterView.m
//  青云微博
//
//  Created by qingyun on 16/7/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYFooterView.h"
#import "QYStatusModel.h"
#import "QYRequestManager.h"
#import "QYAccessToken.h"
#import "MBProgressHUD.h"
@implementation QYFooterView
{
    __weak IBOutlet UIView *_viewBg;
    __weak IBOutlet UIButton *_btnComment;
    __weak IBOutlet UIButton *_btnPraise;
    __weak IBOutlet UIButton *_btnRetweet;
}

+ (instancetype)footerViewWithTableView:(UITableView *)tableView {
    static NSString *strId = @"QYFooterView";
    QYFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:strId];
    if (footer == nil) {
        footer = [[[NSBundle mainBundle] loadNibNamed:@"QYFooterView" owner:nil options:nil] firstObject];
        [footer setValue:strId forKey:@"reuseIdentifier"];
    }
    
    return footer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 当从xib启动时候, 如果重写方法中outlet还没有被赋值
    // 一定要想到awakeFromNib
}

- (void)setStatus:(QYStatusModel *)status {
    _status = status;
    NSLog(@"");
    
    // 如果这个数字大于0 , 显示这个数字, 否则显示原有的转发, 赞, 评论
    [self loadTitle:@"转发" count:status.repostsCount forButton:_btnRetweet];
    [self loadTitle:@"评论" count:status.commentsCount forButton:_btnComment];
    [self loadTitle:@"点赞" count:status.attitudesCount forButton:_btnPraise];
}

- (void)loadTitle:(NSString *)title count:(NSInteger)count forButton:(UIButton *)button {
    if (count == 0) {
        [button setTitle:title forState:UIControlStateNormal];
    } else {
        [button setTitle:[NSString stringWithFormat:@"%ld", count] forState:UIControlStateNormal];
    }
}
//转发微博按钮
-(IBAction)repostBtn:(id)sender{
    //获取accessToken值
    __weak QYFooterView *temp=self;
    QYAccessToken *token=[QYAccessToken shareInstance];
    [[QYRequestManager shareInstance] repostMessage:token.access_token Status:self.status sucess:^(NSMutableArray *arr){
        dispatch_async(dispatch_get_main_queue(), ^{
            [temp showMBProgressHud:@"微博转发成功"];
        });
    } failure:^(NSError *err){
        
    }];
}
//显示风火轮,文本的提示
-(void) showMBProgressHud:(NSString *) strText{
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.vc.view animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.label.text=strText;
    //延迟3s隐藏风火轮
    [hud hideAnimated:YES afterDelay:3];
}
//- (void)didMoveToWindow {
//    [self sendSubviewToBack:_viewBg];
//    
//    //NSTimer *timer;
//    //// 设置计时器触发的日期在很久很久很久之后(你的应用不可能活到那个时候的)
//    //[timer setFireDate:[NSDate distantFuture]];
//    //// 设置现在就开始计时
//    //[timer setFireDate:[NSDate date]];
//}

@end
