//
//  ViewController.m
//  01-XMLParseDemo
//
//  Created by qingyun on 16/8/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "BookModal.h"
#import "GDataXMLNode.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataArr=[NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//xml解析
-(IBAction)parseXMLBtn:(id)sender{
    //1.创建对象GDataXMLDocument
    NSString *xmlPath=[[NSBundle mainBundle] pathForResource:@"bookstore" ofType:@"xml"];
    NSData *xmlData=[NSData dataWithContentsOfFile:xmlPath];
   GDataXMLDocument *xmlDoc =[[GDataXMLDocument alloc] initWithData:xmlData options:0 error:nil];
    //2.获取根节点
    GDataXMLElement *rootElement=[xmlDoc rootElement];
    //3.取出rootElement的子节点
    NSArray *arrBook=[rootElement elementsForName:@"book"];
    
    for (GDataXMLElement *element in arrBook) {
        //1.属性值
        BookModal *book=[[BookModal alloc] init];
        GDataXMLNode *nodeCategory =[element attributeForName:@"category"];
        book.category=[nodeCategory stringValue];
        NSLog(@"属性值%@",book.category);
        //2.title值
        NSArray *eleTitleArr=[element elementsForName:@"title"];
        GDataXMLElement *titleElement=eleTitleArr[0];
        book.title=[titleElement stringValue];
        book.lan=[[titleElement attributeForName:@"lang"] stringValue];
        //3.author值
        GDataXMLElement *authorElement=[element elementsForName:@""][0];
        book.author=[authorElement stringValue];
        
        //4.year值
        GDataXMLElement *yearElement=[element elementsForName:@"year"][0];
        book.year=[yearElement stringValue];
        //5. price 值
        GDataXMLElement *priceElement=[element elementsForName:@"price"][0];
        book.price=[priceElement stringValue];
        [dataArr addObject:book];
        
        NSLog(@"title %@ lan %@ author %@ year%@ price%@",book.title,book.lan,book.author,book.year,book.price);
    }
    NSLog(@"数组获取的元素个数%ld",dataArr.count);
}

@end
