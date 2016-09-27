//
//  StudentModal.h
//  FMDB的操作
//
//  Created by qingyun on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
//学生信息表对应的模型
//模型与表中每个字段有对应的关系
@interface StudentModal : NSObject
@property(nonatomic,assign) NSInteger Id;
@property(nonatomic,strong) NSString *Name;
@property(nonatomic,strong) NSString *Age;
@property(nonatomic,strong) NSString *Phone;
@property(nonatomic,strong) NSString *FamilyAddress;
@end
