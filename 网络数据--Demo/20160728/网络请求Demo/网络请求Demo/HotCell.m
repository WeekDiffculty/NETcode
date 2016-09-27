//
//  HotCell.m
//  网络请求Demo
//
//  Created by qingyun on 16/7/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotCell.h"
#import "HotModel.h"
#import "UIImageView+WebCache.h"
@implementation HotCell

- (void)setModel:(HotModel *)model
{
    _model = model;
    _title.text = model.title;
    _origin.text = model.origin;
    NSURL *url = [NSURL URLWithString:model.cover];
    [_cover sd_setImageWithURL:url];
    
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
