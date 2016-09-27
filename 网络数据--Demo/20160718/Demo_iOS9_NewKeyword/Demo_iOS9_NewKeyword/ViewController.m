//
//  ViewController.m
//  Demo_iOS9_NewKeyword
//
//  Created by qingyun on 16/7/16.
//  Copyright © 2016年 qingyun. All rights reserved.
//

// null: nil

// nonnull: 修饰的变量设置值的时候不能为空
// nullable: 修饰的变量设置值的时候可以能为空
// null_resettable: 返回值一定有值,不为空, 可以随便设置



// 使用的位置

/** 属性 */
// ①属性中, 与nonatomic同等级 nonnull/nullable
// ②属性的星号之后, 属性名之前 _Nonnull/_Nullable

/** 方法返回值: 应用方式: 数据源 */
// ③方法返回值类型之前 nonnull/nullable
// ④方法返回值的星号之后 _Nonnull/_Nullable

/** 方法的参数 */
// ⑤方法参数类型之前 nonnull
// ⑥方法参数类型的星号之后 _Nonnull

#import "ViewController.h"

#import "Chinese.h"

@interface ViewController () <NSObject>

@property (nonatomic, copy) NSMutableArray<__kindof NSString *> *names;

//@property (nonatomic, nonnull, copy) NSString *strName;
@property (nonatomic, copy, null_resettable) NSString * strName;

@end

@implementation ViewController

- (NSString *)strName {
    return @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.strName = @"";
    
    //_Null_unspecified: 不能确定是调用该属性的setter方法还是调用这个属性的getter方法
    //self.strName
    
    // self.names = @[@78, @8.3, @"嘿嘿"];
    
    [self.names addObject:@89];
}

//- (NSString * _Nonnull)strColor {
//    return @"red";
//}

- (void)loadPersonWithName:(NSString * _Nonnull)name {
    self.view = nil;
}

@end
