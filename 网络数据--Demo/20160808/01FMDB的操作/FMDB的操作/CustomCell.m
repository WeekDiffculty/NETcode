//
//  CustomCell.m
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) updateCell:(StudentModal *) student{
    nameLbl.text=student.Name;
    ageLbl.text=student.Age;
    phoneLbl.text=student.Phone;
    familyLbl.text=student.FamilyAddress;
}

@end
